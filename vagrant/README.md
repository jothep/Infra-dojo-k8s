# Vagrant
Vagrant is used to create a virtual machine locally.
For Apple M-series chips, I use Vagrant + VMware fusion to launch a local VM.
For other InterIntel architectures like Windows, there are a wider range of options.

# Install Vagrant
brew tap hashicorp/tap
brew install hashicorp/tap/hashicorp-vagrant

# Manually download and install the ARM64 package at https://developer.hashicorp.com/vagrant/install

# Install plugin for VMware fusion
vagrant plugin install vagrant-vmware-desktop

sudo /opt/vagrant-vmware-desktop/bin/vagrant-vmware-utility certificate generate

sudo /opt/vagrant-vmware-desktop/bin/vagrant-vmware-utility service install

# If you encounter an error, you can reset the service
sudo /opt/vagrant-vmware-desktop/bin/vagrant-vmware-utility service uninstall
sudo /opt/vagrant-vmware-desktop/bin/vagrant-vmware-utility service install -port=9922

# Setup Vagrantfile by initial then edit Vagrantfile
vagrant init　

# Can directly edit and using Vagrantfile

# Start vagrant up
mkdir data
vagrant up

# You may encounter some problems during the startup process, such as the Vagrant box being incompatible, or the host needing to allow Vagrant (VMware) to access devices and create networks, etc. You may need to replace the box with one that suits the architecture and open the corresponding system permissions.

# Common commands
vagrant ssh

vagrant halt