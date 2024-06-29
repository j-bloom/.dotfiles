#!/bin/bash

###Currently not working in script, needs to be manually entered
echo -e "\n***Using NVM to install and use lts version of node***\n"
sleep 2
nvm install --lts #ensure this is run before npm packages
sleep 1
nvm use --lts

npm install -g vscode-langservers-extracted
sleep 1
npm install -g eslint
sleep 1
npm install -g typescript-language-server typescript
sleep 1
npm install -g @angular/cli
sleep 1
npm i -g pyright install dotnet7
