# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
# ZSH_THEME="refined"
# ZSH_THEME="powerlevel10k/powerlevel10k"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git docker last-working-dir meteor node npm macos redis-cli sudo cp emoji-clock pj zsh-autosuggestions vi-mode kubectl zsh-syntax-highlighting)

# User configuration
PROJECT_PATHS=(~/work ~/work/app ~/work/go ~/work/lamp)

# export MANPATH="/usr/local/man:$MANPATH"

source ~/.bash_profile
# source ~/.bashrc
source $ZSH/oh-my-zsh.sh

transfer() {
    # write to output to tmpfile because of progress bar
    tmpfile=$( mktemp -t transferXXX )
    curl --progress-bar --upload-file $1 https://transfer.sh/$(basename $1) >> $tmpfile;
    cat $tmpfile;
    rm -f $tmpfile;
}

alias transfer=transfer

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
# . `brew --prefix`/etc/profile.d/z.sh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

eval "$(starship init zsh)"

# This helps your computer find programs installed by Homebrew
export PATH="/usr/local/bin:$PATH"
export PATH="/Users/pouya.s@nylas.com/.cargo/bin:$PATH"

# This lets pyenv automatically activate your virtualenv when you cd into cloud-core
eval "$(pyenv init --path)"
eval "$(pyenv init - --no-rehash)"
eval "$(pyenv virtualenv-init -)"

# This aliases git to hub so you get GitHub commands under regular git
eval "$(hub alias -s)"
export HOMEBREW_GITHUB_API_TOKEN=hp_4PHWmnxpwEyrf1psmyBKN0IHm5LVGC2jjpTJ
export PATH="/usr/local/opt/curl/bin:$PATH"
alias dev='cd /Users/pouya.s@nylas.com/work/app/dev && make'

# bun completions
[ -s "/Users/pouya.s@nylas.com/.bun/_bun" ] && source "/Users/pouya.s@nylas.com/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

export GOPRIVATE=github.com/nylas # You can also put it in .zshrc or .bashrc
git config --global --replace-all url."git@github.com:".insteadOf "https://github.com/"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
. "~/.deno/env"
# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/pouya.s@nylas.com/Downloads/google-cloud-sdk 2/path.zsh.inc' ]; then . '/Users/pouya.s@nylas.com/Downloads/google-cloud-sdk 2/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/pouya.s@nylas.com/Downloads/google-cloud-sdk 2/completion.zsh.inc' ]; then . '/Users/pouya.s@nylas.com/Downloads/google-cloud-sdk 2/completion.zsh.inc'; fi

# Nix
if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
  source '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
fi
# End Nix

# pnpm
export PNPM_HOME="/Users/pouya.s@nylas.com/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm endexport PATH="$HOME/.local/bin:$PATH"

eval $(minikube -p minikube docker-env)
# The following lines have been added by Docker Desktop to enable Docker CLI completions.
fpath=(/Users/pouya.s@nylas.com/.docker/completions $fpath)
autoload -Uz compinit
compinit
# End of Docker CLI completions
export PATH="/usr/local/opt/libpq/bin:$PATH"
export PATH=/opt/homebrew/bin:$PATH
