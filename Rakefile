require 'bundler'
require 'rubocop/rake_task'
require 'foodcritic'
require 'rspec/core/rake_task'
require 'stove/rake_task'
require 'chef/knife'

desc 'Run all tests except Kitchen (default task)'
task integration: [:rubocop, :foodcritic, :spec]
task default: :integration

desc 'Run linters'
task lint: [:rubocop, :foodcritic]

desc 'Run all tests'
task test: [:integration, :acceptance]

# ChefSpec
desc 'Run ChefSpec tests'
task :spec do
  puts 'Running chefspec tests...'
  RSpec::Core::RakeTask.new(:spec) do |t|
    # t.rspec_opts = %w[-f JUnit -o results.xml]
    t.rspec_opts = %w[--color]
  end
end

# Foodcritic
desc 'Run foodcritic lint checks'
task :foodcritic do
  puts 'Running foodcritic...'
  FoodCritic::Rake::LintTask.new do |t|
    t.options = { :fail_tags => ["correctness"] }
    puts 'done.'
  end
end

# Rubocop
desc 'Run Rubocop lint checks'
task :rubocop do
  RuboCop::RakeTask.new
end

# Test Kitchen
begin
  require 'kitchen/rake_tasks'
  Kitchen::RakeTasks.new

  desc 'Alias for kitchen:all'
  task acceptance: 'kitchen:all'

rescue LoadError
  puts '>>>>> Kitchen gem not loaded, omitting tasks' # unless ENV['CI']
end

desc 'Release and Publish'
task :release do
  if File.exist?("#{ENV['HOME']}/.stove")
    require 'stove/rake_task'
    Stove::RakeTask.new(:release)
  else
    puts "Please use 'stove login' before attempting to release."
  end
end
