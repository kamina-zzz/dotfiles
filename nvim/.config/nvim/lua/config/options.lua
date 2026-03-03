-- Options configuration
local opt = vim.opt

-- Clipboard (OSC 52 for iOS sharing)
opt.clipboard = "unnamedplus"

-- OSC 52 clipboard configuration
vim.g.clipboard = {
  name = "OSC 52",
  copy = {
    ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
    ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
  },
  paste = {
    ["+"] = require("vim.ui.clipboard.osc52").paste("+"),
    ["*"] = require("vim.ui.clipboard.osc52").paste("*"),
  },
}

-- Line numbers
opt.number = true
opt.relativenumber = true

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
opt.signcolumn = "yes"
opt.scrolloff = 8
opt.wrap = false

-- Split windows
opt.splitbelow = true
opt.splitright = true

-- Undo
opt.undofile = true
opt.undolevels = 10000

-- Update time
opt.updatetime = 200

-- Completion
opt.completeopt = "menu,menuone,noselect"
