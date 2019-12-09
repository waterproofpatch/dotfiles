ZSH_THEME="robbyrussell"
COMPLETION_WAITING_DOTS="true"
SAVEHIST=1000
HISTFILE=~/.zsh_history

export ZSH=/Users/freeman/.oh-my-zsh
export VISUAL=vim
export EDITOR='vim'

alias gs='git status'
alias sz='source /Users/freeman/git/dotfiles/zsh/zshrc.sh'
alias v="vim -p"
alias dstop="docker stop $(docker ps -a -q)"

stty -ixon

# Custom cd
chpwd() ls

autoload -U compinit

#plugins=(git)
#for plugin ($plugins); do
#        fpath=($ZSH/plugins/$plugin $fpath)
#done

compinit

source $ZSH/oh-my-zsh.sh
source $ZSH/lib/history.zsh
source $ZSH/lib/completion.zsh

source $ZSH/plugins/vi-mode/vi-mode.plugin.zsh

source ~/git/dotfiles/zsh/keybindings.sh
source ~/git/dotfiles/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/git/dotfiles/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

source ~/git/dotfiles/zsh/prompt.sh
