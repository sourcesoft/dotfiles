" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" ~~~~~ Notes ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" Use Karabiner in OSX to map escape->right_command and control->caps_lock.
" There's no need to reach escape key :)
" https://github.com/tekezo/Karabiner-Elements
"
" Configuration is based on NeoVim, vimrc.js, tmux, iterm2, OSX.
" I use alt for some key mappings, so this is suitable for Mac+iTerm only,
"
" -------------
" ------------- Get the environment and key bindings working:
" -------------
" --- https://github.com/zperrault/vimrc.js
" --- https://github.com/neovim/neovim/wiki/FAQ#how-can-i-change-the-cursor-shape-in-the-terminal
" --- https://github.com/neovim/neovim/wiki/FAQ#my-ctrl-h-mapping-doesnt-work
" --- https://github.com/neovim/neovim/issues/2048
" --- http://stackoverflow.com/questions/6778961
" --- http://stackoverflow.com/questions/39645253
" --- http://www.nthelp.com/ascii.htm
" --- http://superuser.com/questions/259614
"
" -------------
" ------------- Hex code mappings for iTerm:
" -------------
" --- cmd-o: 0x01 0x29 --- tmux next session
" --- cmd-i: 0x01 0x28 --- tmux previous session
" --- cmd-j: 0x2C 0x6A --- vim jump page down
" --- cmd-k: 0x2C 0x6B --- vim jump page up
" --- cmd-m: 0x2C 0x6D --- vim quickfix previous
" --- cmd-n: 0x2C 0x6E --- vim quickfix next
" --- cmd-n: 0x2C 0x71 --- vim quickfix toggle
" --- cmd-p: 0x2C 0x70 --- vim run tmux command
" --- cmd-r: 0x2C 0x72 --- vim run last tmux command
" --- cmd-f: 0x2C 0x66 --- vim toggle tagbar
" --- cmd-;: 0x2C 0x3B --- list buffers
" --- cmd-a: 0x2C 0x61 --- search current buffer subdirectory
" --- ctrl-space: 0x2C 0x76 --- lookup Dash.app docs
"
" -------------
" ------------- Plugins in adition to vimrc.js:
" -------------
" --- tpope/vim-fugitive  --- awesome git
" --- joeytwiddle/sexy_scroller.vim  --- animate scroll
" --- jistr/vim-nerdtree-tabs  --- nerdtree in all tabs
" --- ctrlpvim/ctrlp.vim  --- fuzzy search
" --- mileszs/ack.vim  --- ack built in
" --- svermeulen/vim-easyclip  --- d without annoying copying
" --- mhinz/vim-startify  --- shows latest buffers
" --- alvan/vim-closetag  --- close html tags
" --- terryma/vim-multiple-cursors  --- like sublime
" --- mattn/emmet-vim  --- faster html coding
" --- vim-airline/vim-airline --- light and fast status bar
" --- vim-airline/vim-airline-themes --- airline theme pack
" --- ryanoasis/vim-devicons  --- file icons
" --- ap/vim-css-color  --- css colors
" --- morhetz/gruvbox  --- cool theme
" --- Shougo/neosnippet.vim  --- engine
" --- Shougo/neosnippet-snippets  --- snippets #1
" --- honza/vim-snippets  --- snippets #2
" --- ternjs/tern_for_vim  --- intelligent js
" --- junegunn/vim-slash  --- improved searching
" --- junegunn/goyo.vim  --- distraction free
" --- tpope/vim-unimpaired  --- awesome mappings
" --- jelera/vim-javascript-syntax --- JavaScript syntax
" --- fleischie/vim-styled-components --- styled-components highlight
" --- will133/vim-dirdiff --- git diff for directories
" --- benmills/vimux --- send commands to tmux
" --- christoomey/vim-tmux-navigator --- navigate between tmux and vim
" --- edkolev/tmuxline.vim --- tmux status for vim
" --- airblade/vim-rooter --- change root directory on the fly
" --- majutsushi/tagbar  --- tagbar sidebar
" --- jlanzarotta/bufexplorer  --- list buffers
" --- fatih/vim-go  --- Go plugin
" --- zchee/deoplete-go  --- Go completion
" --- tpope/vim-dispatch  --- asynchronous build and test dispatcher
" --- milkypostman/vim-togglelist --- toggle quicklist with one command
" --- rizzatti/dash.vim --- offline doc
" --- AndrewRadev/splitjoin.vim --- split and join struct literals
" --- w0rp/ale --- lint engine while typing better than neomake
" --- sbdchd/neoformat --- format based on prettier



" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" ~~~~~ Defaults settings ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
set nocompatible " make vim usefull
let mapleader="," " leader key
set clipboard=unnamed " Use osx clipboard
set wildmenu " better completion
set lcs=tab:▸\ ,trail:#,nbsp:_ " Show “invisible” characters
set list
set foldcolumn=1 " extra margin to the left
set autoindent " Copy indent from last line when starting new line
set expandtab " use spaces instead of tabs
set smarttab " beginning of the line jumps to right place
set tabstop=2 " 2 spaces for each tab
set softtabstop=2 " Tab key results in 2 spaces
set shiftwidth=2 " size of indent, same as tabstop
set splitbelow
set splitright
set visualbell " Use visual bell instead of audible bell
set noerrorbells " Disable error bells
set noshowmode " show current mode
set scrolloff=5 " extra space from edges while scrolling
set autoread
set report=0 " Show all changes
set showtabline=2 " Always show tab bar
set undofile " Persistent Undo
set title " show file name in window
set shortmess=atI " no intro message
set mouse=a " enable mouse in all modes
set bs=2
set laststatus=2 " always show status bar
set history=100 " Increase history from 20 default to 100
set hidden
set textwidth=80
set esckeys " cursor keys in insert mode
set backspace=indent,eol,start " backspace in insert mode
set nobackup " all backups off
set nowb
set noswapfile " no swap files
set nostartofline " don't jump start of lines
set ruler " Show the cursor position
set switchbuf+=usetab,newtab " quickfix opens buffer in existing tabs
" -------------
" ------------- Searching
" -------------
set gdefault " Add the g flag to search/replace by default
set hlsearch " hightlight results
set incsearch " Highlight dynamically as pattern is typed
set ignorecase
set showmatch
set smartcase
" -------------
" ------------- Heavy lifting stuff
" -------------
set updatetime=750 " more frequent updates -- disable for better perf
set regexpengine=1 " use the old engine for better perf
set lazyredraw " redraw -- disable for better perf
set relativenumber " relatives numbers -- disable for better perf
set number " line numbers
set nocursorline " don't highlight current line -- use iTerm for better perf
set colorcolumn=80 " aditional column width -- disable for better perf
"set showcmd " show command while typing -- disable if slow due to spam
set synmaxcol=100 " fix some perf issues with large files
" -------------
" ------------- Theme and look
" -------------
syntax on
set background=dark
colorscheme gruvbox " heavy lifting -- disable for better perf



" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" ~~~~~ Plugins configuration ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
let g:tmuxline_powerline_separators = 0
let g:neomake_css_enabled_makers = ['stylelint'] " stylelint
let g:airline_left_sep='' " no extra characters
let g:airline_right_sep=''
let g:airline_theme='powerlineish' " airline simple theme
let g:airline_extensions = ['branch', 'tabline', 'ctrlp', 'hunks']
let g:airline#extensions#tabline#enabled = 1 " enable tabline
let g:airline#extensions#tabline#show_tab_nr = 0 " no tab number
let g:airline#extensions#tabline#show_splits = 0 " disable split count
let g:airline#extensions#tabline#fnamemod = ':p:t' " no directories in anem
let g:airline#extensions#tabline#fnamecollapse = 1 " collapse directories
let g:airline#extensions#tabline#formatter = 'unique_tail_improved' " tab names
let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]' " don't need this
let g:airline_section_x = '' " no need for file-type
let g:airline#extensions#tabline#left_sep = ' '
let g:airlinse#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tmuxline#enabled = 1 " tmux fix
let g:vimtex_motion_matchparen = 0
let g:airline_powerline_fonts = 0 " disable for better perf
let g:SexyScroller_EasingStyle = 5 " linear no easing
let g:SexyScroller_ScrollTime = 40 " enough to see
let g:SexyScroller_CursorTime = 5 " better compared to previous
let g:ctrlp_clear_cache_on_exit = 0 " Do not clear filenames cache
let g:ctrlp_map = '' " disable default ctrl-p mapping
let $NVIM_TUI_ENABLE_CURSOR_SHAPE = 1 " pipe cursor in insert mode
let g:deoplete#enable_at_startup = 1 " start deoplete
let g:neosnippet#snippets_directory = '~/.config/nvim/plugged/vim-snippets/snippets' " extra snippets
let g:deoplete#file#enable_buffer_path = 1 " includes from the current buffer
let g:tern#command = ["tern"] " fix for deoplete-ternjs and tern_for_vim
let g:tern#arguments = ["--persistent"]
let g:tern_request_timeout = 3 " longer timeout for tern lookup
let g:tern_show_signature_in_pum = 1 " completion for function arguments
let g:tern_show_argument_hints='on_hold' " update arguments after updatetime
let g:closetag_filenames = "*.html,*.xhtml,*.phtml,*.js,*.jsx,*.php"
let g:multi_cursor_use_default_mapping=0 " disable default vim-multiple-cursors mappings
let g:multi_cursor_next_key='<C-d>' " multi select with control-d like sublime
let g:multi_cursor_prev_key='<C-p>' " deselect last one
let g:multi_cursor_quit_key='<Esc>' " clear selection
" let g:user_emmet_leader_key='<C-r>' " run emmet
let g:user_emmet_mode='a' " enable emmet in all modes
let g:goyo_width=120 " distraction free mode at 120 width
let g:indent_guides_enable_on_vim_startup = 1 " enable indent guide
let g:indent_guides_guide_size = 1 " thin indent guides
let g:tmux_navigator_no_mappings = 1 " disable default tmuxnavigator mappings
let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck'] " fix syntastic and vim-go perf
let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }
let g:go_highlight_functions = 1 " Go syntax highlighting
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 0
let g:go_highlight_operators = 0
let g:go_highlight_build_constraints = 1
let g:go_highlight_generate_tags = 1
let g:go_fmt_command = "goimports" " automatically insert import paths
let g:go_fmt_fail_silently = 1
let g:go_fmt_command = "gofmt"
let g:go_list_type = "quickfix"
let g:go_jump_to_error = 0
let g:go_doc_keywordprg_enabled = 0
let g:go_auto_type_info = 0
let g:go_fmt_autosave = 1
let g:go_auto_sameids = 1
let g:go_snippet_engine = "neosnippet"
let g:go_list_height = 10
" tagbar config for Go
let g:tagbar_type_go = {
\ 'ctagstype' : 'go',
\ 'kinds'     : [
		\ 'p:package',
		\ 'i:imports:1',
		\ 'c:constants',
		\ 'v:variables',
		\ 't:types',
		\ 'n:interfaces',
		\ 'w:fields',
		\ 'e:embedded',
		\ 'm:methods',
		\ 'r:constructor',
		\ 'f:functions'
\ ],
\ 'sro' : '.',
\ 'kind2scope' : {
		\ 't' : 'ctype',
		\ 'n' : 'ntype'
\ },
\ 'scope2kind' : {
		\ 'ctype' : 't',
		\ 'ntype' : 'n'
\ },
\ 'ctagsbin'  : 'gotags',
\ 'ctagsargs' : '-sort -silent'
\ }
" NERDTree General properties
let NERDTreeDirArrows=1
let NERDTreeMinimalUI=1
let NERDTreeIgnore=['\.o$', '\.pyc$', '\.php\~$']
let NERDTreeWinSize = 35
" NERDTree Make sure that when NT root is changed, Vim's pwd is also updated
let NERDTreeChDirMode = 2
let NERDTreeShowLineNumbers = 1
let NERDTreeAutoCenter = 1
" auto build to find errors on save
autocmd BufWritePre *.go silent! :GoBuild!
" tmuxline look and feel
let g:tmuxline_preset = {
\'a'    : '  #S  ',
\'b'    : '',
\'c'    : '',
\'win'  : ' #I-#W ',
\'cwin' : ' #I-#W ',
\'x'    : '#(whoami)',
\'y'    : '#[fg=green]#(rainbarf --nobattery --width 25 --rgb --no-bright)#[default]',
\'z'    : '#H'}
" specific linters while typing, disable linting for go
let g:ale_linters = {
\   'javascript': ['eslint', 'flow'],
\   'go': [],
\}
" enable formatter for js and jsx file using prettier
let g:neoformat_enabled_javascript = ['prettier']
let g:neoformat_enabled_jsx = ['prettier']
" format using prettier while saving
" autocmd BufWritePre *.js silent! Neoformat

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" ~~~~~ Searching and selecting files ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" --- control+f --- AG and ACK
nnoremap <C-f> :Ack 
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif
" --- control+v --- selecting and navigating through snippets
imap <C-v> <Plug>(neosnippet_expand_or_jump)
smap <C-v> <Plug>(neosnippet_expand_or_jump)
xmap <C-v> <Plug>(neosnippet_expand_target)
" --- leader-a --- search files in CURRENT BUFFER directory using 'fzf'
" --- iTerm hexcodes: '0x2C 0x61' --- Cmd-A
nnoremap <leader>a :cd %:h<cr>:FZF<cr>
" --- control-t --- search all files in PROJECT directory using 'fzf'
nnoremap <C-t> :FZF<cr>
" --- control-p --- run a command in current directory using Vim
nnoremap <C-p> :cd %:h<cr>:! 
" --- leader-p --- run a command using tmux
" --- iTerm hexcodes: '0x2C 0x70' --- Command-P
nnoremap <leader>p :call VimuxRunCommand("")<left><left>
" --- leader-r --- run the last command again using tmux
" --- iTerm hexcodes: '0x2C 0x72' --- Command-R
nnoremap <leader>r :call VimuxRunLastCommand()<cr>
" --- esc --- search clear on pressing escape by default
nnoremap <silent> <esc> :noh<CR>
" --- control-n --- create a new file in current buffer directory
nnoremap <C-n> :tabe %:h/
" --- alt-c, alt-v --- JS: jump to definition file in new preview or tab window
nnoremap <a-v> :TernDefTab<CR>
inoremap <a-v> <ESC>:TernDefTab<CR>
nnoremap <a-c> :TernDefPreview<CR>
" --- leader-i --- Go: show type
au FileType go nmap <leader>i <Plug>(go-info)
" --- leader-j --- Go: jump to def in new split
au FileType go nmap <leader>j <Plug>(go-def-vertical)
" --- leader-d --- Go: jump to godoc in new split
au FileType go nmap <leader>d <Plug>(go-doc-vertical)
" --- leader-r --- Go: run in new tab
au FileType go nmap <leader>r <Plug>(go-run-tab)
" --- leader-b --- Go: build
au FileType go nmap <leader>b :GoBuild!<CR>
" --- leader-t --- Go: test
au FileType go nmap <leader>t <Plug>(go-test)
" --- leader-c --- Go: show coverage
au FileType go nmap <leader>c <Plug>(go-coverage)
" --- leader-e --- Go: check errors
au FileType go nmap <leader>c :GoErrCheck<cr>
" --- leader-f --- open tagbar
" --- iTerm hexcodes: '0x2C 0x66' --- Command-F
nnoremap <leader>f :TagbarToggle<CR>
au FileType go nnoremap <leader>f :GoDeclsDir<CR>
" --- leader-; --- quickly navigate to necessary buffer
" --- iTerm hexcodes: '0x2C 0x3B' --- Command-;
map <leader>; :BufExplorer<cr>
vmap <leader>; <esc>:BufExplorer<cr>
" --- leader-m --- previous in quickfix list
" --- iTerm hexcodes: '0x2C 0x6D' --- Command-M
au FileType go map <leader>m :cprevious<CR>
au FileType javascript map <leader>m <Plug>(ale_previous_wrap)
" --- leader-n --- next in quickfix list
" --- iTerm hexcodes: '0x2C 0x6E' --- Command-N
au FileType go map <leader>n :cnext<CR>
au FileType javascript map <leader>n <Plug>(ale_next_wrap)
" --- leader-q --- toggle quickfix list
" --- iTerm hexcodes: '0x2C 0x71' --- Command-B
nmap <script> <silent> <leader>q :call ToggleQuickfixList()<CR>
" --- leader-q --- toggle quickfix list
" --- iTerm hexcodes: '0x2C 0x76' --- Control-Space
map <leader>v :Dash<CR>



" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" ~~~~~ Movement and navigation ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" --- alt-l, alt-h --- relocate tab right and left with alt-i and alt-o
nnoremap <a-l> :tabm +1<CR>
nnoremap <a-h> :tabm -1<CR>
inoremap <a-l> <ESC>:tabm +1<CR>
inoremap <a-h> <ESC>:tabm -1<CR>
" --- space --- mark with space instead of m, for vim-easyclip
nnoremap <space> m
" --- leader-j, leader-k --- jump up or down half screen
" --- iTerm hexcodes: '0x2C 0x6A' --- Command-J
" --- iTerm hexcodes: '0x2C 0x6B' --- Command-K
nnoremap <leader>sj <C-d>
nnoremap <leader>sk <C-u>
inoremap <leader>sj <Esc><C-d>
inoremap <leader>sk <Esc><C-u>
" --- control-e --- nerdtree control+e
nnoremap <C-e> :NERDTreeFind<CR>
inoremap <C-e> <ESC>:NERDTreeFind<CR>
" --- control-i, control-o --- change tabs
nnoremap <C-o> :tabn<CR>
nnoremap <C-i> :tabp<CR>
inoremap <C-o> <ESC>:tabn<CR>
inoremap <C-i> <ESC>:tabp<CR>
" --- control-u --- close tab or pane
nmap <C-u> :q<CR>
" --- control-h, control-j, control-k, control-l --- Jump to panes
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
inoremap <C-h> <Esc><C-w>h
inoremap <C-l> <Esc><C-w>l
inoremap <C-j> <Esc><C-w>j
inoremap <C-k> <Esc><C-w>k
" --- control-h, control-j, control-k, control-l --- tmux navigation
nnoremap <silent> <C-k> :TmuxNavigateUp<cr>
nnoremap <silent> <C-j> :TmuxNavigateDown<cr>
nnoremap <silent> <C-l> :TmuxNavigateRight<cr>
nnoremap <silent> <C-h> :TmuxNavigateLeft<cr>
inoremap <silent> <C-k> <esc>:TmuxNavigateUp<cr>
inoremap <silent> <C-j> <esc>:TmuxNavigateDown<cr>
inoremap <silent> <C-l> <esc>:TmuxNavigateRight<cr>
inoremap <silent> <C-h> <esc>:TmuxNavigateLeft<cr>
" --- =, - --- Resizing panes
nnoremap = <C-w>>
nnoremap - <C-w><



" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" ~~~~~ Editing ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" --- p --- paste with indent by default
nnoremap p :set paste<cr>]p:set nopaste<cr>
" --- >, < --- don't lose selection after indenting
vnoremap > >gv
vnoremap < <gv
" --- shift-k --- add new lines top
nnoremap <s-k> m`O<ESC>``
" --- shift-f --- add new lines below, don't lose cursor position or change mode
nnoremap <s-j> m`o<ESC>``
" --- alt+; --- add semicolons at the end of line even in insert mode
inoremap <a-;> <Esc>m`A;<Esc>``i
nnoremap <a-;> m`A;<Esc>``
" --- alt+, --- add comma at the end of line even in insert mode
inoremap <a-,> <Esc>m`A,<Esc>``i
nnoremap <a-,> m`A,<Esc>``
" --- Git
noremap <Leader>ga :Gwrite<CR>
noremap <Leader>gc :Gcommit<CR>
noremap <Leader>gp :Gpush<CR>
noremap <Leader>gg :Gpull<CR>
noremap <Leader>gs :Gstatus<CR>
noremap <Leader>gb :Gblame<CR>
noremap <Leader>gd :Gvdiff<CR>
noremap <Leader>gr :Gremove<CR>



" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" ~~~~~ Buffers and sessions ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" --- control-m --- toggle distraction free mode
nnoremap <Leader>z :Goyo<cr>
" --- control+s --- save this buffer
nmap <c-s> :w<CR>
imap <c-s> <Esc>:w<CR>a
" --- alt+s --- save all buffers
nmap <a-s> :wa<CR>
imap <a-s> <Esc>:wa<CR>a
" --- alt-q --- save all buffers, save session based on directory and quit
nmap <a-q> :wqa!<CR>
imap <a-q> <Esc>:wqa!<CR>
" --- alt-w --- save special session and all buffers
nmap <a-w> :mksession! ~/vim_session <cr>:wqa!<CR>
imap <a-w> <esc>:mksession! ~/vim_session <cr>:wqa!<CR>
" --- alt-r --- restore special session
map <a-r> :source ~/vim_session <cr>
" --- automatic --- save and restore session based on current directory.
" we need to use :qa! to quit all buffers at once otherwise only the last one
" is saved. Also we use FindRootDirectory() utility from airblade/vim-rooter
" plugin so we always have the correct pwd, using native pwd is buggy sometimes.
fu! SaveSess()
		execute 'mksession! ' . getcwd() . '/.session.vim'
endfunction
fu! RestoreSess()
if filereadable(getcwd() . '/.session.vim')
		execute 'so ' . getcwd() . '/.session.vim'
		if bufexists(1)
				for l in range(1, bufnr('$'))
						if bufwinnr(l) == -1
								exec 'sbuffer ' . l
						endif
				endfor
		endif
endif
syntax on
endfunction
" Save session on quitting Vim
autocmd VimLeave * NERDTreeClose
autocmd VimLeave * call SaveSess()
" Restore session on starting Vim
autocmd VimEnter * nested call RestoreSess()
autocmd VimEnter * NERDTree



" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" ~~~~~ Misc ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" --- alt-e --- reload vim
noremap <a-e> <Esc>:source ~/.vimrc.js/vimrc<cr>
" --- ,w --- remove trailing spaces manualy if there's any
nnoremap <leader>w :%s/\s\+$//<cr>:let @/=''<CR>
" allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! :w !sudo tee %
" fix c-h bug
if has('nvim')
  nmap <bs> :<c-u>TmuxNavigateLeft<cr>
endif
