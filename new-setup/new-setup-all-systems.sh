#!/bin/bash

echo -e "\n***Using curl to pull NVM from GitHub for node management***\n"
sleep 5
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash

echo -e "\n***Creating '~/Project/Code' directory for programming projects***\n"
sleep 5
mkdir -p ~/Projects/Code/

echo -e "\n***Copying i3 config file to correct location***\n"
sleep 5
cp ../i3/config ~/.config/i3

echo -e "\n***Copying Emacs config to '~/.emacs.d'***\n"
sleep 5
pushd ~/
git clone https://github.com/j-bloom/.emacs.d.git
popd
mv ~/.emacs.d/ ~/.emacs.d-old
cp -r ~/dotfiles/.emacs.d/ ~/.emacs.d/

echo -e "\n***Installing pip libraries***\n"
sleep 3
sudo apt install python3-pip
sudo pip install pylint
sudo pip install virtualenv

### Below section clones the entire NERDFONTS repo
mkdir -p ~/.local/share/fonts
echo -e "\n***This will clone the entire nerd-fonts repo. This will take a while...***"
echo -e "\n***Go grab a coffee :)***\n"
sleep 3
popd ~/.local/share/fonts
git clone https://github.com/ryanoasis/nerd-fonts.git
sleep 3
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

echo -e "\n***Restarting shell to run next part of the script***\n"
sleep 5
exec bash


#After adding key to GitHub - Test connection
echo -e "\n***Testing github connection***\n"
sleep 5
ssh -T git@github.com

#Add passphrase to GitHub key with below command
echo -e "\n***Generating password for Github SSH***\n"
sleep 5
ssh-keygen -p -f ~/.ssh/id_ed25519

echo -e "\n***Using NVM to install and use latest nodejs***\n"
sleep 5
###Currently not working in script, needs to be manually entered
nvm install --lts #ensure this is run before npm packages
nvm use --lts

echo -e "\n***Restarting shell to make sure node is installed***\n"
sleep 5
exec bash

echo -e "\n***Installing NPM packages***\n"
sleep 5

npm install -g vscode-langservers-extracted
npm install -g eslint
npm install -g typescript-language-server typescript

exit
