#
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

require 'chef/mixin/shell_out'
include Chef::Mixin::ShellOut

resource_name :kernel_module
allowed_actions :configure, :load, :unload, :remove

default_action :load

# Module name
property :module_name, kind_of: String, name_property: true
# Module will be load at boot time
property :onboot, kind_of: [TrueClass, FalseClass], default: true
# Allow the module reload in case of options changes
property :reload, kind_of: [TrueClass, FalseClass], default: false
# Allow to force reload the module. This options is only useful when 'reload' is
# enable
property :force_reload, kind_of: [TrueClass, FalseClass], default: false

# Type of modprobe resource_name (man modprobe.conf)
property :alias, kind_of: [String, Array, NilClass], default: nil
property :options, kind_of: [String, Array, NilClass], default: nil
property :install, kind_of: [String, NilClass], default: nil
property :remove, kind_of: [String, NilClass], default: nil
property :blacklist, kind_of: [TrueClass, FalseClass, NilClass], default: nil
property :check_availability, kind_of: [TrueClass, FalseClass], default: false

def blacklisted?
  # Ref:
  # https://access.redhat.com/documentation/en-US/Red_Hat_Enterprise_Linux/6/html/Deployment_Guide/Blacklisting_a_Module.html
  blacklist || install == '/bin/true' || install == '/bin/false'
end

def loaded?
  @loaded ||= shell_out("/sbin/lsmod | grep -q -w ^#{module_name}").exitstatus == 0
end

def available?
  ::Dir.glob(::File.join('/', 'lib', 'modules', node['kernel']['release'], '**', "#{module_name}.ko")).size == 1
end
