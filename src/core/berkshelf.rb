require "#{File.dirname(__FILE__)}/../../lib/gusztavvargadr/chef/src/core/berkshelf"

def gusztavvargadr_docker_cookbook(component = '', namespace = '')
  cookbook_name = 'gusztavvargadr_docker'
  cookbook_name = "#{cookbook_name}_#{component}" unless component.to_s.empty?
  cookbook_name = "#{cookbook_name}_#{namespace}" unless namespace.to_s.empty?

  path = component.to_s.empty? ? 'core' : component
  path = "#{path}/cookbooks/#{namespace.to_s.empty? ? 'core' : namespace}"
  cookbook_path = "#{File.dirname(__FILE__)}/../#{path}"

  cookbook cookbook_name, path: cookbook_path
end
