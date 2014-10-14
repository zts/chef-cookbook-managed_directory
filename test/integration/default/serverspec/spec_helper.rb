require "serverspec"
# Required by serverspec
set :backend, :exec

RSpec.configure do |c|
  c.before :all do
    c.path = "/sbin:/usr/sbin:/bin"
  end
end
