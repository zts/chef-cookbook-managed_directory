#
# Cookbook Name:: managed_directory
# Resource:: managed_directory
#
# Copyright 2012, Zachary Stevens (original LWRP)
# Copyright 2017, Heig Gregorian (custom resource)
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

resource_name :managed_directory

# Implement a single action, and make that the default.
default_action :clean

# Path of the directory we'll manage.
property :path, String, name_property: true

# Should we clean files out of our managed directory? Default, yes
property :clean_files, [TrueClass, FalseClass], required: false, default: true

# Should we clean links out of our managed directory? Default, yes
property :clean_links, [TrueClass, FalseClass], required: false, default: true

# Should we clean subdirectories out of our managed directory? Default, no
property :clean_directories, [TrueClass, FalseClass], required: false, default: false

action :clean do
  # get the contents of the managed_directory on disk
  directory_contents = ::Dir.glob("#{new_resource.path}/*")

  # Walk the resource collection to find resources that appear to be
  # contained by the managed_directory.
  managed_entries = run_context.root_run_context.resource_collection.all_resources.select do |r|
    r.identity.is_a?(String) && r.identity.start_with?("#{new_resource.path}/")
  end.map(&:identity).uniq

  # Generate list of entries which appear to be unmanaged.
  entries_to_remove = directory_contents - managed_entries

  # Iterate through each entry (path) and identify appropriate
  # removal action as dictated by resource's properties
  entries_to_remove.each do |e|
    if ::File.directory?(e) && new_resource.clean_directories
      directory e do
        recursive true
        action :delete
        Chef::Log.info "Removing unmanaged directory in #{new_resource.path}: #{e}"
      end
    elsif ::File.symlink?(e) && new_resource.clean_links
      # Manage links as links to avoid warnings, as 'manage_symlink_source'
      # will eventually be disabled for File resources.
      link e do
        action :delete
        Chef::Log.info "Removing unmanaged symlink in #{new_resource.path}: #{e}"
      end
    elsif ::File.file?(e) && new_resource.clean_files
      file e do
        action :delete
        Chef::Log.info "Removing unmanaged file in #{new_resource.path}: #{e}"
      end
    end
  end
end
