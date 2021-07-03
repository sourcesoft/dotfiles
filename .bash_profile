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
alias ls='ls -GFh'
alias ll='ls -la'
alias l='exa -abghHliS'
alias cat='bat'
alias ick='ack -i --pager="less -R -S -X"'
alias agg='ag --ignore={doc,docs,README.md} -i --ignore-case'
bindkey '^ ' autosuggest-accept
alias tm="tmux -2"
alias gs="git status"
alias gg="git logg"
alias ga="git add"
alias gd="git diff"
alias gc="git checkout"
set -o vi

# Go stuff
export GOPATH=~/work/go
export PATH=/usr/local/go/bin:$PATH
export PATH=$GOPATH/bin:$PATH

# Android Stuff
export ANDROID_HOME=~/Library/Android/sdk
export PATH=${PATH}:${ANDROID_HOME}/tools
export PATH=${PATH}:${ANDROID_HOME}/platform-tools

### Added by the Heroku Toolbelt
# export PATH="/usr/local/heroku/bin:$PATH"

###export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/mysql/support-files/:/usr/local/mysql-5.6.15-osx10.7-x86_64/bin:$PATH"

# Misc Bins
export PATH="/usr/local/git/bin:$PATH"
export PATH="~/Documents/mongodb/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export PATH=/usr/local/share:$PATH
export PATH=/usr/local/bin:$PATH
export PATH=/usr/local/php5/bin:$PATH
export PATH=$(brew --prefix openssl)/bin:$PATH
export PATH=/Applications/Postgres.app/Contents/Versions/latest/bin:$PATH
