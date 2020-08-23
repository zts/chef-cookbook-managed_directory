#
# Cookbook Name:: managed_directory
# Recipe:: t_basic
#
# used by chefspec

# Create a File resource for 'a'
file '/tmp/foo/a' do
  action :touch
end

# Define the managed_directory
managed_directory '/tmp/foo' do
  action :clean
end
