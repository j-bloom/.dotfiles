# Dotfiles

These are probably not the configs your looking for.
They are not pretty, they are stock and functional. 
However, if you want to try them out feel free to.

#### Before using this script ensure git is installed
#### Changes have been made as I no longer use certain packages or packages are not available on distros I am trying at times.
#### Please give the setup a read through to see if anything you want to use is commented out!

## What this script does
This script will setup a system to what I find to be a usable (starting point) state in Fedora or a Debian based Distro.
It will also create a Projects Folder where I personally like to store projects and code.

## Base packages installed
### Ansible - needed to install additional system, language, and media packages
#### Ansible Playbook is used to install additional packages
### Nala - for better package management in Debian based distros
### Flatpak - used for additional/proprietary software

## Node
Nodejs OR NVM (Node Version Manager)
Install NVM from GitHub  
"https://github.com/nvm-sh/nvm#installing-and-updating"
#### Installation for NVM is also in script inside "new-setup.sh"

## LSP installs - some options for languages I use
- clangd
- vscode-langservers-extracted
- eslint
- typescript-language-server typescript
- pyright
- dotnet core
- csharpier
- Golang
  
## Neovim   

_Have to give credit where it is due... Much of this config is taken from The Primeagen_
### If Neovim is desired then once installation is complete, follow below steps:
#### Source Packer file - open packer file and in normal mode enter ":so <enter>"
#### Sync Packer - in packer file enter ":PackerSync <enter>"
  

### For Telescope below packages are installed
#### ripgrep  
#### fd-find

### Needed for nvim config - Nerd Fonts are needed to make some icons work
Install Nerd Fonts - https://www.nerdfonts.com/
#### Install is inside script and places "Hack" font inside dir "~/.local/share/fonts"

## Emacs - NOT CURRENTLY MAINTAINED
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
