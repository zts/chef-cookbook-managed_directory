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

# 2. Put some files in it, without using Chef, before convergence
unless defined?(ChefSpec)
  %w(a b c d e).each do |f|
    Chef::Log.warn("Creating test file #{testdir}/#{f}")
    ::File.new("#{testdir}/#{f}", 'w+') unless ::File.exist?("#{testdir}/#{f}")
  end

  Chef::Log.warn("Creating test symlink #{testdir}/b_link to #{testdir}/b")
  ::File.symlink("#{testdir}/b", "#{testdir}/b_link") unless ::File.exist?("#{testdir}/b_link")

  Chef::Log.warn("Creating test directory #{testdir}/c_dir")
  ::Dir.mkdir("#{testdir}/c_dir") unless ::Dir.exist?("#{testdir}/c_dir")
end

# Create a File resource for 'a'
file "#{testdir}/a" do
  action :touch
end

link "#{testdir}/a_link" do
  action :create
  to "#{testdir}/a"
  link_type :symbolic
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

# Create a File resource for 'd' by using the `path` method and
# having the resource name itself not match our managed_directory path.
file 'named_file_resource' do
  path "#{testdir}/d"
  action :touch
end

# At the end of a Chef run containing this recipe, /tmp/foo should contain
# directory "c_dir", files "a", "b", and "d" and symbolic link "a_link".
# File "c" and symlink "b_link" will have been removed.
