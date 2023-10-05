#!/bin/bash

echo -e "\n***Updating and upgrading base install***\n"
sleep 5
sudo dnf update -y
sleep 3
sudo dnf autoremove -y
sleep 3


echo -e "\n***Appending options to dnf.conf for better package management***\n"
sleep 5
#Update dnf.conf file
echo "#Added for speed:" | sudo tee -a/etc/dnf/dnf.conf
echo "fastestmirror=True" | sudo tee -a/etc/dnf/dnf.conf
echo "max_parallel_downloads=10" | sudo tee -a/etc/dnf/dnf.conf
echo "defaultyes=True" | sudo tee -a/etc/dnf/dnf.conf
echo "keepcache=True" | sudo tee -a/etc/dnf/dnf.conf

echo -e "\n***Installing FREE/NONFREE RPM repos and media packages***\n"
sleep 5
#Install free/non-free repos and media packages
sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm 
sudo dnf install https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
sudo dnf groupupdate multimedia --setop="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin
sudo dnf groupupdate sound-and-video


echo -e "\n***Installing Ansible***\n"
sleep 5
sudo dnf install ansible -y


echo -e "\n***Installing Flatpak***\n"
sleep 5
#Flatpak is installed in Fedora by default
sudo dnf install flatpak -y
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo


echo -e "\n***Calling next script to install system packages and move config files***\n"
sleep 5
source new-setup-all-systems.sh
