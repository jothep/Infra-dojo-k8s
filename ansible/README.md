#Environment prepare
Vagrant host for remote host

Setup no-password access vagrant from localhost, by add id_rsa.pub to vagrant's ~/.ssh/authorized_keys

#Commands
ansible-playbook -i inventory/hosts ansible.yml -vv

#Create new playbook repo
./initapp.sh $PlaybookName