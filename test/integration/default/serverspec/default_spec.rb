require "spec_helper"

describe "basic test recipe" do
  describe file('/tmp/foo/a') do
    it { should be_file }
  end

  describe file('/tmp/foo/b') do
    it { should be_file }
  end

  describe file('/tmp/foo/c') do
    it { should_not be_file }
  end

end
