#
# Cookbook Name:: managed_directory
# Recipe:: test
#
# A simple demonstration of managed_directory, also used by chefspec.

testdir = '/tmp/foo'

# Setup the test.
# 1. Create the directory for our test files, during the compile phase.
directory testdir do
  action :nothing
end.run_action(:create)

# # 2. Put some files in it, without using Chef, before convergence
# %w{a b c}.each do |f|
#   ::File.new("#{testdir}/#{f}", "w+")
# end

# Create a File resource for 'a'
file "#{testdir}/a" do
  action :touch
end

# Define the managed_directory
managed_directory testdir do
  action :clean
end

# Create a File resource for 'b'
# Note that the order of resources doesn't matter - managed_directory will
# not clean up this file.
file "#{testdir}/b" do
  action :touch
end

# At the end of a Chef run containing this recipe, /tmp/foo should contain
# files "a" and "b" only.  File "c" will have been removed.
