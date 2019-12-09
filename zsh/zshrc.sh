ZSH_THEME="robbyrussell"
COMPLETION_WAITING_DOTS="true"
SAVEHIST=1000
HISTFILE=~/.zsh_history

export ZSH=/Users/freeman/.oh-my-zsh
export VISUAL=vim

alias gs='git status'
alias sz='source /Users/freeman/git/dotfiles/zsh/zshrc.sh'
alias v="vim -p"
alias dstop="docker stop $(docker ps -a -q)"

# Custom cd
chpwd() ls

autoload -U compinit

#plugins=(git)
#for plugin ($plugins); do
#        fpath=($ZSH/plugins/$plugin $fpath)
#done

compinit

source $ZSH/oh-my-zsh.sh
source $ZSH/plugins/vi-mode/vi-mode.plugin.zsh
source $ZSH/lib/history.zsh
source $ZSH/lib/key-bindings.zsh
source $ZSH/lib/completion.zsh
#source $ZSH/plugins/zsh-syntax-highlighting/zsh/syntax-highlighting.zsh
#source $ZSH/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='vim'
fi
