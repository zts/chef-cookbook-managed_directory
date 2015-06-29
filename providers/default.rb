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

action :clean do
  # get the contents of the managed_directory on disk
  directory_contents = ::Dir.glob("#{new_resource.path}/*")

  # Walk the resource collection to find resources that appear to be
  # contained by the managed_directory.  This depends on the resource's
  # name attribute containing the full path to the file.
  managed_files = run_context.resource_collection.all_resources.map { |r|
    r.name.to_s if r.name.to_s.start_with?("#{new_resource.path}/")
  }.compact

  # Remove any contents that appear to be unmanaged.
  # We use the File resource for this so that the activity is visibile
  # to report handlers.
  entries_to_remove = directory_contents - managed_entries
  entries_to_remove.each do |e|
    if ::File.directory?(e)
      directory e do
        recursive true
        action :delete
        Chef::Log.info "Removing unmanaged directory in #{new_resource.path}: #{e}"
      end
    else
      file e do
        action :delete
        Chef::Log.info "Removing unmanaged file in #{new_resource.path}: #{e}"
      end
    end
  end

  # If any files were removed, mark the resource as updated.
  new_resource.updated_by_last_action(true) unless entries_to_remove.empty?
end
