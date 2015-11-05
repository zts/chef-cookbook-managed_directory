#
# Cookbook Name:: managed_directory
# Provider:: default
#
# Copyright 2012, Zachary Stevens
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

# Chef 10 compatibility
if defined?(use_inline_resources)
  use_inline_resources
  using_inline_resources = true
else
  using_inline_resources = false
end

action :clean do
  # get the contents of the managed_directory on disk
  directory_contents = ::Dir.glob("#{new_resource.path}/*")

  # Chef 10 compatibility
  resources = using_inline_resources ? run_context.parent_run_context.resource_collection.all_resources : run_context.resource_collection.all_resources

  # Walk the resource collection to find resources that appear to be
  # contained by the managed_directory.  This depends on the resource's
  # name attribute containing the full path to the file.
  managed_entries = resources.map do |r|
    if r.name.to_s.start_with?("#{new_resource.path}/")
      r.name.to_s
    # Also catch the 'path' attribute for friendly-named resources
    elsif defined?(r.path) and r.path.to_s.start_with?("#{new_resource.path}/")
      r.path.to_s
    end
  end.compact

  # Remove any contents that appear to be unmanaged.
  entries_to_remove = directory_contents - managed_entries
  entries_to_remove.each do |e|
    if ::File.directory?(e)
      if new_resource.clean_directories
        directory e do
          recursive true
          action :delete
          Chef::Log.info "Removing unmanaged directory in #{new_resource.path}: #{e}"
        end
      end
    elsif ::File.symlink?(e)
      # Manage links as links to avoid warnings, as 'manage_symlink_source'
      # will eventually be disabled for File resources.
      if new_resource.clean_links
        link e do
          action :delete
          Chef::Log.info "Removing unmanaged symlink in #{new_resource.path}: #{e}"
        end
      end
    else
      if new_resource.clean_files
        file e do
          action :delete
          Chef::Log.info "Removing unmanaged file in #{new_resource.path}: #{e}"
        end
      end
    end
  end

  # If any files were removed, mark the resource as updated.
  new_resource.updated_by_last_action(true) unless entries_to_remove.empty?
end
