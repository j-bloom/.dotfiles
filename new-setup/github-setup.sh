#!/bin/bash

#After adding key to GitHub - Test connection
echo -e "\n***Testing github connection***\n"
sleep 3
ssh -T git@github.com

#Add passphrase to GitHub key with below command
echo -e "\n***Generating password for Github SSH***\n"
sleep 3
ssh-keygen -p -f ~/.ssh/id_ed25519

echo -e "\n***Calling file to install NVM***\n"
sleep 3
source npm-packages.sh