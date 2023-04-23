#!/bin/bash -e

sudo apt install -y ansible sshpass

sudo sed -i 's/host_key_checking = True/host_key_checking = False/g' /etc/ansible/ansible.cfg
sudo sed -i 's/#host_key_checking = False/host_key_checking = False/g' /etc/ansible/ansible.cfg
