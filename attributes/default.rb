# Cookbook Name:: kernel-modules
# Author:: Jeremy MAURO <j.mauro@criteo.com>
#
# Copyright 2016, Criteo.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Using the RedHat documentation:
# Ref:
#   RHEL 7:
#   https://access.redhat.com/documentation/en-US/Red_Hat_Enterprise_Linux/7/html/System_Administrators_Guide/sec-Persistent_Module_Loading.html
#   https://access.redhat.com/documentation/en-US/Red_Hat_Enterprise_Linux/7/html/System_Administrators_Guide/sec-Setting_Module_Parameters.html
#
#   RHEL 6:
#   https://access.redhat.com/documentation/en-US/Red_Hat_Enterprise_Linux/6/html/Deployment_Guide/sec-Persistent_Module_Loading.html
#   https://access.redhat.com/documentation/en-US/Red_Hat_Enterprise_Linux/6/html/Deployment_Guide/sec-Loading_a_Customized_Module-Persistent_Changes.html

# Packages requirements
default['kernel_modules']['packages'] = value_for_platform_family(
  rhel: value_for_platform(
    %w[centos redhat oracle] => {
      '~> 6.0' => [
        'initscripts',       # rpm -q --whatprovides /etc/sysconfig/modules
        'module-init-tools', # rpm -q --whatprovides /sbin/modprobe /etc/modprobe.d
      ],
      '~> 7.0' => [
        'systemd',           # rpm -q --whatprovides /etc/modules-load.d
        'kmod',              # rpm -q --whatprovides /etc/modprobe.d
      ],
    },
    'default'         => [
      'kmod',
    ],
  ),
)

# Modules init loading requirements
default['kernel_modules']['modules_load.d'] = value_for_platform_family(
  rhel: value_for_platform(
    %w(centos redhat) => {
      '~> 7.0' => '/etc/modules-load.d',
      '~> 6.0' => '/etc/sysconfig/modules',
    },
  ),
  default: nil,
)

# Modules loading options requirements
default['kernel_modules']['modprobe.d'] = '/etc/modprobe.d'

default['kernel_modules']['modules'] = {}
