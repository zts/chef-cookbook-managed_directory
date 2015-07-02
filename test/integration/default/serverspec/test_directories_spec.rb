require 'spec_helper'

describe 'managed_directory::test_directories' do
  # Serverspec examples can be found at
  # http://serverspec.org/resource_types.html

  if %w(linux redhat fedora ubuntu debian).include?(os[:family])
    # Tests for Linux
    describe file('/tmp/bar/a_dir') do
      it { should be_directory }
    end

    describe file('/tmp/bar/b_dir') do
      it { should be_directory }
    end

    describe file('/tmp/bar/c_dir') do
      it { should_not be_directory }
    end

  elsif %w(windows).include?(os[:family])
    # Tests for Windows
    it 'does something in windows' do
      skip 'Replace this with meaningful tests'
    end
  end
end
