#!/bin/bash

###### This will conduct basic update for Ubuntu before ansible installs packages######
if cat /etc/*release | grep ^NAME | grep Ubuntu; then
  echo -e "\n***Updating and Upgrading new install***\n"
  sleep 3
  sudo apt-get update
  sudo apt-get upgrade -y

  echo -e "\n***Installing Git***\n"
  sleep 3
  sudo apt install git -y

  echo -e "\n***Installing Ansible***\n"
  sleep 3
  sudo apt install ansible -y

###### This will conduct basic update for Arch before ansible installs packages######
elif cat /etc/*release | grep ^NAME | grep Arch ; then


echo -e "\n***Updating and Upgrading new install***\n"
  sleep 3
  sudo pacman -Syu

echo -e "\n***Installing Git***\n"
sleep 3
sudo pacman -S git -y

echo -e "\n***Installing Ansible***\n"
sleep 3
sudo pacman -S ansible -y


###### This will conduct basic update and system presetup for Fedora before ansible installs packages######
elif cat /etc/*release | grep ^NAME | grep Fedora; then
  echo -e "\n***Updating and upgrading base install***\n"
  sleep 3
  sudo dnf update -y
  sleep 3
  sudo dnf autoremove -y
  sleep 3


  echo -e "\n***Appending options to dnf.conf for better package management***\n"
  sleep 3
  #Update dnf.conf file
  echo "#Added for speed:" | sudo tee -a /etc/dnf/dnf.conf
  echo "fastestmirror=True" | sudo tee -a /etc/dnf/dnf.conf
  echo "max_parallel_downloads=10" | sudo tee -a /etc/dnf/dnf.conf
  echo "defaultyes=True" | sudo tee -a /etc/dnf/dnf.conf
  echo "keepcache=True" | sudo tee -a /etc/dnf/dnf.conf

  echo -e "\n***Installing FREE/NONFREE RPM repos and media packages***\n"
  sleep 3
  #Install free/non-free repos and media packages
  sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm -y
  sudo dnf install https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm -y
  sudo dnf groupupdate multimedia --setop="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin -y
  sudo dnf groupupdate sound-and-video -y
  
  echo -e "\n***Configuring fedora-cisco-openh, before installing Steam***\n"
  # Instructions found at - docs.fedoraproject.org/en-US/gaming/proton/
  sleep 3
  sudo dnf config-manager --enable fedora-cisco-openh264 -y

  echo -e "\n***Installing Git***\n"
  sleep 3
  sudo dnf install git -y

  echo -e "\n***Installing Ansible***\n"
  sleep 3
  sudo dnf install ansible -y

  echo -e "\n***Installing Flatpak***\n"
  sleep 3
  #Flatpak is installed in Fedora by default
  sudo dnf install flatpak -y
  sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

else
  echo "OS NOT DETECTED, couldn't install package $PACKAGE"
  exit 1
fi

###### Ansible will now install all system packages######
echo -e "\n***Calling ansible script to install system packages***\n"
sleep 3
ansible-playbook --ask-become-pass ansible-system-setup.yml

echo -e "\n***Calling ansible script to install language packages***\n"
sleep 3
ansible-playbook --ask-become-pass language-package-setup.yml

echo -e "\n***Calling ansible script to install development packages***\n"
sleep 3
ansible-playbook --ask-become-pass development-package-setup.yml

echo -e "\n***Calling ansible script to install chat packages***\n"
sleep 3
ansible-playbook --ask-become-pass chat-package-setup.yml

echo -e "\n***Calling ansible script to install media packages***\n"
sleep 3
ansible-playbook --ask-become-pass media-package-setup.yml

echo -e "\n***Calling ansible script to install gaming packages***\n"
sleep 3
ansible-playbook --ask-become-pass  game-package-setup.yml


echo -e "\n***Update java to use newly installed version***\n"
sleep 3
# This is being left for manual intervention incase there is a reason a different version needs to be used
update-alternatives --config java


echo -e "\n***Creating necessary directories***\n"

echo -e "\n***Creating '~/Project/Code' directory for programming projects***\n"
sleep 5
mkdir -p ~/Projects/Code/

echo -e "\n***Creating '~/.local/share/fonts' directory for NERDFONTS***\n"
sleep 5
mkdir -p ~/.local/share/fonts

echo -e "\n***This will clone the entire nerd-fonts repo. This will take a while...***"
echo -e "\n***Go grab a coffee :)***\n"
sleep 3
# The entire repo gets cloned for more options later on... Sometime you just need to switch things up! ;P
pushd ~/.local/share/fonts
git clone --depth 1 https://github.com/ryanoasis/nerd-fonts.git
sleep 5
./install.sh Hack #This installs only the "Hack" Fonts
#or use ./install.sh to install all fonts
popd

echo -e "\n***Generating SSH Key for GitHub***\n"
sleep 5
ssh-keygen -t ed25519 -C "j-bloom7@protonmail.com"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
echo -e "***Copying SSH Key to '~/GitHub.txt' for easier copying to GitHub***"
sleep 5
cat ~/.ssh/id_ed25519.pub > ~/GitHubSSH.txt #sends key to file for easy copying

echo -e "\n***Copying Emacs config to '~/.emacs.d'***\n"
sleep 5
pushd ~/
mv .emacs.d/ .emacs.d-old
git clone https://github.com/j-bloom/.emacs.d.git
popd

echo -e "\n***Pulling NVM from GitHub for NodeJS management***\n"
sleep 5
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash

echo -e "\n***Install Microsoft Fonts***\n"
sleep 5
sudo apt install ttf-mscorefonts-installer
sudo apt install install fontconfig
sudo fc-cache -f -v

###### This will conduct PHP clean up and tasks to enable services######
if cat /etc/*release | grep ^NAME | grep Fedora; then
  echo -e "\n***Updating and Upgrading new install***\n"
  sleep 3
  sudo systemctl enable httpd.service
  sudo systemctl start httpd.service

# Grant firewall access
  sudo firewall-cmd --permanent --add-service=http
  sudo firewall-cmd --permanent --add-service=https

# Reload firewall
  sudo systemctl reload firewalld

# MariaDB
  sudo systemctl enable mariadb.service
  sudo systemctl start mariadb.service

  sudo mysql_secure_installation
# Options for above (n), (y), (y), (y)

  sudo systemctl restart httpd

  echo -e "\n***Creating info.php to test PHP setup***\n"
  sleep 3
# Update info.php file to test setup
  echo "<?php" | sudo tee -a /var/www/html/info.php
  echo "phpinfo()" | sudo tee -a /var/www/html/info.php
  echo "?>" | sudo tee -a /var/www/html/info.php

else
  echo "OS NOT DETECTED, couldn't perform PHP cleanup in $PACKAGE"
  exit 1
fi
