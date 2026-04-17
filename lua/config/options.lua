-- Options configuration (converted from settings.vimrc)

local opt = vim.opt
local g = vim.g

-- General settings
opt.autoread = true         -- Pick up changes made outside of Neovim
opt.showcmd = true          -- Show (partial) command in status line
opt.showmatch = true        -- Show matching brackets
opt.ignorecase = true       -- Do case insensitive matching
opt.smartcase = true        -- Do smart case matching
opt.incsearch = true        -- Incremental search
opt.hidden = true           -- Hide buffers when they are abandoned
opt.mouse = 'a'             -- Enable mouse usage (all modes)
opt.background = 'dark'     -- Dark background
opt.scrolloff = 10          -- Keep 10 lines below and above the cursor

-- Wild menu
opt.wildmenu = true
opt.wildmode = 'full'
opt.wildcharm = 26          -- Ctrl-Z

-- Numbering
opt.number = true
opt.relativenumber = true

-- Extra settings
opt.title = true            -- Title of the window
opt.history = 1000          -- Number of recorded changes in history
opt.undolevels = 3000
opt.backup = false
opt.swapfile = false
opt.hlsearch = true         -- Highlight search
opt.matchtime = 2
opt.matchpairs:append('<:>')
opt.wildignore = '*.svn,*.bak,*.swp'
opt.termguicolors = true    -- Enable 24-bit colors
opt.ruler = true
opt.foldcolumn = '3'
opt.splitbelow = true       -- When splitting a new file will be placed below
opt.splitright = true       -- When splitting a new file will be placed right

-- Indentation
opt.expandtab = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.autoindent = true

-- Encoding
opt.encoding = 'utf-8'
opt.fileencoding = 'utf-8'

-- Persistent undo
opt.undodir = vim.fn.expand('~/.vim/undodir')
opt.undofile = true

-- Timeout
opt.timeoutlen = 500

-- Completion
opt.pumwidth = 40
opt.pumheight = 15

-- Sign column
if vim.fn.has('patch-8.1.1564') == 1 then
    opt.signcolumn = 'number'
else
    opt.signcolumn = 'yes'
end

-- Update time
opt.updatetime = 300

-- Command height
opt.cmdheight = 1

-- Don't pass messages to completion menu
opt.shortmess:append('c')

-- For better experience
opt.hidden = true
opt.backup = false
opt.writebackup = false

-- Global statusline (recommended for avante.nvim)
opt.laststatus = 3

