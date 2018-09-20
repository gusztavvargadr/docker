directory = File.dirname(__FILE__)

require "#{directory}/../lib/gusztavvargadr/vagrant/samples/vagrant"

VagrantMachine.defaults_include(
  'synced_folders' => {
    '/vagrant' => {
      'source' => '.vagrant',
      'disabled' => true,
    },
    '/data/docker' => {
      'source' => '.docker',
      'create' => true,
    },
  },
  'providers' => {
    'virtualbox' => {},
    'hyperv' => {},
  }
)

VagrantProvider.defaults_include(
  'memory' => 2048,
  'cpus' => 2
)
