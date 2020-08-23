#
# Cookbook Name:: managed_directory
# Recipe:: t_resource_name_symbol
#
# used by chefspec

testdir = '/tmp/baz'

# Create the directory for our test files, during the compile phase.
directory testdir do
  action :nothing
end.run_action(:create)

# Define the managed_directory
managed_directory testdir do
  action :clean
end

log :test do
  message 'LOG: t_resource_name_symbol test.'
end
