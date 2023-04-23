#!/bin/bash
app=$1

#to init a folder of app

mkdir -p $app/file
mkdir -p $app/inventory/group_vars
mkdir -p $app/roles/$app/tasks
mkdir -p $app/defaults

touch $app/$app.yml
touch $app/inventory/hosts
touch $app/inventory/group_vars/all
touch $app/inventory/group_vars/vars.yml
touch $app/defaults/main.yml
echo "[$app]" > $app/inventory/hosts
touch $app/roles/$app/tasks/main.yml
cat << EOF > $app/$app.yml
## 
- hosts: $app
  #gather_facts: no
  roles:
  - $app
  tags:
  - $app
  vars_files:
    - "{{ inventory_dir }}/group_vars/vars.yml"
EOF

