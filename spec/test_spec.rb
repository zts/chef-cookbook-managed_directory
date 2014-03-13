require 'spec_helper'

describe 'the test recipe example' do
  let(:chef_run) {
    runner = ChefSpec::Runner.new(:step_into => ['managed_directory'])
    runner.converge 'managed_directory::test'
  }
  before(:each) {
    Dir.stub(:glob).and_call_original
  }
  it 'should remove file c' do
    Dir.should_receive(:glob).with("/tmp/foo/*").and_return(["/tmp/foo/a","/tmp/foo/b","/tmp/foo/c","/tmp/foo/d"])
    expect(chef_run).to delete_file "/tmp/foo/c"
  end

  it 'should not remove file d' do
    Dir.should_receive(:glob).with("/tmp/foo/*").and_return(["/tmp/foo/a","/tmp/foo/b","/tmp/foo/d"])
    expect(chef_run).not_to delete_file "/tmp/foo/d"
  end
end

