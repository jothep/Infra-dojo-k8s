#!/bin/bash -e

# Unified SSH passwordless configuration script

# 1. Automatically detect and create an SSH key pair (if one doesn't exist).
# 2. Set up passwordless login for the local machine (localhost) or a remote host.

# Usage:
# - Configure the local machine: ./setup-ssh-access.sh
# - Configure the remote host: ./setup-ssh-access.sh <user> <host>
# Example: ./setup-ssh-access.sh vagrant 192.168.56.111

KEY_PATH=~/.ssh/id_rsa
if [ ! -f "$KEY_PATH" ]; then
    echo "SSH key pair does not exist. Generating a new key pair..."
    ssh-keygen -t rsa -b 4096 -f "$KEY_PATH" -N ""
else
    echo "The SSH key pair already exists and does not need to be created."
fi
echo 

# If the number of parameters is 0, localhost is configured
if [ "$#" -eq 0 ]; then
    echo "## Configuring password-free login for localhost..."
    
    AUTHORIZED_KEYS_PATH=~/.ssh/authorized_keys
    PUB_KEY_PATH=~/.ssh/id_rsa.pub

    # Check if the public key is in authorized_keys
    if ! grep -q -f "$PUB_KEY_PATH" "$AUTHORIZED_KEYS_PATH" 2>/dev/null; then
        echo "Adding public key to ${AUTHORIZED_KEYS_PATH}..."
        cat "$PUB_KEY_PATH" >> "$AUTHORIZED_KEYS_PATH"
    else
        echo "The public key already exists in the authorized_keys file."
    fi
    
    echo "Setting correct SSH file permissions..."
    chmod 700 ~/.ssh
    chmod 600 "$AUTHORIZED_KEYS_PATH"
    
    echo "Done"
    echo
    ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -o BatchMode=yes localhost "echo 'Local SSH password-free connection successful!'"

# If the number of parameters is 2, configure the remote host
elif [ "$#" -eq 2 ]; then
    REMOTE_USER=$1
    REMOTE_HOST=$2
    
    echo "## Configuring password-free login for remote host ${REMOTE_USER}@${REMOTE_HOST}... "
    
    # Check if the ssh-copy-id command exists
    if ! command -v ssh-copy-id &> /dev/null; then
        echo "Error: ssh-copy-id command not found. Please install openssh-client first."
        exit 1
    fi
    
    ssh-copy-id "${REMOTE_USER}@${REMOTE_HOST}"
    
    echo "Public key distribution successful."
    echo
    ssh -o PasswordAuthentication=no "${REMOTE_USER}@${REMOTE_HOST}" "echo 'Remote connection successful, no password required!'"

# Display help information if the number of parameters is incorrect.
else
    echo "Error: Incorrect number of parameters."
    echo
    echo "Usage:"
    echo "Configure local machine: $0"
    echo "Configure remote host: $0 <user> <host>"
    echo "Example: $0 vagrant 192.168.56.111"
    exit 1
fi

echo
echo "Configuration completed!"