require 'chefspec'

describe 'the test recipe example' do
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

describe 'file a followed by managed_directory' do
  let(:chef_run) {
    runner = ChefSpec::ChefRunner.new(:step_into => ['managed_directory'])
    runner.converge 'managed_directory::t_basic'
  }
  describe 'given files a and b' do
    before(:each) {
      Dir.stub(:glob).and_call_original
      Dir.should_receive(:glob).with("/tmp/foo/*").and_return(["/tmp/foo/a","/tmp/foo/b"])
    }
    it 'should not remove file a' do
      expect(chef_run).not_to delete_file "/tmp/foo/a"
    end
    it 'should remove file b' do
      expect(chef_run).to delete_file "/tmp/foo/b"
    end
  end
end
