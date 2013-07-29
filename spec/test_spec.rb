require 'chefspec'

describe 'managed_directory::test' do
  let(:chef_run) {
    runner = ChefSpec::ChefRunner.new(:step_into => ['managed_directory'])
    runner.converge 'managed_directory::test'
  }
  before(:each) {
    Dir.stub(:glob).and_call_original
  }
  it 'should remove file c' do
    Dir.should_receive(:glob).with("/tmp/foo/*").and_return(["/tmp/foo/a","/tmp/foo/b","/tmp/foo/c"])
    expect(chef_run).to delete_file "/tmp/foo/c"
  end
end
