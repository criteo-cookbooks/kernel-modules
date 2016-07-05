name               'kernel-modules'
maintainer         'Criteo'
maintainer_email   'sre-core@criteo.com'
license            'Apache v2.0'
description        'Manage kernel modules on linux'
long_description   IO.read(File.join(File.dirname(__FILE__), 'README.md'))
issues_url         'https://github.com/criteo-cookbooks/kernel-modules.git'  if respond_to?(:issue_url)
source_url         'https://github.com/criteo-cookbooks/kernel-modules.git'  if respond_to?(:source_url)
version            '0.2.1'
chef_version       '>= 12.5.1' if respond_to?(:chef_version)
supports           'rhel', '>= 6.0'
supports           'centos', '>= 6.0'
