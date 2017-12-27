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
default['kernel_modules']['modules']['lp']['blacklist'] = true
default['kernel_modules']['modules']['firewire-core']['check_availability'] = true
default['test-module']['action'] = []
default['test-module']['onboot'] = true

case node['platform_version']
when /^6/
  default['kernel_modules']['modules']['nfs'] = {
    options: [
      'enable_ino64=1',
      'nfs4_disable_idmapping=0',
    ],
    alias:   'nfs4',
  }
when /^7/
  default['kernel_modules']['modules']['btusb'] = {
    options: [
      'reset=1',
      'ignore_sniffer=0',
    ],
    alias:   'btusb1',
  }
end

default['kernel_modules']['modules']['tulip'] = {
  options: 'tulip_debug=1',
}

node['kernel_modules']['modules'].each_key do |mod|
  default['kernel_modules']['modules'][mod]['action'] = node['test-module']['action'].map(&:to_sym)
  default['kernel_modules']['modules'][mod]['onboot'] = node['test-module']['onboot'] ? true : false
end
