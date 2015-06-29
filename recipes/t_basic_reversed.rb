#
# Cookbook Name:: managed_directory
# Recipe:: t_basic_reversed
#
# used by chefspec

# Define the managed_directory
managed_directory '/tmp/foo' do
  action :clean
end

# Create a File resource for 'a'
file '/tmp/foo/a' do
  action :touch
end
