#!/bin/bash

echo "Backing up dotfiles in $HOME to *.backup..."
cp ~/.vimrc ~/.vimrc.backup
cp ~/.tmux.conf ~/.tmux.conf.backup
cp ~/.clang-format ~/.clang-format.backup

echo "Copying dotfiles from repo to $HOME..."
cp .vimrc ~/.vimrc
cp .tmux.conf ~/.tmux.conf
cp .clang-format ~/.clang-format
echo "Done."
