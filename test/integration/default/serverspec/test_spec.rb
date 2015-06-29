require 'spec_helper'

describe 'managed_directory::test' do
  # Serverspec examples can be found at
  # http://serverspec.org/resource_types.html

  if %w(linux redhat fedora ubuntu debian).include?(os[:family])
    # Tests for Linux
    describe file('/tmp/foo/a') do
      it { should be_file }
    end

    describe file('/tmp/foo/b') do
      it { should be_file }
    end

    describe file('/tmp/foo/c') do
      it { should_not be_file }
    end

  elsif %w(windows).include?(os[:family])
    # Tests for Windows
    it 'does something in windows' do
      skip 'Replace this with meaningful tests'
    end
  end
end