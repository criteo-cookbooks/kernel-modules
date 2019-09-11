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

require(File.expand_path('../../helpers/inspec/spec_helper', File.dirname(__FILE__)))

# Making sure blacklist module not loaded
describe kernel_modules('lp') do
  it { should_not be_loaded }
end

# Making sure unavailable firewire-core module is not loaded
describe kernel_modules('firewire-core') do
  it { should_not be_loaded }
end

describe file(module_path(:init, 'firewire-core')) do
  it { should_not exist }
end

describe file(module_path(:load, 'firewire-core')) do
  it { should_not exist }
end

if os[:release].to_i == 7
  # Testing module
  describe kernel_modules('btusb') do
    it { should be_loaded }
  end

  # Testion module options
  describe file('/sys/module/btusb/parameters/ignore_sniffer') do
    its('content') { should match 'N' }
  end

  describe file('/sys/module/btusb/parameters/reset') do
    its('content') { should match 'Y' }
  end

  # Shouldn't be any init module script
  describe file(module_path(:init, 'btusb')) do
    it { should_not exist }
  end

  describe file(module_path(:load, 'btusb')) do
    it { should exist }
  end

elsif os[:release].to_i == 6
  describe kernel_modules('nfs') do
    it { should be_loaded }
  end

  describe file('/sys/module/nfs/parameters/enable_ino64') do
    its('content') { should match 'Y' }
  end

  describe file('/sys/module/nfs/parameters/nfs4_disable_idmapping') do
    its('content') { should match 'N' }
  end

  # Shouldn't be any init module script
  describe file(module_path(:init, 'nfs')) do
    it { should_not exist }
  end

  describe file(module_path(:load, 'nfs')) do
    it { should exist }
  end
end
