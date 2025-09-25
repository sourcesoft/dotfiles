let SessionLoad = 1
let s:so_save = &g:so | let s:siso_save = &g:siso | setg so=0 siso=0 | setl so=-1 siso=-1
let v:this_session=expand("<sfile>:p")
silent only
silent tabonly
cd ~/.config/nvim
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
let s:shortmess_save = &shortmess
if &shortmess =~ 'A'
  set shortmess=aoOA
else
  set shortmess=aoO
endif
badd +29 lua/custom/plugins/dashboard.lua
badd +299 init.lua
badd +15 lua/custom/plugins/keybinds.lua
badd +2 lua/custom/plugins/bqf.lua
badd +12 lua/custom/plugins/bufferline.lua
badd +2 lua/custom/plugins/dressing.lua
badd +1 lua/custom/plugins/screenkey.lua
badd +47 lua/custom/plugins/lualine.lua
badd +1 lua/custom/plugins/outline.lua
badd +2 lua/custom/plugins/colorizer.lua
badd +7 lua/custom/plugins/go.lua
badd +43 health://
badd +11 lua/custom/plugins/trouble.lua
badd +8 lua/custom/plugins/persistence.lua
badd +2 lua/custom/plugins/telescope-file-browser.lua
badd +9 lua/kickstart/plugins/gitsigns.lua
argglobal
%argdel
$argadd lua/custom/plugins/neo-tree.lua
edit lua/custom/plugins/keybinds.lua
tcd ~/.config
argglobal
balt ~/.config/nvim/init.lua
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let &fdl = &fdl
let s:l = 15 - ((14 * winheight(0) + 13) / 26)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 15
normal! 057|
tabnext 1
if exists('s:wipebuf') && len(win_findbuf(s:wipebuf)) == 0 && getbufvar(s:wipebuf, '&buftype') isnot# 'terminal'
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20
let &shortmess = s:shortmess_save
let s:sx = expand("<sfile>:p:r")."x.vim"
if filereadable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &g:so = s:so_save | let &g:siso = s:siso_save
set hlsearch
nohlsearch
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
