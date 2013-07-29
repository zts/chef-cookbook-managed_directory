#
# Cookbook Name:: managed_directory
# Recipe:: t_resource_name_symbol
#
# used by chefspec

# Define the managed_directory
managed_directory "/tmp/foo" do
  action :clean
end

log :test do
  message "LOG: t_resource_name_symbol test."
end
