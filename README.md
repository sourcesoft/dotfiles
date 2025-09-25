![neovim](https://github.com/sourcesoft/dotfiles/assets/608906/165f2fee-bb89-43f8-a547-1673f0bdbcb4)

## Installation

Uses [dotter](https://github.com/SuperCuber/dotter). Install it first.

### Setup

1. Have [Ghostty](https://ghostty.org/), [Zellij](https://github.com/zellij-org/zellij), [Starship](https://starship.rs/), Neovim and Git installed of course.

2. Install `zsh`: [Oh My ZSH](https://github.com/robbyrussell/oh-my-zsh), [pwerlevel10k theme](https://github.com/romkatv/powerlevel10k#oh-my-zsh), [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions/blob/master/INSTALL.md) and s[zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/INSTALL.md).

3. Install `Inconsolata font`  and [Knack Nerd Font](https://github.com/enricobacis/.dotfiles/blob/master/osx-fonts/Library/Fonts/Knack%20Regular%20Nerd%20Font%20Complete.ttf).

4. Install some cool binaries like [ripgrep](https://github.com/BurntSushi/ripgrep), [lf](https://github.com/gokcehan/lf), [bat](https://github.com/sharkdp/bat), [fd](https://github.com/sharkdp/fd), [exa](https://github.com/ogham/exa) and [delta](https://github.com/dandavison/delta).

5. If you're on OSX install [reattach-to-user-namespace](https://github.com/ChrisJohnsen/tmux-MacOSX-pasteboard).

6. Clone the repo and copy the nvim config.

```
git clone git@github.com:sourcesoft/dotfiles.git
cd dotfiles
dotter deploy
```

7. Open neovim and let the installer take its time to install all plugins. You may need to reopen neovim a few times to get everything installed.
8. run `:Mason` and install LSP and formatters you're interested in.

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
