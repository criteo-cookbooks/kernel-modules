name             'kernel-modules'
maintainer       'Criteo'
maintainer_email 'sre-core@criteo.com'
license          'Apache-2.0'
description      'Manage kernel modules on linux'
long_description 'kernel-modules Cookbook
Configure and Load kernel modules.
'
issues_url       'https://github.com/criteo-cookbooks/kernel-modules/issues' if respond_to?(:issues_url)
source_url       'https://github.com/criteo-cookbooks/kernel-modules' if respond_to?(:source_url)
version          '2.0.5'
supports         'redhat', '>= 6.0'
supports         'centos', '>= 6.0'
supports         'ubuntu'
chef_version     '>= 12.5' if respond_to?(:chef_version)
