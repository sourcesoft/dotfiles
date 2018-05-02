My own (Neo)Vim configuration, works best to develop JS and GO.
Configuration is based on Tmux, iTerm2, OSX.
I use Alt and CMD for some key mappings, so it's more suitable for Mac+iTerm.

![Vim](https://github.com/sourcesoft/dotfiles/blob/master/images/vim.png "vim")

![ZSH](https://github.com/sourcesoft/dotfiles/blob/master/images/zsh.png "vim")


## Installation

#### Install required binaries:

1. Have (Neo)Vim and Git installed ofcourse
2. Tmux (plugins: https://github.com/sourcesoft/my-long-list/blob/master/.tmux.conf)
3. If using OSX: `brew install reattach-to-user-namespace`
4. Rainbarf (https://github.com/creaktive/rainbarf)
5. Oh My ZSH (https://github.com/robbyrussell/oh-my-zsh)
6. If you're running OSX install iTerm and Dash.app (https://kapeli.com/dash)
7. GO (https://golang.org/doc/install)
8. The Silver Searcher (https://github.com/ggreer/the_silver_searcher)
9. Free `Inconsolata` font

#### Backup your old configuration ~/.vimrc and replace it with this file or create a symlink
1. Backup the old one first: `mv ~/.vimrc ~/.vimrc.bak`
2. Replace it: `wget -O ~/.vimrc https://raw.githubusercontent.com/sourcesoft/my-long-list/master/.vimrc`
3. NeoVim uses XDG configuration: `ln -s ~/.vimrc ~/.config/nvim/init.vim`
4. Vim uses old `.vimrc` location so there's no need to create symlink

#### Install vim-plug: https://github.com/junegunn/vim-plug
#### Install plugins by running `vim +PlugInstall +qall` or `nvim +PlugInstall +qall` in terminal
#### Open NeoVim(Vim) and run :GoInstallBinaries and then :TmuxLine
#### Learn key bindings by reading this file

## Mappings and Environment

It's much easier to use right CMD or Alt instead of reaching out escape.
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
- ctrl-space: 0x2C 0x76 --- lookup Dash.app docs

#### Troubleshooting to get NeoVim, iTerm and Tmux all work together smoothly:
- https://github.com/neovim/neovim/wiki/FAQ#how-can-i-change-the-cursor-shape-in-the-terminal
- https://github.com/neovim/neovim/wiki/FAQ#my-ctrl-h-mapping-doesnt-work
- https://github.com/neovim/neovim/issues/2048
- http://stackoverflow.com/questions/6778961
- http://stackoverflow.com/questions/39645253
- http://www.nthelp.com/ascii.htm
- http://superuser.com/questions/259614


> List of current tools and techs I use as a developer

### Tools as a developer
- [NeoVim](https://neovim.io) / [vimrc](https://github.com/sourcesoft/my-long-list/blob/master/.vimrc) / [ag](https://github.com/ggreer/the_silver_searcher) - Can't live without ya'll, not even a day.
- [iTerm2](https://www.iterm2.com/) / [zsh](https://github.com/robbyrussell/oh-my-zsh) / [tmux](https://tmux.github.io/) - Performant terminal and shell everywhere.
- [SourceTree](https://www.sourcetreeapp.com) - I can't remember all those weird hard to memorize git commands, so this is my GUI.
- [Transmit](https://panic.com/transmit/) - I'm using it for what it is and It's got everything I want.
- [Paw](https://paw.butt/) - Advanced REST client for testing my backend
- [Little Snitch](https://www.obdev.at/products/littlesnitch) - Sometimes I need to monitor I/O of an application I'm developing.
- [Charles](https://www.charlesproxy.com/) - Monitoring using all the tools even the ones I have no idea what they are.
- [Fritzing](fritzing.org/) - Easily design electronic circuits for Arduino in no time.
- [OsmondCocoa](www.osmondpcb.com/) - Sometimes I need to build a ready to print for some home-made circuits.


### Front-End libraries (js)
- [Webpack 2](https://webpack.github.io/) / [Browsersync](https://www.browsersync.io) - Split all those js files to small bundles depending which react-router you're in, so client doesn't have to download them all at once in addition to HMR.
- [Universal](https://medium.com/@mjackson/universal-javascript-4761051b7ae9) - Let's share js code between client and server + SEO friendly + faster to render
- [GraphQL](https://facebook.github.io/graphql), [Relay](https://facebook.github.io/relay/), [Apollo](https://github.com/apollostack/apollo-client) - Don't spend time implementing REST/ajax calls, it happens in views automaticaly through GraphQL
- [Immutable.js](https://facebook.github.io/immutable-js/) / [seemless-immutable](https://github.com/rtfeldman/seamless-immutable) - Makes comparing all those nested arrays and objects faster.
- [React](https://facebook.github.io/react/) - Not because it's fast, makes me write clean and easy to reason about code, both in front and back-end.
- [React Native](https://facebook.github.io/react-native/) - Much better than apps I made with Ionic and this time truely native.
- [Jest](https://facebook.github.io/jest/), [enzyme](https://github.com/airbnb/enzyme) - Testing at its best.
- [Redux](https://github.com/reactjs/redux) / [MobX](https://github.com/mobxjs/mobx) - When your app gets larger and more complex, you can still predict weird stuff. That's all I can say about this piece of art.
- [CSS Modules](https://github.com/css-modules/css-modules) / [PostCSS](https://github.com/postcss/postcss) / [Styled-Component](https://github.com/styled-components/styled-components)- After all the Sass/Less/Stylus fights, I like it this added on top.
- [JWT](https://jwt.io/), [Passport](passportjs.org) ,[bcrypt.js](https://github.com/ncb000gt/node.bcrypt.js/) - Security is so complicated you can't do it for yourself. Let's just stick to best practices for now.


### Back-End libraries
- [Go](https://golang.org) - Awesome performance + perfect libraries and community around it
- [Drupal](https://drupal.org) - A PHP CMS more like a framework I've used since version 6.
- [Express](http://expressjs.com/) - Standard and well tested
- [Meteor](http://meteor.com) - If it needs to be done ASAP or realtime.


### Techs
- [Go](golang.org) - Concurrent programming with clean syntax made easy and smashing performance.
- [Docker](https://www.docker.com/) - Future of containers.
- [Kubernetes](https://github.com/kubernetes/kubernetes) - Easy to setup but powerful clustering for Dockers.
- [Microservices](https://en.wikipedia.org/wiki/Microservices) / [stdlib](http://stdlib.com/) - Writing Go or Node services in scale made easy.
- [RabbitMQ](https://www.rabbitmq.com/) / [NSQ](https://github.com/nsqio/nsq) - Messaging platform connecting all the pieces.
- [LLVM](http://llvm.org) - Modular and reusable compiler and toolchain technologies used to develop compiler front ends and back ends.
- [ServiceWorkers](https://serviceworke.rs/) / [Progressive](https://developers.google.com/web/progressive-web-apps/) / [WebWorkers](https://hacks.mozilla.org/2016/05/a-taste-of-javascripts-new-parallel-primitives) - Future of web apps in mobile and desktop, seriously.
- [SVG](https://css-tricks.com/using-svg) / [Canvas](www.html5canvastutorials.com) / [GSAP](http://greensock.com/gsap) - I need to make cooler animated websites.
- [Functional Programming](https://github.com/MostlyAdequate/mostly-adequate-guide) - Pure functions equals easier tests(no mocks), less/cleaner/faster code.


### Boilerplates
- [react-boilerplate](https://github.com/mxstbr/react-boilerplate) - React/Redux/Offline first/Immutable.js/Reselect/redux-saga/styled-components
- [Electrode](http://www.electrode.io/) / [next.js](https://github.com/zeit/next.js) - Well tested Univeral JavaScript approaches.
- [create-react-app](https://github.com/facebookincubator/create-react-app) - Create React apps with no build configuration.
- [ignite](https://github.com/infinitered/ignite) - Battle tested stack React Native with redux/sagas/i18n and CLI generators
- [electron-react-boilerplate](https://github.com/chentsulin/electron-react-boilerplate) - React/Redux on top of Electron to build native desktop apps.
- [html5-boilerplate](https://github.com/h5bp/html5-boilerplate) - Keeping close eye on this to see what's the practice.
