directory = File.dirname(__FILE__)

require "#{directory}/../lib/gusztavvargadr/vagrant/samples/vagrant"

VagrantMachine.defaults_include(
  'synced_folders' => {
    '/vagrant' => {
      'disabled' => true,
    },
    '/data/docker' => {
      'source' => '.docker',
      'create' => true,
    },
  }
)
