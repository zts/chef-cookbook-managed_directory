require 'spec_helper'

describe 'managed_directory::test' do
  # Serverspec examples can be found at
  # http://serverspec.org/resource_types.html

  if %w(linux redhat fedora ubuntu debian).include?(os[:family])
    # Tests for Linux
    describe file('/tmp/foo/a') do
      it { should be_file }
    end

    describe file('/tmp/foo/a_link') do
      it { should be_file }
      it { should be_linked_to '/tmp/foo/a' }
    end

    describe file('/tmp/foo/b') do
      it { should be_file }
    end

    describe file('/tmp/foo/b_link') do
      it { should_not be_file }
    end

    describe file('/tmp/foo/c') do
      it { should_not be_file }
    end

    describe file('/tmp/foo/d') do
      it { should be_file }
    end

    describe file('/tmp/foo/e') do
      it { should_not be_file }
    end
    
    describe file('/tmp/foo/c_dir') do
      it { should be_directory }
    end

  elsif %w(windows).include?(os[:family])
    # Tests for Windows
    it 'does something in windows' do
      skip 'Replace this with meaningful tests'
    end
  end
end
