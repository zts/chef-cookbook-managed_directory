#
# Cookbook Name:: managed_directory
# Spec:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

require 'spec_helper'

describe 'managed_directory::default' do
  context 'When all attributes are default, on CentOS 6.10' do
    let(:chef_run) do
      runner = ChefSpec::SoloRunner.new(
        platform: 'centos',
        version: '6.10'
      ) do |node|
        # Set/override attributes here
        # node.automatic['virtualization']['role'] = 'guest'
      end
      runner.converge(described_recipe)
    end

    it 'converges successfully' do
      chef_run # This should not raise an error
    end
  end
end
