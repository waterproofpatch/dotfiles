# Dotfiles

My dotfiles.

## Dependencies

* vim-plug
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
4. Copy clang/.clang-format to ~/
