#!/bin/bash

echo -e "\n***Updating and Upgrading new install***\n"
sleep 5
sudo apt-get update

sudo apt-get upgrade -y

sudo apt-get autoremove -y

echo -e "\n***Installing nala for nicer package installs***\n"
sleep 5
sudo apt-get install nala -y

echo -e "\n***Installing Ansible***\n"
sleep 5
sudo nala install ansible -y

echo -e "***Installing flatpak***"
sleep 5
sudo nala install flatpak -y

echo -e "\n***Calling next script to install system packages and move config files***\n"
sleep 5
source new-setup-all-systems.sh
