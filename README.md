# Dotfiles

My dotfiles. Tested primarily on Mac, somewhat on Linux

## Dependencies

* vim-plug
* fzf `brew install fzf`
* ag `brew install ag`
* exuberant-ctags
* cscope
* clang-format (llvm-tools)
* bat `brew install bat`
* docker

## Install (Mac, Linux)

1. Edit `~/.vimrc` to source `.vimrc`
2. Edit `~/.tmux.conf` to source `.tmux.conf`
3. Edit `~/.zshrc` to source `.zshrc`
4. Run `:PlugInstall` in `vim`
5. Copy `.clang-format` to `~/`
6. $(brew --prefix)/opt/fzf/install
