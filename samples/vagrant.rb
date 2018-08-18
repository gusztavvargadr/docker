directory = File.dirname(__FILE__)

require "#{directory}/../lib/gusztavvargadr/vagrant/samples/vagrant"

VagrantMachine.defaults_include(
  'synced_folders' => {
    '.docker' => '/data/docker',
    "#{directory}/.." => '/src/gusztavvargadr/docker',
  },
  'providers' => {
    'virtualbox' => {},
    'hyperv' => {},
  }
)

VagrantProvider.defaults_include(
  'memory' => '2048',
  'cpus' => '2'
)
