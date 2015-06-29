MANAGED_DIRECTORY CHANGELOG
===========================

This file is used to list changes made in each version of the managed_directory cookbook.

UNRELEASED
----------
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

0.1.0
-----
- add chefspec tests
- FIX don't blow up when resource names are symbols
	- Thanks to Mark Friedgan (hubrix) for this fix.

0.0.1
-----
	initial release

- - -
Check the [Markdown Syntax Guide](http://daringfireball.net/projects/markdown/syntax) for help with Markdown.

The [Github Flavored Markdown page](http://github.github.com/github-flavored-markdown/) describes the differences between markdown on github and standard markdown.
