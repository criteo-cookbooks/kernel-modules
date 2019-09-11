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

if defined?(ChefSpec)
  ChefSpec.define_matcher :kernel_modules
  def configure_kernel_module(resource)
    ChefSpec::Matchers::ResourceMatcher.new(:kernel_modules, :configure, resource)
  end

  def load_kernel_module(resource)
    ChefSpec::Matchers::ResourceMatcher.new(:kernel_modules, :load, resource)
  end

  def unload_kernel_module(resource)
    ChefSpec::Matchers::ResourceMatcher.new(:kernel_modules, :unload, resource)
  end

  def remove_kernel_module(resource)
    ChefSpec::Matchers::ResourceMatcher.new(:kernel_modules, :remove, resource)
  end
end
