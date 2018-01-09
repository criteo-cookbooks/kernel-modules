kernel-modules Cookbook
=======================

[![Cookbook Version][cookbook_version]][cookbook]
[![Build Status][build_status]][build_status]

Configure and Load kernel modules.

Requirements:
-------------
### Platforms
* CentOS 6.x/7.x
* RHEL 6.x/7.x
* OEL 6.x/7.x

### Chef
* Chef version: >= 12.5.1

Attributes
----------
#### kernel_modules
* `node['kernel_modules']['packages']` - used to make the packages requirements
* `node['kernel_modules']['modules_load.d']` - used to define the `modules_load.d` directory
* `node['kernel_modules']['modprobe.d']` - use to define the `modprobe.d` directory
* `node['kernel_modules']['modules']` - use to define the list of modules you want to load/configure

Usage
-----
Using this cookbook will load and configure every module in the attribute: `node['kernel_modules']['modules']`.

For instance:
``` ruby
$ cat roles/modules.rb
name 'Load modules'
description 'Example for using kernel modules'

run_list(
  'kernel-modules'
)

default_attributes(
kernel_modules:
  modules: {
    nfs: {
      options: [
        'enable_ino64=1',
        'nfs4_disable_idmapping=0',
      ],
      alias: 'nfs4',
      action: [:load],
      onboot: true,
    },
  },
)
```
Providers & Resources
---------------------
## kernel_module
This provider allows to configure and load a kernel module

### Actions
Action   | Description
---------|---------------------------
configure | Add the module at boot time (if needed) and set the module's modprobe configuration file
load | Load the module once it is configured (When used the `configure` action will be implicitly launched before)
unload| Unload the module
remove| Remove the modprobe configuration file and remove the module at boot time

### Property
Name | Description | Default| Type
-----|-------------|--------|-----
`module_name`| module name| name |_String_
`onboot`| load the module at boot time| true| _Boolean_
`reload`| allow the module to be reloaded if module configuration changes| false| _Boolean_
`force_reload`| allow the module to be unloaded even if the module is used[^1]. | false | _Boolean_
`alias`| set the modprobe command _alias_| nil| _Array_/_String_
`options`| set the modprobe command _options_| nil| _Array/String/NilClass_
`install`| set the modprobe command _install_| nil| _String/NilClass_
`remove`| set the modprobe command _remove_| nil| _String/NilClass_
`blacklist`| set the modprobe command _blacklist_| nil| _Boolean/NilClass_
`check_availability`| before loading or configuring, ensure the module is available on disk for the running kernel| false| _Boolean_

For instance:
``` ruby
# To load and configure "mlx4_en"
kernel_module 'mlx4_en' do
  onboot true  # Make the loading persistent
  reload false # We don't want to reload our network module
  options %w(inline_thold=120 udp_rss=1) # Specific loading options
  check_availability true # Only load and configure when module is present
end

# To blacklist a module
kernel_module 'pcspkr' do
  onboot true
  blacklist true
end
```
Contributing
------------
1. Fork the [repository on Github][repository]
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github


License and Authors
-------------------
Authors: [Jeremy Mauro][author] (<j.mauro@criteo.com>)

```text
Copyright 2014-2015, Criteo.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
[^1]*Note*: it has no effect unless CONFIG_MODULE_FORCE_UNLOAD was set when the kernel was compiled

[author]:                   https://github.com/jmauro
[repository]:               https://github.com/criteo-cookbooks/kernel-modules
[build_status]:             https://api.travis-ci.org/criteo-cookbooks/kernel-modules.svg?branch=master
[cookbook_version]:         https://img.shields.io/cookbook/v/kernel-modules.svg
[cookbook]:                 https://supermarket.chef.io/cookbooks/kernel-modules
