source 'https://rubygems.org'

gem 'rake'
gem 'chef', '~> 12.5'
gem 'berkshelf'
gem 'kitchen-inspec'

group :test do
  gem 'foodcritic'
  gem 'rubocop'
end

group :integration do
  gem 'vagrant-wrapper'
  gem 'test-kitchen'
  gem 'kitchen-vagrant'
  gem 'chefspec'
end

group :ec2 do
  gem 'test-kitchen'
  gem 'kitchen-ec2', :git => 'https://github.com/criteo-forks/kitchen-ec2.git', :branch => 'criteo'
  gem 'winrm',      '~> 1.6'
  gem 'winrm-fs',   '~> 0.3'
end
