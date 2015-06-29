#
# Cookbook Name:: managed_directory
# Spec:: test_directories
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

require 'spec_helper'

describe 'managed_directory::test_directories' do
  context 'When all attributes are default, on CentOS 6.6' do
    let(:chef_run) do
      runner = ChefSpec::SoloRunner.new(
        step_into: ['managed_directory'],
        platform: 'centos',
        version: '6.6'
      ) do |node|
        # Set/override attributes here
      end
      runner.converge(described_recipe)
    end

    before do
      testdir_contents = [
        '/tmp/foo/a',
        '/tmp/foo/a_dir',
        '/tmp/foo/b_dir',
        '/tmp/foo/c_dir'
      ]
      allow(Dir).to receive(:glob).and_call_original
      allow(Dir).to receive(:glob).with('/tmp/foo/*').and_return(testdir_contents)
      allow(File).to receive(:directory?).and_call_original
      allow(File).to receive(:directory?).with('/tmp/foo/a_dir').and_return(true)
      allow(File).to receive(:directory?).with('/tmp/foo/b_dir').and_return(true)
      allow(File).to receive(:directory?).with('/tmp/foo/c_dir').and_return(true)
    end

    # The file /tmp/foo/a shouldn't be removed for this test since we've
    # disabled cleaning files in this recipe
    it 'should not remove file a' do
      expect(chef_run).to_not delete_file('/tmp/foo/a')
    end

    it 'should not remove directory a_dir' do
      expect(chef_run).to_not delete_directory('/tmp/foo/a_dir')
    end

    it 'should not remove directory b_dir' do
      expect(chef_run).to_not delete_directory('/tmp/foo/b_dir')
    end

    it 'should remove directory c_dir' do
      expect(chef_run).to delete_directory('/tmp/foo/c_dir')
    end
  end
end
