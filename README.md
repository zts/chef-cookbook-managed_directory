Description
===========

Provides an LWRP to declare that a directory's contents are entirely
managed by Chef.  When a node is converged, any files present in the
`managed_directory` that are not managed by Chef will be removed.


Requirements
============

Platform
--------

Known to work on CentOS and OS X.  Should work on other Unix-like
systems.


Resource/Provider
=================

`managed_directory`
---------------------------

Ensure that a directory contains only files put there by Chef in this
run.  Any other files will be removed.

### Actions

- `:clean` - Remove any unmanaged files.

### Attribute Parameters

- `path` - (name attribute) The absolute path to the directory to be managed.
- `clean_files` - Boolean to determine whether unmanaged files should be
  removed. Default is `true`.
- `clean_links` - Boolean to determine whether unmanaged links should be
  removed. Default is `true`.
- `clean_directories` - Boolean to determine whether unmanaged subdirectories
  should be removed. Default is `false`.


Usage
=====

default
-------

Include the default recipe in a run list to make the resource
available in your run.

test
----

The 'test' recipe illustrates use of the `managed_directory` resource.

test_directories
----------------

The 'test_directories' recipe illustrates use of the `managed_directory`
resource when having it clean up unwanted subdirectories.


Caveats
=======

 * The directory to be managed must already exist.  If you also need
   to ensure that the directory exists, use the Directory resource
   separately.

 * If you require subdirectories to be managed as well, be sure to set the
   `clean_directories` attribute to `true`

 * A file is considered to be managed if there is a resource with a
   name attribute equal to the file's full path.  It will do the wrong
   thing if this assumption is not true for the contents of your
   directory.

 * Files managed by resources created after this LWRP is converged
   (eg, from within a `ruby_block` or LWRP later in the run list) will
   be incorrectly identified as "unmanaged", and then deleted.  They
   will be recreated later in the run, but this creates a window where
   the file is missing. For a work-around, you can define the
   `managed_directory` with `action :none` and use another resource to notify
   it `:delayed`. For example, if you're using the `yum` cookbook to manage
   all your repositories, you might do something like:

```ruby
managed_directory '/etc/yum.repos.d' do
  action	:nothing
  clean_directories true
end

ruby_block 'delayed_managed_directory /etc/yum.repos.d' do
  block { true }
  notifies	:clean, 'managed_directory[/etc/yum.repos.d]', :delayed
end
```


License and Author
==================

Authors:

- Zachary Stevens ([zts](https://github.com/zts))
- Gregory Ruiz-Ade ([gkra](https://github.com/gkra))

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
