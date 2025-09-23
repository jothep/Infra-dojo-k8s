#!/bin/bash -e

# Update package lists
echo "Updating package lists..."
sudo apt update -y

# Install Ansible and sshpass
if ! command -v ansible &> /dev/null
then
    echo "Ansible not found. Installing Ansible and sshpass..."
    sudo apt install -y ansible sshpass
else
    echo "Ansible is already installed."
fi

# Configuring Ansible
CONFIG_DIR="/etc/ansible"
CONFIG_FILE="${CONFIG_DIR}/ansible.cfg"

# If /etc/ansible not exists, then create it
if [ ! -d "$CONFIG_DIR" ]; then
    echo "Directory ${CONFIG_DIR} does not exist. Creating it..."
    sudo mkdir -p "$CONFIG_DIR"
fi

# If ansible.cfg not exists，then create it
# Set host_key_checking = False for ansible to access host
if [ ! -f "$CONFIG_FILE" ]; then
    echo "File ${CONFIG_FILE} does not exist. Creating it with required configuration..."
    CONFIG_CONTENT="[defaults]
host_key_checking = False"
    echo "$CONFIG_CONTENT" | sudo tee "$CONFIG_FILE" > /dev/null
# If file exists, using sed to setup it
else
    echo "File ${CONFIG_FILE} exists. Configuring host_key_checking using sed (no backup)..."
    sudo sed -i '' -E 's/^[#\s]*host_key_checking\s*=.*/host_key_checking = False/' "$CONFIG_FILE"
fi

echo "Ansible installation and configuration complete!"
ansible --version