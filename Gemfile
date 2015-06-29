# This is primarily here for the CI server, so that it can create
# the necessary environment to run the tests in. If you are using ChefDK,
# you do not need to run `bundle install`, as all these tools are already
# included (via `chef exec`)

source 'https://rubygems.org'

gem 'berkshelf'
gem 'semverse'
gem 'chef'
gem 'chef-zero'
gem 'foodcritic'
gem 'rake-chef-syntax'
gem 'chefspec'
gem 'rubocop'
gem 'stove'
gem 'yarjuf'

group :integration do
  gem 'test-kitchen'
  gem 'kitchen-vagrant'
  gem 'kitchen-docker'
end
