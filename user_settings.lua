local map = require("utils").map
local which_key = require("utils").wk_add

vim.g.mapleader = ","

-- WARN: Do not touch this table.
extra_which_keys = {}

disable_plugins = {
  -- NOTE: These two plugins are for better performance
  -- and fixing one of neovim bugs.
  impatient = false,
  fix_cursor_hold = false,

  -- NOTE: Many plugins use this plugin as a dependency.
  -- I suggest to not remove this plugins.
  plenary = false,

  -- NOTE: These plugins are colorscheme. By default only
  -- enfocado is enabled. you can enable other by changing
  -- true to false.
  tokyonight = false,
  nightfly = false,
  moonfly = false,
  nord = false,
  onedark = false,
  nvim_enfocado = false,

  -- NOTE: These plugins are for debugging. You can install
  -- Some debug servers with dap_install but the list of those
  -- Are realy small. You can install debugger by your self and
  -- then configure it by your self so you can use nvim_dap and nvim_dap_ui
  -- without dap_install
  nvim_dap = false,
  dap_install = false,
  nvim_dap_ui = false,

  -- NOTE: these plugins are telescope and telescope extensions. fzf is for
  -- better searching experince and you can fuzzy find directories with
  -- telescope_find_directories
  telescope_fzf_native = false,
  telescope_find_directories = false,
  telescope = false,

  -- NOTE: scrollview is builtin scrollbar for CodeArt and
  -- And neoscroll is for scroll animation.
  scrollview = false,
  neoscroll = false,

  -- NOTE: nvim-cmp and luasnip are for code completion.
  nvim_cmp = false,
  luasnip = false,
  friendly_snippets = false,
  cmp_buffer = false,
  cmp_path = false,
  cmp_nvim_lsp = false,
  cmp_luasnip = false,
  cmp_nvim_lua = false,

  nvim_web_devicons = false,
  lualine = false,
  nvim_bufferline = false,
  indent_blankline = false,

  better_escape = true, -- For exiting from insert mode with jj and jk

  truezen = false,
  nvim_tree = false,
  treesitter = false,
  nvim_colorizer = false,
  alpha = false,
  nvim_lspconfig = false,
  lsp_installer = false,
  null_ls = false,
  lspsaga = false,
  symbols_outline = false,
  lsp_signature = false,
  toggleterm = false,
  fugitive = false,
  gitsigns = false,
  autopairs = false,
  nvim_ts_autotag = false,
  todo_comments = false,
  which_key = false,
  mkdir = false,
  kommentary = false,
  ts_context_commentstring = false,
  vim_matchup = false,
  vim_resize = false,
}

additional_plugins = {
  -- You can put your additional plugins here.
  -- Syntax is like normal packer.nvim Syntax.
  -- If you need to set some settings for your plugins
  -- you must put configs in config = function() like below examples

  -- { "famiu/feline.nvim", branch = "develop" },

  -- "mhartington/formatter.nvim",

  -- {
    -- "crispgm/nvim-go",
    -- ft = "go",
    -- config = function()
      -- require('go').setup({
        -- notify = true,
        -- formatter = 'gofmt',
        -- auto_lint = false,
      -- })
    -- end,
  -- },

  "rcarriga/nvim-notify",

  {
    "iamcco/markdown-preview.nvim",
    ft = "markdown",
    run = ":call mkdp#util#install()",
    config = function()
      vim.g.mkdp_auto_close = 0
    end,
  },

  -- {
  --   "andweeb/presence.nvim",
  --   config = function()
  --     require("presence"):setup({
  --       log_level = "info", -- Log messages (one of the following: "debug", "info", "warn", "error")
  --       debounce_timeout = 5,
  --       blacklist = {}, -- file name, path, or workspace matches
  --     })
  --   end,
  -- },
    --
  "joeytwiddle/sexy_scroller.vim",
  "famiu/bufdelete.nvim",
  "voldikss/vim-floaterm",
  "Shatur/neovim-session-manager",
  "tversteeg/registers.nvim",
  -- "blackCauldron7/surround.nvim",
  "folke/trouble.nvim",
   {
     'numToStr/Comment.nvim',
     config = function()
       require('Comment').setup({
         toggler = {
           ---Line-comment toggle keymap
           line = '<leader>cc',
           ---Block-comment toggle keymap
           block = '<leader>bc',
         },
         opleader = {
           line = '<leader>c',
           block = '<leader>b',
         },
       })
     end
   },
}

-- NOTE: here
-- Name of functions is exactly like config file in nvim/lua/plugins directory
-- the only diffrence is if in file name you have hifen(-) here you must
-- replace it with underline.
local config = {
  -- null-ls configuration
  null_ls = function()
    -- Formatting and linting
    -- https://github.com/jose-elias-alvarez/null-ls.nvim
    local status_ok, null_ls = pcall(require, "null-ls")
    if not status_ok then
      return
    end

    -- Check supported formatters
    -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
    local formatting = null_ls.builtins.formatting

    -- Check supported linters
    -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
    local diagnostics = null_ls.builtins.diagnostics

    null_ls.setup({
      debug = false,
      sources = {
        -- Settings up some linters and code formatters.
        formatting.black,
        formatting.stylua,
        formatting.rustfmt,
        formatting.clang_format,
        formatting.prettier,
        formatting.taplo,
        formatting.shfmt.with({
          command = "shfmt",
          args = {
            "-i",
            "2",
            "-ci",
            "-bn",
            "$FILENAME",
            "-w",
          },
        }),
        diagnostics.zsh,
        -- diagnostics.luacheck,
        diagnostics.pylint,
      },
      -- This function is for format on save.
      -- on_attach = function(client)
      --   if client.resolved_capabilities.document_formatting then
      --     vim.cmd([[
      --       augroup LspFormatting
      --           autocmd! * <buffer>
      --           autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
      --       augroup END
      --       ]])
      --   end
      -- end,
    })
  end,
  treesitter = {
    highlight = {
      enable = true,
    },
  },
  other_configs = function()
    vim.cmd("colorscheme onedark")
    -- Other settings here
    -- For examples for disabling line number:
    vim.opt.number = true
    vim.opt.relativenumber = true

    -- Or for changing terminal toggle mapping:
    -- first argument is mode of mapping. second argument is keymap.
    -- third argument is command. and last argument is optional argument like {expr = true}.
    -- map("n", "<C-t>", ":ToggleTerm<CR>")
    -- map("t", "<C-t>", ":ToggleTerm<CR>")

    -- This is example of how to make keymap and add it to
    -- which_keys(that pop of window on bottom of NeoVim that help you to find keymaps)
    -- This will make new group of keymaps names Something with two commands and they're describtions.
    -- with pressing `<leader> + s` you can trigger which keys to show you
    -- Something commands. with pressing e it will echo hello on command prompt at the end of NeoVim
    -- and with pressing f it will echo Goodbye on command prompt at the end of NeoVim
    -- wk_add(
    --   {
    --     s = {
    --       name = "Something",
    --       e = { ":echo 'Hello'<CR>", "Echo Hello" },
    --       f = { ":echo 'Goodbye'<CR>", "Echo Goodbye" },
    --     },
    --   },
    --   { prefix = "<leader>", mode = "v" } -- mode = "v" means it only works on visual mode.
    --   extra_which_keys
    -- )

    -- user_lualine_style = 1 -- You can choose between predefined 1, 2, 3, 4 and 5
    -- or you can define your custome seperator like this.
    -- first item is for component seperator and second item is
    -- for section seperator.
    -- user_lualine_style = { { left = " ", right = " " }, { left = "", right = "" } }

    -- user_indent_blankline_style = 1 -- You can choose between predefined 1, 2, 3, 4,5 and 6
    -- or you can use your favorite character.
    -- user_indent_blankline_style = ""
  end,
}

-- Buffer switching.
map("n", "<leader>l", ":BufferLinePick<CR>")
map("n", "<c-o>", ":BufferLineCycleNext<CR>")
map("n", "<c-i>", ":BufferLineCyclePrev<CR>")
map("n", "<Tab>", ":BufferLineCyclePrev<CR>")

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
map("n", "<leader>q", ":bdelete<CR>")

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
map("n", "<leader>o", ":lua vim.lsp.buf.format()<CR>", lsp_opts)

-- Telescop.
map("n", "<Leader>ff", ":Telescope find_files<CR>")
map("n", "<Leader>fw", ":Telescope live_grep<CR>")
map("n", "<Leader>fs", ":Telescope git_status<CR>")
map("n", "<Leader>fc", ":Telescope git_commits<CR>")
map("n", "<Leader>fp", ":Telescope media_files<CR>")
map("n", "<Leader>fb", ":Telescope buffers<CR>")
map("n", "<Leader>fh", ":Telescope help_tags<CR>")
map("n", "<Leader>fo", ":Telescope oldfiles<CR>")

-- Dashboard
--map("n", "<c-s>s", ":lua vim.lsp.buf.formatting()<CR>:w<CR>" )
map("n", "<c-s>s", ":w<CR>" )
map("n", "<c-s>i", ":SessionManager save_current_session<CR>")
map("n", "<C-s>o", ":SessionManager load_session<CR>")
map("n", "<C-s>q", ":SessionManager save_current_session<CR>:qa<CR>")

map("n", "<C-t>", ":FloatermToggle<CR>", lsp_opts)
map("i", "<C-t>", "<ESC>:FloatermToggle<CR>", lsp_opts)
map("n", "<Leader>t", ":TodoTrouble<CR>")

vim.cmd
[[
set timeoutlen=1000
set scrolloff=5 " extra space from edges while scrolling
let g:SexyScroller_EasingStyle = 5 " linear no easing
let g:SexyScroller_ScrollTime = 40 " enough to see
let g:SexyScroller_CursorTime = 5 " better compared to previous
set undofile " Persistent Undo
set undodir=~/.vim/undo " store all the persisted files in a single directory
set colorcolumn=80 " aditional column width -- disable for better perf
" --- esc --- search clear on pressing escape by default
nnoremap <silent> <esc> :noh<CR>
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
"autocmd BufEnter * map <silent> <c-i> :lua prevBuffer()<cr>
"autocmd BufEnter * map <silent> <c-o> :lua nextBuffer()<cr>
autocmd BufEnter * map <silent> <C-e> :lua toggleFileManager()<cr>
autocmd BufEnter * map <silent> <C-p> :Vista<cr>
"autocmd VimEnter * :lua require("surround").setup { mappings_style = "sandwich", prefix = "S" }
]]

map("n", "<leader>e", ":lua toggleFileManager()<CR>")
function toggleFileManager()
    local buffername = vim.fn.expand('%')
    -- local buffername = vim.api.nvim_buf_get_name(0)
    -- vim.api.nvim_feedkeys("<C-w><C-l>", 'n', true)
    -- local bufferexists = vim.api.nvim_exec('echo bufwinnr("NvimTree")', true)
    -- vim.api.nvim_echo({{"hasit"..bufferexists, "None"}}, false, {})
    -- vim.api.nvim_echo({{"hasit"..bufferexists, "None"}}, false, {})
    -- vim.api.nvim_echo({{vim.fn.expand('%'), "None"}}, false, {})
    if  buffername == "NvimTree" or buffername == "NvimTree_1" then
        vim.cmd("wincmd p")
    else
        vim.cmd("NvimTreeFindFile")
    end
end
function nextBuffer()
    local buffername = vim.fn.expand('%')
    if  buffername == "NvimTree" or buffername == "NvimTree_1" then
        vim.cmd("wincmd p")
    end
    vim.cmd("BufferLineCycleNext")
    local buffername = vim.fn.expand('%')
    if  buffername == "NvimTree" or buffername == "NvimTree_1" then
        vim.cmd("wincmd p")
    end
end
function prevBuffer()
    local buffername = vim.fn.expand('%')
    if  buffername == "NvimTree" or buffername == "NvimTree_1" then
        vim.cmd("wincmd p")
    end
    vim.cmd("BufferLineCyclePrev")
end

return config
