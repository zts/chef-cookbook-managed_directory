#
# Cookbook Name:: managed_directory
# Spec:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

require 'spec_helper'

describe 'managed_directory::t_basic' do
  context 'When all attributes are default, on CentOS 6.8' do
    let(:chef_run) do
      runner = ChefSpec::SoloRunner.new(
        step_into: ['managed_directory'],
        platform: 'centos',
        version: '6.8'
      ) do |node|
        # Set/override attributes here
      end
      runner.converge(described_recipe)
    end

    before(:each) do
      allow(Dir).to receive(:glob).and_call_original
      allow(File).to receive(:file?).and_call_original
    end

    describe 'given only file a' do
      before(:each) do
        allow(Dir).to receive(:glob).with('/tmp/foo/*').and_return(['/tmp/foo/a'])
      end
      it 'should not remove file a' do
        expect(chef_run).to_not delete_file('/tmp/foo/a')
      end
    end

    describe 'given file b' do
      before(:each) do
        allow(Dir).to receive(:glob).with('/tmp/foo/*').and_return(['/tmp/foo/b'])
        allow(File).to receive(:file?).with('/tmp/foo/b').and_return true
      end

      it 'should remove file b' do
        expect(chef_run).to delete_file '/tmp/foo/b'
      end
    end

    describe 'given files a and b' do
      before(:each) do
        allow(Dir).to receive(:glob).with('/tmp/foo/*').and_return(['/tmp/foo/a','/tmp/foo/b'])
        allow(File).to receive(:file?).with('/tmp/foo/b').and_return true
      end

      it 'should not remove file a' do
        expect(chef_run).to_not delete_file '/tmp/foo/a'
      end

      it 'should remove file b' do
        expect(chef_run).to delete_file '/tmp/foo/b'
      end
    end

    describe 'given no files' do
      before(:each) do
        allow(Dir).to receive(:glob).with('/tmp/foo/*').and_return([])
      end

      it 'should not remove file a' do
        expect(chef_run).to_not delete_file '/tmp/foo/a'
      end
    end
  end
end
