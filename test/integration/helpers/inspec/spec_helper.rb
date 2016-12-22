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

def module_path(type, distrib_version, module_name)
  if os[:family] == 'redhat'
    if type == :load
      return ::File.join('/etc/modprobe.d', module_name + '.conf')
    end
    if distrib_version == 6
      return ::File.join('/etc/sysconfig/modules', module_name + '.modules')
    else
      return ::File.join('/etc/modules-load.d', module_name + '.conf')
    end
  end
end
