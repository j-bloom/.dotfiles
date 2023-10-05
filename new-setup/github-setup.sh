#!/bin/bash

#After adding key to GitHub - Test connection
ssh -T git@github.com

#Add passphrase to GitHub key with below command
ssh-keygen -p -f ~/.ssh/id_ed25519
