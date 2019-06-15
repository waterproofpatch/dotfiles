#!/bin/bash
# Installs vim plugins from git as well as any tools (pip, curl, git etc.) needed for a 
# basic development environment.

create_dirs() {
        # create default dirs for vim plugins
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
}

make_backups () {
        timestamp=$(date +"%d-%m-%y_%H-%M-%S")
        backupDirName=~/.dotfiles.backup_${timestamp}
        echo "Backing up dotfiles to ${backupDirName}"
        mkdir -p ${backupDirName}
        if [ $? -ne 0 ]; then
                echo "Failed creating backup dir."
                exit 1
        fi
        cp ~/.vimrc ${backupDirName}/
        cp ~/.tmux.conf ${backupDirName}/
        cp ~/.bashrc ${backupDirName}/
        cp -rf ~/.vim ${backupDirName}/
        if [ $? -ne 0 ]; then
                echo "Failed backing up ~/.vim dir."
                exit 1
        fi
}

install_from_git () {
        # install vim plugins from various git repos
        echo "Removing ~/.vim..."
        rm -rf ~/.vim
        create_dirs
        echo "Installing vim plugins from git..."
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
        git clone https://github.com/majutsushi/tagbar.git ~/.vim/bundle/tagbar || true
        git clone https://github.com/fatih/vim-go.git ~/.vim/bundle/vim-go || true
        git clone https://github.com/prettier/vim-prettier ~/.vim/bundle/vim-prettier || true
        git clone https://github.com/airblade/vim-gitgutter.git ~/.vim/bundle/vim-gitgutter || true
        git clone https://github.com/flazz/vim-colorschemes.git ~/.vim/bundle/vim-colorschemes || true

        cp ~/.vim/bundle/vim-autopep8/ftplugin/* ~/.vim/plugin/
} 

install_deps_deb() {
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
}

install_deps_darwin() {
        echo "Installing third party tools used by plugins..."
        if ! [ -x "$(command -v brew)" ]; then
                echo "Must install brew to get dependencies using this script."
                exit 1
        fi
        if ! [ -x "$(command -v git)" ]; then
                echo 'Error: git is not installed.' >&2
                brew install git -y
        fi
        if ! [ -x "$(command -v curl)" ]; then
                echo 'Error: curl is not installed.' >&2
                brew install curl -y
        fi
        if ! [ -x "$(command -v ctags)" ]; then
                echo 'error: exuberant-ctags is not installed.' >&2
                brew install exuberant-ctags -y
        fi
        if ! [ -x "$(command -v pip)" ]; then
                echo 'error: pip is not installed.' >&2
                brew python3-pip -y
        fi
        if ! [ -x "$(command -v clang-format)" ]; then
                echo 'error: clang-format is not installed.' >&2
                brew install clang-format -y
        fi
}

printUsage () {
        echo "$0 <os>"
        echo "os: darwin | debian"
}

if [ "$#" -ne 1 ]; then
        printUsage
        exit 1
fi

OS=$1
if [ "$OS" != "darwin" -a "$OS" != "debian" ]; then
        echo "OS must be one of [darwin, debian]"
        exit 1
fi

make_backups
install_from_git

if [[ "$OS" == "debian" ]]; then
        echo "Installing dependencies for linux-gnu"
        install_deps_deb
elif [[ "$OS" == "darwin" ]]; then
        echo "Installing dependencies for darwin18"
        install_deps_darwin
else
        echo "Unknown OS."
        exit 1
fi

echo "Installing pip tools..."
pip install autopep8 
pip install pytest 
pip install virtualenv 

