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
alias v="vim -p"
alias python="python3"

stty -ixon

# Custom cd
chpwd() ls

autoload -U compinit

plugins=(
        git
        zsh-autosuggestions
        zsh-syntax-highlighting
)

compinit

source $ZSH/oh-my-zsh.sh
source $ZSH/lib/history.zsh
source $ZSH/lib/completion.zsh
source $ZSH/plugins/vi-mode/vi-mode.plugin.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
