directory = File.dirname(__FILE__)

require "#{directory}/../lib/gusztavvargadr/vagrant/samples/vagrant"

VagrantDeployment.defaults_include(
  'stack' => 'docker',

  'machines' => {
    'bootstrap' => {
      'box' => VagrantLinuxServerMachine.defaults['box'],
      'azure_image_urn' => 'Canonical:UbuntuServer:16.04-LTS:latest',
    },
  }
)
