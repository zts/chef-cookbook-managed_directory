#
# Cookbook Name:: managed_directory
# Recipe:: test
#
# A simple demonstration of managed_directory, also used by chefspec.

testdir = '/tmp/bar'

# Setup the test.
# 1. Create the directory for our test files, during the compile phase.
directory testdir do
  action :nothing
end.run_action(:create)

# 2. Put some files in it, without using Chef, before convergence
unless defined?(ChefSpec)
  %w(a b c).each do |d|
    Chef::Log.warn("Creating test directory #{testdir}/#{d}_dir")
    ::Dir.mkdir("#{testdir}/#{d}_dir") unless ::Dir.exist?("#{testdir}/#{d}_dir")
  end
  # stuff some files into c_dir
  %w(a b c).each do |f|
    Chef::Log.warn("Creating test file #{testdir}/c_dir/#{f}")
    ::File.new("#{testdir}/c_dir/#{f}", 'w+') unless ::File.exist?("#{testdir}/c_dir/#{f}")
  end
end

# Create a directory resource for 'a_dir'
directory "#{testdir}/a_dir" do
  action :create
end

# Define the managed_directory and have it clean directories, too
managed_directory testdir do
  action :clean
  clean_directories true
  clean_files false
end

# Create a directory resource for 'b_dir'
# Note that the order of resources doesn't matter - managed_directory will
# not clean up this file.
directory "#{testdir}/b_dir" do
  action :create
end

# At the end of a Chef run containing this recipe, /tmp/foo should contain
# subdirectories "a_dir" and "b_dir". Subdirectory "c_dir" should have been
# removed.
