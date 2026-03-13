-- Options configuration
local opt = vim.opt

-- Clipboard (use macOS system clipboard)
opt.clipboard = "unnamedplus"

-- Line numbers
opt.number = true

-- Mouse
opt.mouse = "a"

-- Search
opt.hlsearch = true
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true

-- Cursor
opt.cursorline = true

-- Tab settings (default to 2 spaces, sleuth will auto-detect)
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.smartindent = true

-- UI
opt.termguicolors = true
opt.signcolumn = "yes:2"
opt.scrolloff = 8
opt.wrap = true
opt.linebreak = true
opt.breakindent = true

-- Split windows
opt.splitbelow = true
opt.splitright = true
opt.equalalways = false

-- Undo
opt.undofile = true
opt.undolevels = 10000

-- Disable swap files
opt.swapfile = false

-- Update time
opt.updatetime = 200

-- Completion
opt.completeopt = "menu,menuone,noselect"
