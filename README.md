# Dotfiles

My dotfiles. Tested primarily on Mac, somewhat on Linux

## Dependencies

* vim-plug
* fzf `brew install fzf`
* ag `brew install ag`
* exuberant-ctags
* cscope
* clang-format (llvm-tools)

## Install (Mac, Linux)

```bash
cd zsh && git submodule update --init --recursive
```

1. Edit ~/.vimrc to source vimrc/vimrc
2. Edit ~/.tmux.conf to source tmux/tmux.conf
3. Edit ~/.zshrc to source zsh/zshrc.sh
4. Run `:PlugInstall` in vim
5. Copy clang/.clang-format to ~/
6. $(brew --prefix)/opt/fzf/install
