# Environment prepare
Vagrant host for remote host

# Install ansible on ubuntu
./install-ansible-ubt.sh

# Setup password-free access on localhost
./setup-ssh-access.sh

# Setup password-free access on remote machine, need user and password
./setup-ssh-access.sh <user> <host>

# Commands
ansible-playbook -i inventory/hosts ansible.yml -vv

# Create new playbook repo
./initapp.sh $PlaybookName