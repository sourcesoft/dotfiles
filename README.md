<img width="1705" height="1071" alt="image" src="https://github.com/user-attachments/assets/e1bf9be0-8d6d-4aa4-bb3b-6463be82a398" />

## Installation

Uses [dotter](https://github.com/SuperCuber/dotter). Install it first.

### Setup

1. Have [Ghostty](https://ghostty.org/), [Zellij](https://github.com/zellij-org/zellij),  `zsh`: [Oh My Posh](https://ohmyposh.dev/), [Starship](https://starship.rs/), Neovim and Git installed of course.

2. Install `Inconsolata font`  from [Nerd Font](https://www.nerdfonts.com/) and [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions).

3. Install some cool binaries like [ripgrep](https://github.com/BurntSushi/ripgrep), [lf](https://github.com/gokcehan/lf), [bat](https://github.com/sharkdp/bat), [fd](https://github.com/sharkdp/fd), [exa](https://github.com/ogham/exa) and [delta](https://github.com/dandavison/delta).

4. Clone the repo and apply the configurations:

```
git clone git@github.com:sourcesoft/dotfiles.git
cd dotfiles
dotter deploy
```

5. Open neovim and let the installer take its time to install all plugins. You may need to reopen neovim a few times to get everything installed.

6. run `:Mason` and install LSP and formatters you're interested in.

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
