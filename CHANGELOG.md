MANAGED_DIRECTORY CHANGELOG
===========================

This file is used to list changes made in each version of the managed_directory cookbook.

UNRELEASED
------
- Update provider to examine resources based on their path, rather than
	the resource names. This accounts for resources being named something other
	than their path. Thanks to [srenatus](https://github.com/srenatus)!

v0.2.1
------
- Fix bug for subdirectories when clean_directories is false. This would cause
	the subdirectory to be handed to the `file` resource in the provider, which
	would then cause chef-client to abort.

v0.2.0
------
- Added cleaning of subdirectories
- Added separate handling of links, which were formerly handled by the file
	resource, as managing links via file resources is deprecated
- Added attributes to control handling of files, directories and links
	- `clean_files` and `clean_links` default to `true` to preserve existing
		behavior
	- `clean_directories` defaults to `false` to preserve existing behavior
- Updated tests to current ChefSpec and ServerSpec, following examples from
	ChefDK's `chef generate cookbook` output
- Updated Test Kitchen to current CentOS (6.6)
- Updated README.md for new behaviors
- Added ChefSpec matchers for test-ability

v0.1.0
-----
- add chefspec tests
- FIX don't blow up when resource names are symbols
	- Thanks to Mark Friedgan (hubrix) for this fix.

- - -
Check the [Markdown Syntax Guide](http://daringfireball.net/projects/markdown/syntax) for help with Markdown.

The [Github Flavored Markdown page](http://github.github.com/github-flavored-markdown/) describes the differences between markdown on github and standard markdown.
