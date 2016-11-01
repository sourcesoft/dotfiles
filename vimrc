" ------- Global config
" Use Karabiner in OSX to map escape->right_command and control->caps_lock.
" There's no need to reach escape key :)
" https://github.com/tekezo/Karabiner-Elements
"
" Configuration is for NeoVim based on vimrc.js for JS development only
" https://github.com/zperrault/vimrc.js
" https://github.com/ryanoasis/nerd-fonts

" -------- Plugins in adition to vimrc.js:
" tpope/vim-fugitive
" vim-airline/vim-airline
" vim-airline/vim-airline-themes
" joeytwiddle/sexy_scroller.vim
" mileszs/ack.vim
" svermeulen/vim-easyclip
" mhinz/vim-startify
" ryanoasis/vim-devicons


" -------- Defaults
set tabstop=2
set shiftwidth=2
set expandtab
set smarttab
set splitbelow
set splitright
set visualbell
set showcmd
set scrolloff=5
set autoread
set ruler
set title
set number
set relativenumber
set nocursorline
set bs=2
set laststatus=2


" -------- Performance boost
"set ttyfast
set lazyredraw


" -------- Plugins configuration
let g:airline_theme='sol'
let g:airline#extensions#whitespace#enabled = 0
let g:vimtex_motion_matchparen = 0
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline_powerline_fonts = 1
let g:SexyScroller_EasingStyle = 4


" -------- Searching
set hlsearch
set incsearch
set ignorecase
set showmatch
set smartcase
" Clear search pressing esc
nnoremap <esc> :noh<return><esc>
nnoremap <esc>^[ <esc>^[
" AG and ACK
nnoremap <C-f> :Ack 
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif


" -------- Better movement
nnoremap j gj
nnoremap k gk
" Mark sth with K instead of m, it's used for deleting without copy. see:vim-easyclip
nnoremap K m
nnoremap <C-j> <C-d>
nnoremap <C-k> <C-u>
" Move this line up or down
noremap <a-j> ddp
noremap <a-k> ddkP
" Nerdtree control+e
nnoremap <C-e> :NERDTreeToggle<CR>
inoremap <C-e> <ESC>:NERDTreeToggle<CR>
" Splits default
set winheight=30
set winminheight=5
" Change tabs
map <c-o> :bn<cr>
map <c-i> :bp<cr>
map <c-u> :bd<cr>
" Jump to splits
"nnoremap <C-j> <C-w>j
"nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
nnoremap <C-u> <C-w>x
" Resizing splits
nnoremap <silent> + :exe "resize " . (winheight(0) * 3/2)<CR>
nnoremap <silent> - :exe "resize " . (winheight(0) * 2/3)<CR>
nnoremap - <C-w>>
nnoremap = <C-w><


" -------- Theme and look
"set background=dark
"colorscheme solarized


" -------- Misc
" sessions
map <F2> :mksession! ~/vim_session <cr> " Quick write session with F2
map <F3> :source ~/vim_session <cr>     " And load session with F3
" remove trailing spaces manualy if there's any
nnoremap <leader>w :%s/\s\+$//<cr>:let @/=''<CR>
" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %
