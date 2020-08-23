resource_name :test_object
provides :test_object

# Implement a single action, and make that the default.
default_action :create

# Filename of the object we'll create
property :object_path, String, name_property: true

# Type of the object to create
property :object_type, String

action :create do
    if new_resource.object_type == "file"
        file new_resource.object_path do
            action :create
        end
    elsif new_resource.object_type == "directory"
        directory new_resource.object_path do
            action :create
        end
    else
        raise "not supported"
    end
end