require 'chefspec'

describe 'a resource in the collection has a symbol for a name' do
  let(:chef_run) {
    runner = ChefSpec::ChefRunner.new(:step_into => ['managed_directory'])
    runner.converge 'managed_directory::t_resource_name_symbol'
  }
  before(:each) {
    Dir.stub(:glob).and_call_original
    Dir.should_receive(:glob).with("/tmp/foo/*").and_return(["/tmp/foo/a"])
  }
  it 'should still compile' do
      expect(chef_run).to log "LOG: t_resource_name_symbol test."
  end
end
