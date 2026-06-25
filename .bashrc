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
if [ -n "$ZSH_VERSION" ]; then
  HISTFILE="${HISTFILE:-${ZDOTDIR:-$HOME}/.zsh_history}"
  HISTSIZE=50000
  SAVEHIST=50000
  setopt APPEND_HISTORY
  setopt EXTENDED_HISTORY
  setopt HIST_FCNTL_LOCK
  setopt SHARE_HISTORY
fi
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
alias k="kubectl"
alias kgp="kubectl get pods"
alias kgs="kubectl get services"
alias kgi="kubectl get ingress"
set -o vi
export GOPATH=$HOME/work/go
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
export PATH=~/.npm-global/bin:$PATH
export GOPRIVATE=github.com/nylas

alias minikube-context="kubectl config use-context minikube"
alias tsh-login="tsh login --proxy=nylas.teleport.sh:443 --user=pouya.s@nylas.com --auth=google"
alias dev='cd /Users/pouya.s@nylas.com/work/app/dev && make'

export OPENAI_API_KEY="{{OPENAI_API_KEY}}"
export GOOGLE_AI_API_KEY="{{GOOGLE_AI_API_KEY}}"
export XAI_API_KEY="{{XAI_API_KEY}}"
