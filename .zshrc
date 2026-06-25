source "$HOME/.bash_profile"
[ -f "$HOME/.fzf.zsh" ] && source "$HOME/.fzf.zsh"

path_prepend() {
  [ -d "$1" ] || return 0
  case ":$PATH:" in
    *":$1:"*) ;;
    *) export PATH="$1:$PATH" ;;
  esac
}

path_prepend /usr/local/bin
path_prepend /usr/local/sbin
path_prepend /opt/homebrew/bin
path_prepend /opt/homebrew/sbin
path_prepend "$HOME/.cargo/bin"

# This lets pyenv automatically activate your virtualenv when you cd into cloud-core
if command -v pyenv >/dev/null 2>&1; then
  eval "$(pyenv init --path)"
  eval "$(pyenv init - --no-rehash)"
fi

# This aliases git to hub so you get GitHub commands under regular git
if command -v hub >/dev/null 2>&1; then
  eval "$(hub alias -s)"
fi
path_prepend /usr/local/opt/curl/bin
path_prepend /opt/homebrew/opt/curl/bin

# bun
export BUN_INSTALL="$HOME/.bun"
path_prepend "$BUN_INSTALL/bin"

export NVM_DIR="$HOME/.nvm"
_load_nvm() {
  unfunction nvm node npm npx corepack yarn 2>/dev/null
  [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
}
nvm() { _load_nvm; nvm "$@"; }
node() { _load_nvm; node "$@"; }
npm() { _load_nvm; npm "$@"; }
npx() { _load_nvm; npx "$@"; }
corepack() { _load_nvm; corepack "$@"; }
yarn() { _load_nvm; yarn "$@"; }

# Nix
if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
  source '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
fi
# End Nix

# pnpm
export PNPM_HOME="${PNPM_HOME:-$HOME/Library/pnpm}"
path_prepend "$PNPM_HOME"
path_prepend "$HOME/.local/bin"

if [ -r /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
  source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
elif [ -r /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
  source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

use-minikube-docker() {
  command -v minikube >/dev/null 2>&1 || return 127
  eval "$(minikube -p minikube docker-env)"
}

# Docker CLI completions.
if [ -d "$HOME/.docker/completions" ]; then
  fpath=("$HOME/.docker/completions" $fpath)
fi
clean_fpath=()
for completion_dir in $fpath; do
  [ -d "$completion_dir" ] && clean_fpath+=("$completion_dir")
done
fpath=("${(@u)clean_fpath}")
unset completion_dir clean_fpath
autoload -Uz compinit
compinit
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"
path_prepend /usr/local/opt/libpq/bin
path_prepend /opt/homebrew/opt/libpq/bin
if command -v starship >/dev/null 2>&1; then
  eval "$(starship init zsh)"
fi


for google_cloud_sdk in "$HOME/google-cloud-sdk" "$HOME/Downloads/google-cloud-sdk"; do
  if [ -f "$google_cloud_sdk/path.zsh.inc" ]; then
    . "$google_cloud_sdk/path.zsh.inc"
  fi
  if [ -f "$google_cloud_sdk/completion.zsh.inc" ]; then
    . "$google_cloud_sdk/completion.zsh.inc"
  fi
done
unset google_cloud_sdk

path_prepend "$HOME/.antigravity/antigravity/bin"
path_prepend "$HOME/.opencode/bin"

claude-mem() {
  "$HOME/.bun/bin/bun" "$HOME/.claude/plugins/marketplaces/thedotmack/plugin/scripts/worker-service.cjs" "$@"
}

if [ -f "$HOME/.zshrc.local" ]; then
  source "$HOME/.zshrc.local"
fi
