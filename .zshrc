set -o magicequalsubst
ZSH_THEME="robbyrussell"
COMPLETION_WAITING_DOTS="true"
SAVEHIST=1000
HISTFILE=~/.zsh_history

export ZSH=~/.oh-my-zsh
export VISUAL=vim
export EDITOR='vim'

alias gs='git status'
alias ss='svn status --ignore-externals'
alias sc='svn status --ignore-externals | grep ^C'
alias la='ls -al'
#alias vim='/usr/local/bin/vim'
alias v="vim -p"
alias python="python3"

stty -ixon

# Custom cd
chpwd() ls

autoload -U compinit

plugins=(git zsh-syntax-highlighting)
#for plugin ($plugins); do
#        fpath=($ZSH/plugins/$plugin $fpath)
#done

compinit

source $ZSH/oh-my-zsh.sh
source $ZSH/lib/history.zsh
source $ZSH/lib/completion.zsh
source $ZSH/plugins/vi-mode/vi-mode.plugin.zsh

#source ~/git/dotfiles/zsh/keybindings.sh
#source ~/git/dotfiles/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
#source ~/git/dotfiles/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
#source ~/git/dotfiles/zsh/prompt.sh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
