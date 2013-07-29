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
  before(:each) {
    Dir.stub(:glob).and_call_original
  }
  describe 'given only file a' do
    before(:each) {
      Dir.should_receive(:glob).with("/tmp/foo/*").and_return(["/tmp/foo/a"])
    }
    it 'should not remove file a' do
      expect(chef_run).not_to delete_file "/tmp/foo/a"
    end
  end
  describe 'given file b' do
    before(:each) {
      Dir.should_receive(:glob).with("/tmp/foo/*").and_return(["/tmp/foo/b"])
    }
    it 'should remove file b' do
      expect(chef_run).to delete_file "/tmp/foo/b"
    end
  end
  describe 'given files a and b' do
    before(:each) {
      Dir.should_receive(:glob).with("/tmp/foo/*").and_return(["/tmp/foo/a","/tmp/foo/b"])
    }
    it 'should not remove file a' do
      expect(chef_run).not_to delete_file "/tmp/foo/a"
    end
    it 'should remove file b' do
      expect(chef_run).to delete_file "/tmp/foo/b"
    end
  end
  describe 'given no files' do
    before(:each) {
      Dir.should_receive(:glob).with("/tmp/foo/*").and_return([])
    }
    it 'should not remove file a' do
      expect(chef_run).not_to delete_file "/tmp/foo/a"
    end
  end
end

describe 'managed_directory followed by file a' do
  let(:chef_run) {
    runner = ChefSpec::ChefRunner.new(:step_into => ['managed_directory'])
    runner.converge 'managed_directory::t_basic_reversed'
  }
  before(:each) {
    Dir.stub(:glob).and_call_original
  }
  describe 'given only file a' do
    before(:each) {
      Dir.should_receive(:glob).with("/tmp/foo/*").and_return(["/tmp/foo/a"])
    }
    it 'should not remove file a' do
      expect(chef_run).not_to delete_file "/tmp/foo/a"
    end
  end
  describe 'given file b' do
    before(:each) {
      Dir.should_receive(:glob).with("/tmp/foo/*").and_return(["/tmp/foo/b"])
    }
    it 'should remove file b' do
      expect(chef_run).to delete_file "/tmp/foo/b"
    end
  end
  describe 'given files a and b' do
    before(:each) {
      Dir.should_receive(:glob).with("/tmp/foo/*").and_return(["/tmp/foo/a","/tmp/foo/b"])
    }
    it 'should not remove file a' do
      expect(chef_run).not_to delete_file "/tmp/foo/a"
    end
    it 'should remove file b' do
      expect(chef_run).to delete_file "/tmp/foo/b"
    end
  end
  describe 'given no files' do
    before(:each) {
      Dir.should_receive(:glob).with("/tmp/foo/*").and_return([])
    }
    it 'should not remove file a' do
      expect(chef_run).not_to delete_file "/tmp/foo/a"
    end
  end
end
