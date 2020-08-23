#
# Cookbook Name:: managed_directory
# Spec:: test_directories
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

require 'spec_helper'

describe 'test-managed_directory::test_directories' do
  context 'When all attributes are default, on CentOS 6.10' do
    let(:chef_run) do
      runner = ChefSpec::SoloRunner.new(
        step_into: ['managed_directory'],
        platform: 'centos',
        version: '6.10'
      ) do |node|
        # Set/override attributes here
      end
      runner.converge(described_recipe)
    end

    before do
      testdir_contents = [
        '/tmp/bar/a',
        '/tmp/bar/a_dir',
        '/tmp/bar/b_dir',
        '/tmp/bar/c_dir',
        '/tmp/bar/d_dir',
      ]
      allow(Dir).to receive(:glob).and_call_original
      allow(Dir).to receive(:glob).with('/tmp/bar/*').and_return(testdir_contents)
      allow(File).to receive(:directory?).and_call_original
      allow(File).to receive(:directory?).with('/tmp/bar/a_dir').and_return(true)
      allow(File).to receive(:directory?).with('/tmp/bar/b_dir').and_return(true)
      allow(File).to receive(:directory?).with('/tmp/bar/c_dir').and_return(true)
      allow(File).to receive(:directory?).with('/tmp/bar/d_dir').and_return(true)
    end

    it 'should clean managed_directory /tmp/bar' do
      expect(chef_run).to clean_managed_directory('/tmp/bar').with(
        clean_directories: true,
        clean_files: false
      )
    end

    # The file /tmp/bar/a shouldn't be removed for this test since we've
    # disabled cleaning files in this recipe
    it 'should not remove file a' do
      expect(chef_run).to_not delete_file('/tmp/bar/a')
    end

    it 'should not remove directory a_dir' do
      expect(chef_run).to_not delete_directory('/tmp/bar/a_dir')
    end

    it 'should not remove directory b_dir' do
      expect(chef_run).to_not delete_directory('/tmp/bar/b_dir')
    end

    it 'should remove directory c_dir' do
      expect(chef_run).to delete_directory('/tmp/bar/c_dir')
    end

    it 'should not remove directory d_dir' do
      expect(chef_run).to_not delete_directory('/tmp/bar/d_dir')
    end
  end
end
