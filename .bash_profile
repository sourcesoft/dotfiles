# Terminal stuff
ulimit -n 2048
export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]\$ "
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad
export EDITOR='vim';
export LANG='en_US.UTF-8';
export LC_ALL='en_US.UTF-8';
export LESS_TERMCAP_md="${yellow}";
export MANPAGER='less -X';
export HISTCONTROL=ignoreboth
export STARSHIP_CONFIG=~/.starship.toml
alias e='nvim .'
alias nvim='~/work/bins/nvim/bin/nvim'
alias ls='ls -GFh'
alias ll='ls -la'
alias l='exa -abghHliS'
alias cat='batcat'
alias tm="tmux -2"
alias gs="git status"
alias gg="git logg"
alias ga="git add"
alias gd="git diff"
alias gc="git checkout"
set -o vi
. "$HOME/.cargo/env"
