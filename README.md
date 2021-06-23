## Installation

#### 1. Install required binaries
1. Have (Neo)Vim and Git installed ofcourse
2. Install `tmux` and the [plugins manager](https://github.com/tmux-plugins/tpm)
3. Install `zsh`: [Oh My ZSH](https://github.com/robbyrussell/oh-my-zsh), [pwerlevel10k theme](https://github.com/romkatv/powerlevel10k#oh-my-zsh), [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions/blob/master/INSTALL.md) and [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/INSTALL.md)
4. Install `Inconsolata font`  and [Knack Nerd Font](https://github.com/enricobacis/.dotfiles/blob/master/osx-fonts/Library/Fonts/Knack%20Regular%20Nerd%20Font%20Complete.ttf) and configure iTerm to use Knack Nerd.
5. Install some cool binaries like [reattach-to-user-namespace](https://github.com/ChrisJohnsen/tmux-MacOSX-pasteboard), [`universal-ctags`](https://github.com/universal-ctags/ctags), [colorls](https://github.com/athityakumar/colorls), [The Silver Searcher](https://github.com/ggreer/the_silver_searcher)  [bat](https://github.com/sharkdp/bat), [fd](https://github.com/sharkdp/fd), [exa](https://github.com/ogham/exa) and [delta](https://github.com/dandavison/delta)

#### 2. Backup your old configuration and get new ones
1. Backup the old one first: `mv ~/.vimrc ~/.vimrc.bak`
2. Replace it: `wget -O ~/.vimrc https://raw.githubusercontent.com/sourcesoft/my-long-list/master/.vimrc`
3. NeoVim uses XDG configuration: `ln -s ~/.vimrc ~/.config/nvim/init.vim`
4. Vim uses old `.vimrc` location so there's no need to create symlink.
5. Copy other config files in the repository like `.bash_profile`, `.gitconfig`, `.tern-config`, `.tmux.conf`, `.zshrc`, `.eslintrc.js`, `prettierrc`, `.gitignore`, `.prettierignore`, `.ctags` and configure more if feel comfortable.

#### 3. Setup (Neo)Vim (in order)
1. Before opening (Neo)Vim:
- Install some required compilers for our plugins with `npm install -g typescript neovim`, `pip install pynvim`, `pip3 install pynvim`, `curl -L http://xrl.us/installperlosx | bash` and [GO](https://golang.org/doc/install)
- Open tmux running `tmux` and install tmux plugins with `Prefix + I`
- Setup plugins by first installing [vim-plug](https://github.com/junegunn/vim-plug) and then running `vim +PlugInstall +qall` or `nvim +PlugInstall +qall` in the terminal
2. Open (Neo)Vim and:
- run `:UpdateRemotePlugins` and `:GoInstallBinaries` 
- Learn key bindings by reading this file

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


#### Hex code mappings for iTerm:
- cmd-o: 0x01 0x29 --- tmux next session
- cmd-i: 0x01 0x28 --- tmux previous session
- cmd-j: 0x2C 0x73 0x6A --- vim jump page down
- cmd-k: 0x2C 0x73 0x6B --- vim jump page up
- cmd-m: 0x2C 0x6D --- vim quickfix previous
- cmd-n: 0x2C 0x6E --- vim quickfix next
- cmd-n: 0x2C 0x71 --- vim quickfix toggle
- cmd-p: 0x2C 0x70 --- vim run tmux command
- cmd-r: 0x2C 0x72 --- vim run last tmux command
- cmd-f: 0x2C 0x66 --- vim toggle fullscreen
- cmd-;: 0x2C 0x3B --- list buffers
- cmd-a: 0x2C 0x61 --- search current buffer subdirectory
- cmd-s: 0x2C 0x73 0x73 --- run ALEFix

#### Troubleshooting to get NeoVim, iTerm and Tmux all work together smoothly:
- https://github.com/neovim/neovim/wiki/FAQ#how-can-i-change-the-cursor-shape-in-the-terminal
- https://github.com/neovim/neovim/wiki/FAQ#my-ctrl-h-mapping-doesnt-work
- https://github.com/neovim/neovim/issues/2048
- http://stackoverflow.com/questions/6778961
- http://stackoverflow.com/questions/39645253
- http://www.nthelp.com/ascii.htm
- http://superuser.com/questions/259614


### Tools as a developer
- [NeoVim](https://neovim.io) / [vimrc](https://github.com/sourcesoft/my-long-list/blob/master/.vimrc) / [ag](https://github.com/ggreer/the_silver_searcher) - Can't live without ya'll, not even a day.
- [iTerm2](https://www.iterm2.com/) / [zsh](https://github.com/robbyrussell/oh-my-zsh) / [tmux](https://tmux.github.io/) - Performant terminal and shell everywhere.
- [Little Snitch](https://www.obdev.at/products/littlesnitch) - Sometimes I need to monitor I/O of an application I'm developing.
- [Charles](https://www.charlesproxy.com/) - Monitoring using all the tools even the ones I have no idea what they are.
- [Fritzing](fritzing.org/) - Easily design electronic circuits for Arduino in no time.
- [OsmondCocoa](www.osmondpcb.com/) - Sometimes I need to build a ready to print for some home-made circuits.

![Vim](https://github.com/sourcesoft/dotfiles/blob/master/images/vim.png "vim")

![ZSH](https://github.com/sourcesoft/dotfiles/blob/master/images/zsh.png "vim")
