#!/bin/bash

code --list-extensions |
xargs -L 1 echo code --install-extension |
sed "s/$/ --force/" |
sed "\$!s/$/ \&/" > install-vscode-extensions.sh
