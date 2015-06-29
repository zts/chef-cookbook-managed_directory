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

# Implement a single action, and make that the default.
actions :clean

def initialize(*args)
  super
  @action = :clean
end

# Path of the directory we'll manage.
attribute :path, :kind_of => String, :name_attribute => true

# Should we clean files out of our managed directory?
attribute :clean_files, :kind_of => [TrueClass, FalseClass], :default => true

# Should we clean subdirectories out of our managed directory?
attribute :clean_directories, :kind_of => [TrueClass, FalseClass], :default => false
