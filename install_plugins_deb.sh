#!/bin/bash
if [[ "$OSTYPE" == "darwin"* ]]; then
        echo "MAC OSX detected, aborting."
        exit 1
fi

# create default directories
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
if ! [ -x "$(command -v git)" ]; then
        echo 'Error: git is not installed.' >&2
        sudo apt-get install git -y
fi
if ! [ -x "$(command -v curl)" ]; then
        echo 'Error: curl is not installed.' >&2
        sudo apt-get install curl -y
fi
if ! [ -x "$(command -v ctags)" ]; then
        echo 'error: exuberant-ctags is not installed.' >&2
        sudo apt-get install exuberant-ctags -y
fi
if ! [ -x "$(command -v pip)" ]; then
        echo 'error: pip is not installed.' >&2
        sudo apt-get install python3-pip -y
fi
if ! [ -x "$(command -v clang-format)" ]; then
        echo 'error: clang-format is not installed.' >&2
        sudo apt-get install clang-format -y
fi

echo "Installing autopep8..."
pip install --user --update autopep8 

echo "Installing vim plugins from github..."
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
git clone https://tpope.io/vim/eunuch.git ~/.vim/bundle/eunuch || true

cp ~/.vim/bundle/vim-autopep8/ftplugin/* ~/.vim/plugin/
