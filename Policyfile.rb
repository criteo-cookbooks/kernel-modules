name 'kernel-modules'

run_list ['kernel-modules']
named_run_list :test, run_list + ['recipe[test-module]']

default_source :community

# Current cookbook
cookbook 'kernel-modules', path: '.'
# Test cookbooks
cookbook 'test-module', path: 'test/cookbooks/test-module'
