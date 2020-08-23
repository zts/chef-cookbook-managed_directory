#
# Cookbook Name:: managed_directory
# Spec:: t_resource_name_symbol
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

require 'spec_helper'

describe 'managed_directory::t_resource_name_symbol' do
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

    before(:each) do
      allow(Dir).to receive(:glob).and_call_original
      allow(Dir).to receive(:glob).with('/tmp/foo/*').and_return(['/tmp/foo/a'])
    end

    it 'converges successfully' do
      chef_run # This should not raise an error
    end

    it 'should log a test message' do
        expect(chef_run).to write_log('LOG: t_resource_name_symbol test.')
    end
  end
end
