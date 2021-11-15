-- Function for make mapping easier.
local function map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then options = vim.tbl_extend("force", options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end
local function nmap(mode, lhs, rhs, opts)
  local options = {noremap = false}
  if opts then options = vim.tbl_extend("force", options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

vim.g.mapleader = ","
vim.g.tokyonight_style = "storm" -- styles: storm, night and day.
vim.g.onedark_style = "dark"     -- styles: dark, darker, cool, deep, warm and warmer.
vim.cmd("colorscheme onedark")


additional_plugins = {
    "famiu/bufdelete.nvim",
    { "mfussenegger/nvim-dap", ft = "go" },
    "voldikss/vim-floaterm",
    "tversteeg/registers.nvim",
    {
        "folke/trouble.nvim",
        requires = "kyazdani42/nvim-web-devicons",
    },
    {
        "blackCauldron7/surround.nvim",
        cmd = ':lua require("surround").setup { mappings_style = "sandwich", prefix = "S" }'
    }
}

local lsp_opts = { noremap=true, silent=true }

-- Buffer switching.
map("n", "<C-i>", ":lua prevBuffer()<CR>")
map("n", "<C-o>", ":lua nextBuffer()<CR>")
map("n", "<leader>l", ":BufferLinePick<CR>")

-- Split navigations.
map("n", "<C-j>", "<C-w><C-j>")
map("n", "<C-k>", "<C-w><C-k>")
map("n", "<C-l>", "<C-w><C-l>")
map("n", "<C-h>", "<C-w><C-h>")

-- Buffer resizing.
map("n", "<S-h>", ":call ResizeLeft(3)<CR><Esc>")
map("n", "<S-l>", ":call ResizeRight(3)<CR><Esc>")
map("n", "<S-k>", ":call ResizeUp(1)<CR><Esc>")
map("n", "<S-j>", ":call ResizeDown(1)<CR><Esc>")

-- Buffer closing.
map("n", "<leader>q", ":Bdelete<CR>")

-- Buffer moving.
map("n", "<leader>bl", ":BufferLineMoveNext<CR>")
map("n", "<leader>bh", ":BufferLineMovePrev<CR>")
map("n", "<leader>sj", "<C-d>", lsp_opts)
map("n", "<leader>sk", "<C-u>", lsp_opts)

-- NvimTree toggle
map("n", "<leader>e", ":NvimTreeFindFile<CR>")

map("n", "<leader>j", ":lua vim.lsp.buf.definition()<CR>", lsp_opts) -- def
map("n", "<leader>k", ":lua vim.lsp.buf.references()<CR>", lsp_opts) -- ref
map("n", "<leader>i", ":lua vim.lsp.buf.hover()<CR>", lsp_opts)
map("n", "<leader>o", ":lua vim.lsp.buf.formatting()<CR>", lsp_opts)

map("n", "<leader>c", ":CommentToggle<CR>")
map("v", "<leader>c", ":'<,'>CommentToggle<CR>")

-- Telescop.
map("n", "<Leader>fw", ":Telescope live_grep<CR>")
map("n", "<Leader>gt", ":Telescope git_status<CR>")
map("n", "<Leader>cm", ":Telescope git_commits<CR>")
map("n", "<Leader>ff", ":Telescope find_files<CR>")
map("n", "<Leader>fp", ":Telescope media_files<CR>")
map("n", "<Leader>fb", ":Telescope buffers<CR>")
map("n", "<Leader>fh", ":Telescope help_tags<CR>")
map("n", "<Leader>fo", ":Telescope oldfiles<CR>")

-- Dashboard
map("n", "<Leader>db", ":Dashboard<CR>")
map("n", "<Leader>fn", ":DashboardNewFile<CR>")
map("n", "<Leader>bm", ":DashboardJumpMarks<CR>")
map("n", "<c-s>s", ":lua vim.lsp.buf.formatting()<CR>:w<CR>", lsp_opts)
map("n", "<C-s>o", ":SessionLoad<CR>:call CleanNoNameEmptyBuffers()<CR>:call ResizeDown(200)<CR>")
map("n", "<C-s>i", ":SessionSave<CR>")
map("n", "<C-s>q", ":call SaveSess()<CR>:SessionSave<CR>:qa<CR>")
--map("n", "<C-s>q", ":SessionSave<CR>:qa<CR>")

map("n", "<C-t>", ":FloatermToggle<CR>", lsp_opts)
map("i", "<C-t>", "<ESC>:FloatermToggle<CR>", lsp_opts)
map("n", "<Leader>t", ":TodoTrouble<CR>")

vim.cmd
[[
set undofile " Persistent Undo
set undodir=~/.vim/undo " store all the persisted files in a single directory
set colorcolumn=80 " aditional column width -- disable for better perf
" --- <leader>-a --- easier buffer switch
" --- iTerm hexcodes: '0x2C 0x61' --- Cmd-A
nnoremap <leader>a <c-^>
let g:vista_stay_on_open = 0
function! CleanBuffers()
    let vistabn = bufnr("__vista__")
    if vistabn != -1
        exe 'bwipeout '.vistabn
    endif
    let nvimtreebn = bufnr("NvimTree")
    if nvimtreebn != -1
        exe 'bwipeout '.nvimtreebn
    endif
endfunction
function! CleanNoNameEmptyBuffers()
    call CleanBuffers()
    let buffers = filter(range(1, bufnr('$')), 'buflisted(v:val) && empty(bufname(v:val))')
    if !empty(buffers)
        exe 'bd '.join(buffers, ' ')
    endif
endfunction
function! CleanZeroLinesBuffers()
    let bufferszerolines = filter(range(1, bufnr('$')), 'buflisted(v:val) && len(getbufline(v:val, 1, "$")) == 0')
    if !empty(bufferszerolines)
        exe 'bd '.join(bufferszerolines, ' ')
    endif
endfunction
function! CleanNvimTreeBuffer()
    let currentcwd = getcwd()
    let splitcwd = split(currentcwd, "/")
    echo splitcwd
    let firstIndex = splitcwd[0]
    if firstIndex == "home" || firsindex == "~"
        echo firstIndex
    endif
endfunction
function! IsEmptyNvimTreeBuffer()
    let currentcwd = getcwd()
    let splitcwd = split(currentcwd, "/")
    echo splitcwd
    let firstIndex = splitcwd[0]
    if firstIndex == "home" || firsindex == "~"
        return true
    endif
    return false
endfunction

fu! SaveSess()
  call CleanBuffers()
endfunction

fu! ToggleNvimTree()
    call timer_start(900, { tid -> execute('NvimTreeToggle')})
endfunction

autocmd VimEnter * call ToggleNvimTree()
autocmd VimLeave * call SaveSess()
"autocmd BufEnter * call CleanNoNameEmptyBuffers()
autocmd BufEnter * map <silent> <c-i> :lua prevBuffer()<cr>
autocmd BufEnter * map <silent> <c-o> :lua nextBuffer()<cr>
autocmd BufEnter * map <silent> <C-e> :lua toggleFileManager()<cr>
autocmd BufEnter * map <silent> <C-p> :Vista<cr>
autocmd VimEnter * :lua require("surround").setup { mappings_style = "sandwich", prefix = "S" }
]]

map("n", "<leader>e", ":lua toggleFileManager()<CR>")
function toggleFileManager()
    local buffername = vim.fn.expand('%')
    -- local buffername = vim.api.nvim_buf_get_name(0)
    -- vim.api.nvim_feedkeys("<C-w><C-l>", 'n', true)
    -- local bufferexists = vim.api.nvim_exec('echo bufwinnr("NvimTree")', true)
    -- vim.api.nvim_echo({{"hasit"..bufferexists, "None"}}, false, {})
    if  buffername == "NvimTree" then
        vim.cmd("wincmd p")
    else
        vim.cmd("NvimTreeFindFile")
    end
end
function nextBuffer()
    local buffername = vim.fn.expand('%')
    if  buffername == "NvimTree" then
        vim.cmd("wincmd p")
    end
    vim.cmd("BufferLineCycleNext")
    local buffername = vim.fn.expand('%')
    if  buffername == "NvimTree" then
        vim.cmd("wincmd p")
    end
end
function prevBuffer()
    local buffername = vim.fn.expand('%')
    if  buffername == "NvimTree" then
        vim.cmd("wincmd p")
    end
    vim.cmd("BufferLineCyclePrev")
end
