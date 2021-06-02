" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" ~~~~~ Plugins ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
set nocompatible
call plug#begin()
" ------------------------------------------------
" --- Utility
" ------------------------------------------------
Plug 'mhinz/vim-startify'
Plug 'tpope/vim-surround' " --- handy quick parentheses, brackets, ...
Plug 'wellle/targets.vim' " --- provides additional text objects
Plug 'tpope/vim-commentary' " --- comment code quickly
Plug 'tpope/vim-repeat' " --- repeat everything
Plug 'jiangmiao/auto-pairs' " --- pair and close everything automatically
Plug 'svermeulen/vim-easyclip' " --- d without copying
Plug 'alvan/vim-closetag' " --- close html tags
Plug 'terryma/vim-multiple-cursors' " --- like sublime
Plug 'mattn/emmet-vim' " --- faster html coding
Plug 'benmills/vimux' " --- send commands to tmux
Plug 'airblade/vim-rooter' " --- change root directory on the fly
Plug 'suan/vim-instant-markdown' " --- live markdown edit
Plug 'Shougo/unite.vim' " --- dev helper
Plug 'qpkorr/vim-bufkill' " --- kill buffs without destroying window/split
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
" ------------------------------------------------
" --- Search & Navigate
" ------------------------------------------------
Plug 'chrisbra/improvedft' " --- better f and t
Plug 'lambdalisue/nerdfont.vim'
Plug 'lambdalisue/fern-renderer-nerdfont.vim'
Plug 'LumaKernel/fern-mapping-fzf.vim'
Plug 'lambdalisue/fern.vim' " --- file explorer
Plug 'ctrlpvim/ctrlp.vim' " --- fuzzy search
Plug 'mileszs/ack.vim' " --- ack built in
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } " --- fuzzy search
Plug 'junegunn/fzf.vim' " extra fzf features
Plug 'junegunn/vim-slash' " --- improved searching
Plug 'junegunn/vim-emoji' " --- emoji in vim
Plug 'tpope/vim-unimpaired' " --- awesome mappings
Plug 'joeytwiddle/sexy_scroller.vim' " --- animate scroll
Plug 'jlanzarotta/bufexplorer' " --- list buffers
Plug 'milkypostman/vim-togglelist' " --- toggle quicklist with one command
Plug 'christoomey/vim-tmux-navigator' " --- navigate between tmux and vim
" Plug 'majutsushi/tagbar' " --- show tags on the right sidebar
" Plug 'ludovicchabant/vim-gutentags' " --- update tags automatically
Plug 'amix/open_file_under_cursor.vim'
" ------------------------------------------------
" --- Syntax Highlighting
" ------------------------------------------------
Plug 'dense-analysis/ale' " --- lint engine while typing better than neomake
Plug 'sheerun/vim-polyglot'
Plug 'fatih/vim-go', {'do': ':GoInstallBinaries'}
Plug 'ycm-core/YouCompleteMe', { 'do': './install.py --all' }
" ------------------------------------------------
" --- Misc
" ------------------------------------------------
Plug 'AndrewRadev/splitjoin.vim' " --- GO split and join struct literals
Plug 'tpope/vim-dispatch' " --- asynchronous build and test dispatcher
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
" ------------------------------------------------
" --- Git & Diff
" ------------------------------------------------
Plug 'tpope/vim-fugitive' " --- awesome git
Plug 'airblade/vim-gitgutter'
Plug 'will133/vim-dirdiff' " --- git diff for directories
Plug 'junegunn/gv.vim' " --- git commit browser
Plug 'tpope/vim-rhubarb' " fugitive GitHub handler
" ------------------------------------------------
" --- Snippets using neosnippets
" ------------------------------------------------
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets' " --- snippets
" ------------------------------------------------
" --- Misc
" ------------------------------------------------
" ------------------------------------------------
" --- Look and feel
" ------------------------------------------------
Plug 'vim-airline/vim-airline' " lightweight line
Plug 'vim-airline/vim-airline-themes' " airline theme pack
Plug 'junegunn/goyo.vim' " --- distraction free mode
Plug 'Yggdroot/indentLine' " --- see indents clearly
Plug 'joshdick/onedark.vim'
" Plug 'morhetz/gruvbox' " --- cool theme
call plug#end()
" colorscheme gruvbox " heavy lifting -- disable for better perf
colorscheme onedark


" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" ~~~~~ Defaults settings ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
set nocompatible " make vim usefull
let mapleader="," " leader key
set clipboard=unnamed " Use osx clipboard
set wildmenu " better completion
set lcs=tab:▸\ ,trail:#,nbsp:_ " Show “invisible” characters
set nobk " Don't create backup files 
set ai " Turn on auto indentation
set si " Turn on smart indent
set list
set foldcolumn=1 " extra margin to the left
set fdm=syntax " fold based on syntax
set nofoldenable " don't fold everthing by default
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
set autoread " Automatically read changed files from disk
au FocusGained,BufEnter * :checktime " Also reload when we switch buffers
set report=0 " Show all changes
set showtabline=2 " Always show tab bar
set undofile " Persistent Undo
set undodir=~/.vim/undo " store all the persisted files in a single directory
set title " show file name in window
set shortmess+=c " don't give ins-completion-menu messages.
set signcolumn=yes " always show signcolumns
set mouse=a " enable mouse in all modes
set bs=2
set laststatus=2 " always show status bar
set history=100 " Increase history from 20 default to 100
set hidden
set textwidth=0
" set esckeys " cursor keys in insert mode
set backspace=indent,eol,start " backspace in insert mode
set nobackup " all backups off
set backupcopy=yes
set nowb
set noswapfile " no swap files
set nostartofline " don't jump start of lines
set ruler " Show the cursor position
set switchbuf=usetab,newtab " quickfix opens buffer in existing tabs
set nowrap
set cmdheight=2 " Better display for messages
" -------------
" ------------- Searching
" -------------
set gdefault " Add the g flag to search/replace by default
set hlsearch " hightlight results
set magic
set incsearch " Highlight dynamically as pattern is typed
set ignorecase
set showmatch
set smartcase
" -------------
" ------------- Heavy lifting stuff
" -------------
set updatetime=300 " more frequent updates -- disable for better perf
set regexpengine=1 " use the old engine for better perf
" set lazyredraw " redraw -- disable for better perf
set relativenumber " relatives numbers -- disable for better perf
set number " line numbers
set nocursorline " don't highlight current line -- use iTerm for better perf
set colorcolumn=80 " aditional column width -- disable for better perf
"set showcmd " show command while typing -- disable if slow due to spam
" set synmaxcol=100 " disable to fix some perf issues with large files
" -------------
" ------------- Theme and look
" -------------
syntax enable
syntax on
filetype plugin on
set background=dark
set termguicolors

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" ~~~~~ Plugins configuration ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"
let g:ft_improved_ignorecase = 1 " make f in-casesensitive
let g:AutoPairsShortcutToggle = '' " disable alt-p by autopairs
let g:bufExplorerShowRelativePath=1 " shows shorter path
let g:bufExplorerSortBy='fullpath' " sort by path
let g:rooter_patterns = ['.git']
let g:airline_left_sep='' " no extra characters
let g:airline_right_sep=''
let g:airline_theme='onedark' " airline simple theme
let g:airline_extensions = ['tabline']
let g:airline_highlighting_cache = 1
let g:ale_cache_executable_check_failures = 1
let g:airline#extensions#tabline#enabled = 1 " enable tabline
let g:airline#extensions#tabline#show_tab_nr = 0 " no tab number
let g:airline#extensions#tabline#buffer_nr_show = 1 " show buffer number
let g:airline#extensions#tabline#show_splits = 0 " disable split count
let g:airline#extensions#tabline#fnamemod = ':p:t' " no directories in anem
let g:airline#extensions#tabline#fnamecollapse = 1 " collapse directories
let g:airline#extensions#tabline#formatter = 'jsformatter' " tab names
let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]' " don't need this
let g:airline_section_x = '' " no need for file-type
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#bufferline#enabled = 1 " show buffers
let g:airline#extensions#ale#enabled = 1
let g:vimtex_motion_matchparen = 0
let g:airline_powerline_fonts = 0 " disable for better perf
let g:SexyScroller_EasingStyle = 5 " linear no easing
let g:SexyScroller_ScrollTime = 40 " enough to see
let g:SexyScroller_CursorTime = 5 " better compared to previous
let g:ctrlp_clear_cache_on_exit = 0 " Do not clear filenames cache
let g:ctrlp_map = '' " disable default ctrl-p mapping
let $NVIM_TUI_ENABLE_CURSOR_SHAPE = 1 " pipe cursor in insert mode
let g:neosnippet#snippets_directory = '~/.config/nvim/plugged/vim-snippets/snippets' " extra snippets
let g:closetag_filenames = "*.html,*.xhtml,*.phtml,*.js,*.jsx,*.php"
let g:multi_cursor_use_default_mapping=0 " disable default vim-multiple-cursors mappings
let g:multi_cursor_next_key='<C-y>' " multi select with control-d like sublime
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
let g:go_info_mode = 'guru'
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 0
let g:go_highlight_operators = 0
let g:go_highlight_build_constraints = 1
let g:go_highlight_generate_tags = 1
let g:go_fmt_command = "goimports" " automatically insert import paths
let g:go_fmt_fail_silently = 1
let g:go_fmt_command = "gofmt"
let g:go_jump_to_error = 0
let g:go_def_mapping_enabled = 0 " disable control-t
let g:go_doc_keywordprg_enabled = 0
let g:go_auto_type_info = 0
let g:go_fmt_autosave = 1
let g:go_metalinter_autosave = 1
let g:go_metalinter_command = "golangci-lint"
let g:go_metalinter_autosave_enabled = ['vet', 'golint', 'errcheck']
let g:UltiSnipsExpandTrigger='<C-l>'
" let g:go_auto_sameids = 1
let g:go_snippet_engine = "neosnippet"
let g:go_list_height = 10
" let g:go_debug=1
autocmd FileType json execute "let b:indentLine_enabled=0"
" fern
let g:fern#default_hidden = 1
let g:fern#opener = "split"
let g:fern#drawer_width = 35
let g:fern#renderer = "nerdfont"
" specific linters while typing, disable linting for go
" options including standard, eslint, flow
let g:ale_linters = {
\   'javascript': ['eslint', 'stylelint'],
\   'typescript': ['tsserver', 'stylelint'],
\   'css': ['stylelint'],
\   'go': ['golint', 'govet', 'errcheck'],
\}
let g:flow#enable = 0
let g:ale_sign_column_always = 1
let g:ale_sign_error = '💩'
let g:ale_sign_warning = '⚠️'
let g:ale_javascript_eslint_suppress_missing_config = 0
let g:ale_javascript_eslint_suppress_eslintignore = 1
" let g:ale_javascript_eslint_use_global = 1
" let g:ale_javascript_prettier_use_global = 1
" enable formatter for js and jsx file using prettier
let g:ale_fixers = {}
let g:ale_fixers['javascript'] = ['prettier']
let g:ale_fixers['typescript'] = ['prettier']
let g:ale_fixers['markdown'] = ['prettier']
let g:ale_fixers['json'] = ['prettier']
let g:ale_fixers['jsp'] = ['prettier']
let g:ale_fixers['sql'] = ['sqlformat', 'pgformatter']
let g:ale_fixers['go'] = ['gofmt', 'goimports', 'remove_trailing_lines', 'trim_whitespace']
let g:ale_fix_on_save = 0
let g:ale_javascript_prettier_options = '--single-quote --trailing-comma es5 printWidth=100'
let g:ale_javascript_prettier_use_local_config = 1
let g:ale_echo_msg_format = '%linter% says %s'
command! FIXDisable let ale_fix_on_save=0
command! FIXEnable let ale_fix_on_save=1
" if user calls these options manually, local configuration will be replaced
" so use these options only if you don't have local config in package.json or
" .prettierrc defined.
command! FIXOptionSemi let ale_javascript_prettier_options='--single-quote --trailing-comma es5'
command! FIXOptionNosemi let ale_javascript_prettier_options='--single-quote --trailing-comma --no-semi es5'
command! FIXOptionNosemiTrailing let ale_javascript_prettier_options='--single-quote --no-semi es5'
command! FIXOptionJSON let g:ale_fixers['json'] = ['prettier']

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" ~~~~~ Searching and selecting files ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
" --- leader+ff --- AG and ACK
nnoremap <leader>ff :Ack 
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif
" --- control+v --- selecting and navigating through snippets
imap <C-v> <Plug>(neosnippet_expand_or_jump)
smap <C-v> <Plug>(neosnippet_expand_or_jump)
xmap <C-v> <Plug>(neosnippet_expand_target)
" --- control-f --- search with Ag
nnoremap <C-f> :call ToggleSilverSearch()<cr>
" --- gt --- search git commits
nnoremap gt :Commits<cr>
" --- control-t --- search all files in PROJECT directory using 'fzf'
nnoremap <C-t> :FZF<cr>
" --- control-p --- search all commands
nnoremap <C-p> :Commands<cr>
" --- alt-p --- run a command in current directory using Vim
nnoremap <a-p> :cd %:h<cr>:! 
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
" --- leader-i --- Go: show type
" au FileType go nmap <leader>i <Plug>(go-info)
autocmd BufEnter *.go nmap <leader>i  <Plug>(go-info)
autocmd BufEnter *.go nmap <leader>ci  <Plug>(go-describe)
" --- leader-j --- Go: jump to def in new buffer
au FileType go nmap <leader>j :YcmCompleter GoTo<cr>
" --- leader-j --- Go: show referrer
au FileType go nmap <leader>k :YcmCompleter GoToReferences<cr>
" --- leader-d --- Go: jump to godoc in new split
au FileType go nmap <leader>d <Plug>(go-doc-vertical)
" --- leader-r --- Go: run in new tab
au FileType go nmap <leader>r <Plug>(go-run)
" --- leader-b --- Go: build
au FileType go nmap <leader>b :GoBuild!<CR>
" --- leader-t --- Go: test
au FileType go nmap <leader>t <Plug>(go-test)
" --- leader-c --- Go: show coverage
au FileType go nmap <leader>c <Plug>(go-coverage)
" --- leader-e --- Go: check errors
au FileType go nmap <leader>c :GoErrCheck<cr>
" --- leader-; --- quickly navigate to necessary buffer
" --- iTerm hexcodes: '0x2C 0x3B' --- Command-;
map <leader>; :call ToggleBuf()<cr>
vmap <leader>; <esc>:call ToggleBuf()<cr>
" --- leader-e --- quickly navigate to necessary buffer
map <leader>e :Buffers<cr>
vmap <leader>e <esc>:Buffers<cr>
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


" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" ~~~~~ Movement and navigation ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" --- leader,# --- switch to buffnumber
nnoremap <expr> <Leader>1 Key_leader_bufnum(1)
nnoremap <expr> <Leader>2 Key_leader_bufnum(2)
nnoremap <expr> <Leader>3 Key_leader_bufnum(3)
nnoremap <expr> <Leader>4 Key_leader_bufnum(4)
nnoremap <expr> <Leader>5 Key_leader_bufnum(5)
nnoremap <expr> <Leader>6 Key_leader_bufnum(6)
nnoremap <expr> <Leader>7 Key_leader_bufnum(7)
nnoremap <expr> <Leader>8 Key_leader_bufnum(8)
nnoremap <expr> <Leader>9 Key_leader_bufnum(9)
" --- alt-l, alt-h --- relocate tab right and left with alt-i and alt-o
nnoremap <a-l> :tabm +1<CR>
nnoremap <a-h> :tabm -1<CR>
inoremap <a-l> <ESC>:tabm +1<CR>
inoremap <a-h> <ESC>:tabm -1<CR>
" --- space --- mark with space instead of m, for vim-easyclip
nnoremap <space> m
" --- leader-sj, leader-sk --- jump up or down half screen
" --- iTerm hexcodes: '0x2C 0x6A' --- Command-J
" --- iTerm hexcodes: '0x2C 0x6B' --- Command-K
nnoremap <silent> <leader>sj <C-d>
nnoremap <silent> <leader>sk <C-u>
inoremap <silent> <leader>sj <Esc><C-d>
inoremap <silent> <leader>sk <Esc><C-u>
" --- control-e --- filemanager
nnoremap <silent> <C-e> :call ToggleFileManager()<CR>
inoremap <silent> <C-e> <ESC>:call ToggleFileManager()<CR>
" --- gi, go --- change tabs
nnoremap go :tabn<CR>
nnoremap gi :tabp<CR>
" --- control-i, control-o --- next prev buffers
nnoremap <silent> <C-o> :call NextBuffer()<cr>
nnoremap <silent> <C-i> :call PrevBuffer()<CR>
" inoremap <C-o> <ESC>:call NextBuffer()<CR>
" inoremap <C-i> <ESC>:call PrevBuffer()<CR>
" --- gp --- fuzzy serach buffers
nnoremap gp :Buffers<CR>
" --- <leader>-a --- easier buffer switch
" --- iTerm hexcodes: '0x2C 0x61' --- Cmd-A
nnoremap <leader>a <c-^>
" --- control-w --- close tab or pane
nmap <C-w> :bp<bar>sp<bar>bn<bar>bd<CR>
" --- gu --- close tab or pane
nmap gu :q<CR>
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
" --- control-a --- toggle tagbar
" nnoremap <silent> <c-a> :TagbarToggle<CR>

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" ~~~~~ Editing ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" --- command-s --- run ALEFix
nmap <leader>ss :Prettier<cr>
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
" --- ,-f --- toggle distraction free mode
" --- iTerm hexcodes: '0x2C 0x66' --- Command-F
nnoremap <Leader>f :Goyo<cr>
" --- control+s --- save this buffer
nmap <c-s> :w<CR>
imap <c-s> <Esc>:w<CR>a
" --- alt+s --- save all buffers
nmap <a-s> :wa<CR>
imap <a-s> <Esc>:wa<CR>a
" --- alt-q --- save all buffers, save session based on directory and quit
nmap <a-q> :wqa!<CR>
imap <a-q> <Esc>:wqa!<CR>
" --- automatic --- save and restore session based on current directory.
" we need to use :qa! to quit all buffers at once otherwise only the last one
" is saved.
fu! SaveSess()
  MinimapClose
  call CleanNoNameEmptyBuffers()
  if bufwinnr("fern") == 1
    Fern . -drawer -toggle
  endif
  execute 'mksession! ' . getcwd() . '/Session.vim'
endfunction
" --- We use automatic sessions for neovim only
if has('nvim')
  " Save session on quitting Vim
  autocmd VimLeave * call SaveSess()
endif

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" ~~~~~ Misc ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" Open buffer with 'o' in fern, not just 'e'
autocmd FileType fern nmap <buffer> o <Plug>(fern-action-open)
autocmd FileType fern nmap <buffer> q :Fern . -drawer -toggle<CR>
autocmd FileType fern nmap <buffer> <c-l> :call Wincmdp()<cr>
" --- alt-e --- reload vim
noremap <a-e> <Esc>:source ~/.vimrc<cr>
" --- ,w --- remove trailing spaces manualy if there's any
nnoremap <leader>w :%s/\s\+$//<cr>:let @/=''<CR>
" allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! :w !sudo tee %
" fix c-h bug
if has('nvim')
  nmap <bs> :<c-u>TmuxNavigateLeft<cr>
endif
" move outside filemanager first then switch buffer or list buffers
fu! NextBuffer()
  if bufname()[0:3] == "fern" || bufname() == ""
    wincmd p
  endif
  bn
  if bufname() == ""
    bn
  endif
endfunction
fu! PrevBuffer()
  if bufname()[0:3] == "fern" || bufname() == ""
    wincmd p
  endif
  bp
  if bufname() == ""
    bp
  endif
endfunction
fu! ToggleBuf()
  if bufname()[0:3] == "fern"
    wincmd p
  endif
  ToggleBufExplorer
endfunction
fu! ToggleSilverSearch()
  if bufname()[0:3] == "fern"
    wincmd p
  endif
  Ag
endfunction
" opens filemanager if it's not open already, then switches between file and
" filemanager split
fu! ToggleFileManager()
  if bufwinnr("fern") == 1
    if bufname()[0:3] == "fern"
      wincmd p
    else
      Fern . -reveal=% -drawer
      " FernDo :
    endif
  else
    Fern . -drawer -toggle
  endif
endfunction
" simply calls Wincmdp
fu! Wincmdp()
  wincmd p
endfunction
" quickly switch between buffers by their number
func! Key_leader_bufnum(num)
  let l:buffers = Buflisted()
  let l:input = a:num . ""

  while 1

    let l:cnt = 0
    let l:i=0
    " count matches
    while l:i<len(l:buffers)
      let l:bn = l:buffers[l:i] . ""
      if l:input==l:bn[0:len(l:input)-1]
        let l:cnt+=1
      endif
      let l:i+=1
    endwhile

    " no matches
    if l:cnt==0 && len(l:input)>0
      echo "no buffer [" . l:input . "]"
      return ''
    elseif l:cnt==1
      return ":b " . l:input . "\<CR>"
    endif

    echo ":b " . l:input

    let l:n = getchar()

    if l:n==char2nr("\<BS>") ||  l:n==char2nr("\<C-h>")
      " delete one word
      if len(l:input)>=2
        let l:input = l:input[0:len(l:input)-2]
      else
        let l:input = ""
      endif
    elseif l:n==char2nr("\<CR>") || (l:n<char2nr('0') || l:n>char2nr('9'))
      return ":b " . l:input . "\<CR>"
    else
      let l:input = l:input . nr2char(l:n)
    endif

    let g:n = l:n

  endwhile
endfunc
func! Buflisted()
  return filter(range(1, bufnr('$')), 'buflisted(v:val)')
endfunc
function! CleanNoNameEmptyBuffers()
    let buffers = filter(range(1, bufnr('$')), 'buflisted(v:val) && empty(bufname(v:val))')
    if !empty(buffers)
        exe 'bd '.join(buffers, ' ')
    else
        echo 'No buffer deleted'
    endif
endfunction
"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif
let g:UltiSnipsExpandTrigger='<c-g>'
let g:UltiSnipsJumpForwardTrigger="<c-g>"
