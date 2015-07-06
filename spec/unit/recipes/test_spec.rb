#
# Cookbook Name:: managed_directory
# Spec:: test
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

require 'spec_helper'

describe 'managed_directory::test' do
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
        '/tmp/foo/a_link',
        '/tmp/foo/b',
        '/tmp/foo/b_link',
        '/tmp/foo/c',
        '/tmp/foo/c_dir',
        '/tmp/foo/d',
        '/tmp/foo/e'
      ]
      allow(Dir).to receive(:glob).and_call_original
      allow(Dir).to receive(:glob).with('/tmp/foo/*').and_return(testdir_contents)
      allow(File).to receive(:directory?).and_call_original
      allow(File).to receive(:directory?).with('/tmp/foo/c_dir').and_return(true)
      allow(File).to receive(:symlink?).and_call_original
      allow(File).to receive(:symlink?).with('/tmp/foo/a_link').and_return(true)
      allow(File).to receive(:symlink?).with('/tmp/foo/b_link').and_return(true)
    end

    it 'should clean managed_directory' do
      expect(chef_run).to clean_managed_directory('/tmp/foo')
    end

    it 'should not remove file a' do
      expect(chef_run).to_not delete_file('/tmp/foo/a')
    end

    it 'should not remove link a_link' do
      expect(chef_run).to_not delete_file('/tmp/foo/a_link')
    end

    it 'should not remove file b' do
      expect(chef_run).to_not delete_file('/tmp/foo/b')
    end

    it 'should remove link b_link' do
      expect(chef_run).to delete_link('/tmp/foo/b_link')
    end

    it 'should remove file c' do
      expect(chef_run).to delete_file('/tmp/foo/c')
    end

    it 'should not remove file d' do
      expect(chef_run).to_not delete_file('/tmp/foo/d')
    end

    it 'should remove file e' do
      expect(chef_run).to delete_file('/tmp/foo/e')
    end

    # It shouldn't remove c_dir because in this test we haven't told
    # managed_directory to clean directories.
    it 'should not remove directory c_dir' do
      expect(chef_run).to_not delete_directory('/tmp/foo/c_dir')
    end
  end
end
