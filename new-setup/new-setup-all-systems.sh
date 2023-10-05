#!/bin/bash

echo -e "\n***Calling Ansible Playbook to install system packages***\n"
sleep 5
ansible-playbook --ask-become-pass sys_setup.yml

echo -e "\n***Using curl to pull NVM from GitHub for node management***\n"
sleep 5
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash

echo -e "\n***Temporarily moving to '~/Downloads' for the next few operations***\n"
sleep 3
echo -e "\n***Using wget to install VS Code***\n"
sleep 5
pushd ~/Downloads
sudo apt install wget gpg -y
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg -y
sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
rm -f packages.microsoft.gpg

sudo apt install apt-transport-https -y
sudo apt update -y
sudo apt install code -y

echo -e "\n***Using wget to install VS Code***\n"
sleep 5
wget -O discord “https://discord.com/api/download?platform=linux&format=deb”
sudo dpkg -i discord

echo -e "\n***Using wget to install Teams for Linux***\n"
sleep 5
sudo wget -qO /etc/apt/keyrings/teams-for-linux.asc /etc/apt/keyrings/teams-for-linux.asc https://repo.teamsforlinux.de/teams-for-linux.asc

echo "deb [signed-by=/etc/apt/keyrings/teams-for-linux.asc arch=$(dpkg --print-architecture)] https://repo.teamsforlinux.de/debian/ stable main" | sudo tee /etc/apt/sources.list.d/teams-for-linux-packages.list

sudo apt update -y

sudo apt install teams-for-linux -y
popd

echo -e "\n***Creating '~/Project/Code' directory for programming projects***\n"
sleep 5
mkdir -p ~/Projects/Code/

echo -e "\n***Copying i3 config file to correct location***\n"
sleep 5
cp ../i3/config ~/.config/i3

#Emacs config is no long maintained! May use update it at a later time
#However, feel free to use it if you want a starting point
#echo -e "\n***Copying Emacs config to '~/.emacs.d'***\n"
#sleep 5
#mv ~/.emacs.d/ ~/.emacs.d-old
#cp ~/dotfiles/.emacs.d/ ~/.emacs.d/


# Packer is used in this config to manage nvim plug-ins
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim

### NEOVIM WILL BE BUILT FROM SOURCE FROM GITHUB!
### IF YOU DO NOT WANT NEOVIM BUILT FROM SOURCE COMMENT OUT THIS SECTION!!!

if cat /etc/*release | grep ^NAME | grep Debian; then
  sudo apt-get install ninja-build gettext cmake unzip curl -y 
  sleep 2
  git clone https://github.com/neovim/neovim
  sleep 2 
  cd neovim && make CMAKE_BUILD_TYPE=RelWithDebInfo 
  sleep 2
  git checkout stable
  sleep 2
  cd build && cpack -G DEB && sudo dpkg -i nvim-linux64.deb
  sleep 2
  cp -r ../nvim ~/.config/
elif cat /etc/*release | grep ^NAME | grep Mint ; then
  sudo apt-get install ninja-build gettext cmake unzip curl -y 
  sleep 2
  git clone https://github.com/neovim/neovim
  sleep 2 
  cd neovim && make CMAKE_BUILD_TYPE=RelWithDebInfo 
  sleep 2
  git checkout stable
  sleep 2
  cd build && cpack -G DEB && sudo dpkg -i nvim-linux64.deb
  sleep 2
  cp -r ../nvim ~/.config/
elif cat /etc/*release | grep ^NAME | grep Fedora; then
  sudo dnf -y install ninja-build cmake gcc make unzip gettext curl -y
  sleep 2
  git clone https://github.com/neovim/neovim
  sleep 2
  cd neovim && make CMAKE_BUILD_TYPE=RelWithDebInfo 
  sleep 2
  git checkout stable
  sleep 2
  sudo make install 
  sleep 2
  cp -r ../nvim ~/.config/
else
  echo "OS NOT DETECTED, couldn't install package $PACKAGE"
  exit 1
fi

echo -e "\n***Installing pip libraries***\n"
sleep 3
sudo pip install pylint
sudo pip install virtualenv

echo -e "\n***Using curl to install zsh plug-in oh-my-zsh***\n"
sleep 3
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

### Below section clones the entire NERDFONTS repo
### If you only want Hack font then use  *Option 2*
mkdir -p ~/.local/share/fonts
### Option 1 ###
echo -e "\n***This will clone the entire nerd-fonts repo. This will take a while...***"
echo -e "\n***Go grab a coffee :)***\n"
sleep 3
popd ~/.local/share/fonts
git clone https://github.com/ryanoasis/nerd-fonts.git
sleep 3
./install.sh Hack #This installs only the "Hack" Fonts
#or use ./install.sh to install all fonts
popd

### Option 2 ###
echo -e "\n***curl will be used to pull the Hack fonts from the nerd-fonts GitHub repo***\n"
sleep 3
#pushd ~/.local/share/fonts
#curl -fLo "Hack Bold Nerd Font Complete.ttf" https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/Hack/Bold/complete/Hack%20Bold%20Nerd%20Font%20Complete.ttf ~/.local/share/fonts
#curl -fLo "Hack BoldItalic Nerd Font Complete.ttf" https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/Hack/BoldItalic/complete/Hack%20Bold%20Italic%20Nerd%20Font%20Complete.ttf ~/.local/share/fonts
#curl -fLo "Hack Italic Nerd Font Complete.ttf" https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/Hack/Italic/complete/Hack%20Italic%20Nerd%20Font%20Complete.ttf ~/.local/share/fonts 
#curl -fLo "Hack Regular Nerd Font Complete.ttf" https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/Hack/Regular/complete/Hack%20Regular%20Nerd%20Font%20Complete.ttf ~/.local/share/fonts
popd

echo -e "\n***Generating SSH Key for GitHub***\n"
sleep 5
ssh-keygen -t ed25519 -C "j-bloom7@protonmail.com"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
echo -e "***Copying SSH Key to '~/GitHub.txt' for easier copying to GitHub***"
sleep 5
cat ~/.ssh/id_ed25519.pub > ~/GitHubSSH.txt #sends key to file for easy copying

#After adding key to GitHub - Test connection
#ssh -T git@github.com

#Add passphrase to GitHub key with below command
#ssh-keygen -p -f ~/.ssh/id_ed25519

### VERSIONS OF RUNTIMES AND PACKAGES MAY NEED TO BE UPDATED AT TIME OF USING SCRIPT! ###

#    if cat /etc/*release | grep ^NAME | grep Debian; then
#      sudo apt-get update && sudo apt-get install -y dotnet7
#      sudo apt-get update && sudo apt-get install -y aspnetcore-runtime-7.0
#      sudo apt-get install -y dotnet-runtime-7.0

  ### Currently not available for Ubuntu 23.04 ###
    #elif cat /etc/*release | grep ^NAME | grep Ubuntu ; then

#    elif cat /etc/*release | grep ^NAME | grep Fedora; then
#      sudo dnf install dotnet-sdk-7.0
#      sudo dnf install aspnetcore-runtime-7.0
#      sudo dnf install dotnet-runtime-7.0
#    else
#       echo "OS NOT DETECTED, couldn't install package $PACKAGE"
#       exit 1
#    fi

echo -e "\n***Using NVM to install and use latest nodejs***\n"
sleep 5
###Currently not working in script, needs to be manually entered
nvm install --lts #ensure this is run before npm packages
nvm use --lts

npm install -g vscode-langservers-extracted
npm install -g eslint
npm install -g typescript-language-server typescript
#npm i -g pyright install dotnet7
