source 'https://rubygems.org'

gem 'berkshelf'
gem 'kitchen-vagrant'
gem 'chefspec'
gem 'rake'
gem 'foodcritic'
gem 'chef'
gem 'rubocop'

gem 'kitchen-transport-speedy'
group :ec2 do
  gem 'test-kitchen'
  gem 'kitchen-ec2', git: 'https://github.com/criteo-forks/kitchen-ec2.git', branch: 'criteo'
  gem 'winrm',       '>= 1.6'
  gem 'winrm-fs',    '>= 0.3'
  gem 'dotenv'
end

# Other gems should go after this comment
gem 'inspec'
gem 'kitchen-inspec'
gem 'cookbook-release'
gem 'kitchen-dokken'
