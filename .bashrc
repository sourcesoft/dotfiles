# Terminal stuff
ulimit -n 2048
export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]\$ "
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad
export EDITOR='nvim';
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
alias tm="tmux -2"
alias gs="git status"
alias gg="git logg"
alias ga="git add"
alias gd="git diff"
alias gc="git checkout"
alias push="git push origin"
alias pull="git pull origin"
set -o vi
export GOPRIVATE=github.com/nylas
export GOPATH=$HOME/work/go
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
export PATH=~/.npm-global/bin:$PATH

alias minikube-context="kubectl config use-context minikube"
alias tsh-login="tsh login --proxy=nylas.teleport.sh:443 --user=pouya.s@nylas.com --auth=google"
alias dev='cd /Users/pouya.s@nylas.com/work/app/dev && make'

export OPENAI_API_KEY="{{OPENAI_API_KEY}}"
export GOOGLE_CLIENT_SECRET = "{{GOOGLE_CLIENT_SECRET}}"
export GOOGLE_AI_API_KEY = "{{GOOGLE_AI_API_KEY}}"
export XAI_API_KEY = "{{XAI_API_KEY}}"

. "/Users/pouya.s@nylas.com/.deno/env"
. "$HOME/.local/bin/env"
