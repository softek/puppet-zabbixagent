# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "genebean/centos6-rvm193-64bit"

  config.vm.provision "shell", inline: "su - vagrant -c 'cd /vagrant; bundle install --jobs=3 --retry=3 --path=${BUNDLE_PATH:-vendor/bundle}'"

end
