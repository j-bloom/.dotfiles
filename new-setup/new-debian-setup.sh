#!/bin/bash

echo -e "\n***Updating and Upgrading new install***\n"
sleep 5
sudo apt-get update

sudo apt-get upgrade -y

echo -e "\n***Installing Ansible***\n"
sleep 5
sudo apt install git -y

echo -e "\n***Installing Ansible***\n"
sleep 5
sudo apt install ansible -y

echo -e "\n***Calling ansible script to install system packages***\n"
sleep 5
ansible-playbook --ask-become-pass system-packages.yml

echo -e "\n***Calling next script to install addtional packages and move config files to correct directories***\n"
sleep 5
source new-setup-all-systems.sh

echo -e "\n***Creating Cron Jobs***\n"
sleep 5
ansible-playbook --ask-become-pass cron-ansible.yml
