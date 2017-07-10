# ChefSpec matchers

if defined?(ChefSpec)
  def clean_managed_directory(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:managed_directory, :clean, resource_name)
  end
end
