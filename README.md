# Dotfiles
These are probably not the configs your looking for.  
They are not pretty, they are stock and functional.   
However, if you want to try them out feel free to.  

<b>Before using this script ensure git is installed  
Changes have been made as I no longer use certain packages or packages are not available on distros I am trying at times.  
Please give the setup a read through to see if anything you want to use is commented out!<b/>

## What this script does
This script will setup a system to what I find to be a usable (starting point) state in Fedora, Ubuntu and Arch(btw) ;P  
It will also create a Projects Folder where I personally like to store projects and code.

## Base packages installed
### Ansible - needed to install most packages.  
Packages are seperated into yaml files based on type. This is for ease of maintenence, and if anyone wants to use this config it is easier to add/remove packages. You can also opt to remove entire categories of pacakges.  
Packages are broken up into the following categories:
- System
- Language
- Development
- Games
- Chat
- Media
- npm - NVM is used for node mangement
- GitHub - sets up SSH Key and performs SSH testing step and keygen password setup

<b>For additional/proprietary software Flatpack and Snaps are used a lot in their respective distros<b/>

## Node
Nodejs OR NVM (Node Version Manager)
Install NVM from GitHub  
"https://github.com/nvm-sh/nvm#installing-and-updating"
#### Installation for NVM is also in script inside "development-package-setup.yml"

## LSP installs - some options for languages I use
- clangd
- vscode-langservers-extracted
- eslint
- typescript-language-server typescript
- pyright
- dotnet core
- csharpier
- Golang
  
## Neovim - NOT CURRENTLY MAINTAINED
This has a basic setup using "Packer" package manager.  
Maybe I will update this if I start using Neovim again...  

## Emacs
- script will install emacs, then rename original ".emacs.d/" to ".emacs.d.old/"
- script will then copy the .emacs configs to the home directory.
#### Emacs README instructions will need to be followed to load all melpa/elpa packages
#### The first time all packages load may take some time. Please be patient.

## Githug SSH
- creates ssh key for github and places key in "Githubssh.txt" for easy access.
- after key is added additional steps to test connection can be found in [[./new-setup/new-setup.sh]]

## Window Manager
### i3WM
### Extras for i3
- rofi - better file searching
