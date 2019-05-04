#!/bin/bash

echo "Backing up dotfiles in $HOME to *.backup..."
cp ~/.vimrc ~/.vimrc.backup
cp ~/.tmux.conf ~/.tmux.conf.backup
cp ~/.clang-format ~/.clang-format.backup

echo "Copying dotfiles from repo to $HOME..."
cp .vimrc ~/.vimrc
cp .tmux.conf ~/.tmux.conf
cp .clang-format ~/.clang-format

# some things will depend on the terminal emulator, so use platform specific bash scripts
if [[ "$OSTYPE" == "darwin"* ]]; then
        echo "MAC OSX detected, using OSX bash version."
        cp .bashrc_osx ~/.bashrc
elif [[ "OSTYPE" == "linux-gnu" ]]; then
        echo "Linux-GNU detected, using ubuntu bash version"
        cp .bashrc_ubuntu ~/.bashrc
fi

echo "Done."
