require "foodcritic"
require "rspec/core/rake_task"

desc "Run Foodcritic lint checks"
FoodCritic::Rake::LintTask.new(:lint) do |t|
  t.options = { :fail_tags => ["any"] }
end

desc "Run ChefSpec examples"
RSpec::Core::RakeTask.new(:spec)

desc "Run all tests"
task :test => [:lint, :spec]
task :default => :test


begin
  require 'kitchen/rake_tasks'
  Kitchen::RakeTasks.new
rescue LoadError
  puts ">>>>> Kitchen gem not loaded, omitting tasks" unless ENV['CI']
end
