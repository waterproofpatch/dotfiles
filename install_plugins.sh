#!/bin/bash

if [ ! -d "~/.vim/autoload" ]; then
        echo "Installing pathogen..."
        mkdir -p ~/.vim/autoload
        curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
fi
if [ ! -d "~/.vim/bundle" ]; then
        echo "Creating bundle dir..."
        mkdir -p ~/.vim/bundle
fi
if [ ! -d "~/.vim/plugin" ]; then
        echo "Creating plugin dir..."
        mkdir -p ~/.vim/plugin
fi

echo "Installing third party tools used by plugins..."
sudo apt-get install curl -y
sudo apt-get install exuberant-ctags -y
sudo apt-get python3-pip -y
pip install --user --update autopep8 

echo "Installing pathogen..."
mkdir -p ~/.vim/autoload ~/.vim/bundle && \
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim


echo "Installing plugins from github..."
git clone https://github.com/christoomey/vim-tmux-navigator.git ~/.vim/bundle/vim-tmux-navigator || true
git clone https://github.com/w0rp/ale.git ~/.vim/bundle/ale || true
git clone https://github.com/posva/vim-vue.git ~/.vim/bundle/vim-vue || true
git clone https://github.com/rhysd/vim-clang-format.git ~/.vim/bundle/vim-clang-format || true
git clone https://github.com/kien/ctrlp.vim.git ~/.vim/bundle/ctrlp || true
git clone https://github.com/itchyny/lightline.vim.git ~/.vim/bundle/lightline || true
git clone https://github.com/pangloss/vim-javascript.git ~/.vim/bundle/vim-javascript || true
git clone https://github.com/scrooloose/nerdcommenter.git ~/.vim/bundle/nerdcommenter || true
git clone https://github.com/tpope/vim-surround ~/.vim/bundle/vim-surround || true
git clone https://github.com/tpope/vim-fugitive.git ~/.vim/bundle/vim-fugitive || true
git clone https://github.com/xolox/vim-easytags.git ~/.vim/bundle/vim-easytags || true
git clone https://github.com/xolox/vim-misc.git ~/.vim/bundle/vim-misc || true
git clone https://github.com/tell-k/vim-autopep8.git ~/.vim/bundle/vim-autopep8 || true
cp ~/.vim/bundle/vim-autopep8/ftplugin/* ~/.vim/plugin/
