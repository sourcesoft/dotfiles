My dotfiles.

Since I use two laptops (+ homelab servers) daily and jump between environments all the time, I had to ensure my setup is fully compatible with both:
- Debian/GNOME (personal laptop)
- OSX (work laptop).

![neovim](https://user-images.githubusercontent.com/608906/124360869-25f43380-dbfa-11eb-8e49-d11f1aa7bf68.png "neovim")

## Installation

My recommendation is to not use the config as is and just use this to learn and pick up what you like.

#### 1. Install required binaries
1. Have [Alacritty](https://github.com/alacritty/alacritty), [Starship](https://starship.rs/), (Neo)Vim and Git installed ofcourse
2. Install `tmux` and the [plugins manager](https://github.com/tmux-plugins/tpm)
3. Install `zsh`: [Oh My ZSH](https://github.com/robbyrussell/oh-my-zsh), [pwerlevel10k theme](https://github.com/romkatv/powerlevel10k#oh-my-zsh), [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions/blob/master/INSTALL.md) and s[zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/INSTALL.md)
4. Install `Inconsolata font`  and [Knack Nerd Font](https://github.com/enricobacis/.dotfiles/blob/master/osx-fonts/Library/Fonts/Knack%20Regular%20Nerd%20Font%20Complete.ttf).
5. Install some cool binaries like [ripgrep](https://github.com/BurntSushi/ripgrep), [lf](https://github.com/gokcehan/lf), [bat](https://github.com/sharkdp/bat), [fd](https://github.com/sharkdp/fd), [exa](https://github.com/ogham/exa) and [delta](https://github.com/dandavison/delta)
6. If you're on OSX install [reattach-to-user-namespace](https://github.com/ChrisJohnsen/tmux-MacOSX-pasteboard)

#### 2. Backup your old configuration and get new ones
1. Remove cache (or backup) first:

```
rm -rf ~/.local/share/nvim
rm -rf ~/.local/state/nvim
rm -rf ~/.cache/nvim
```

2. Clone the repo and copy the nvim config.

```
git clone git@github.com:sourcesoft/dotfiles.git
cd dotfiles
mv nvim ~/.config/nvim
```

3. Start tmux by running `tmux` and install tmux plugins with `Prefix + I`
4. Open neovim and let the installer takes its time to install all plugins. You may need to reopen neovim a few times to get everything installed.
5. run `:Mason` and install LSP and formatters you're interested in.
6. Optionally check out config files in the repository like `.bash_profile`, `.alacritty.yml`, `.gitconfig`, `.tmux.conf`, `.zshrc`, `.eslintrc.js`, `prettierrc`, `.gitignore`, `.prettierignore` and more.

## Mappings and Environment

It's much easier to use right CMD or Alt instead of reaching out to escape.
I also use Caps Lock for Control, since it's closer and easier to hit.
- Escape -> Right CMD or Right Alt
- Control -> Caps Lock

Tools to setup the key bindings:
- OSX: Use Karabiner to map
  - Visit: https://github.com/tekezo/Karabiner-Elements
- Ubuntu: Install xcape (https://github.com/alols/xcape)
  - Use the following command: `xcape -e 'Alt_R=Escape;ISO_Level3_Shift=Escape'`
