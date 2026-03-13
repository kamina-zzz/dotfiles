-- Keymaps configuration

-- Set leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Clear search highlight
vim.keymap.set("n", "<Esc><Esc>", ":nohlsearch<CR>", { silent = true, desc = "Clear search highlight" })

-- Window navigation (matching tmux)
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to bottom window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to top window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- File explorer
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { silent = true, desc = "Toggle file explorer" })

-- Telescope
vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Live grep" })
vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Find buffers" })
vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Find help" })

-- Buffer navigation
vim.keymap.set("n", "<S-h>", ":bprevious<CR>", { silent = true, desc = "Previous buffer" })
vim.keymap.set("n", "<S-l>", ":bnext<CR>", { silent = true, desc = "Next buffer" })
vim.keymap.set("n", "<leader>bd", function()
  local buf = vim.api.nvim_get_current_buf()
  -- 次のバッファに移動してから削除
  vim.cmd("bnext")
  -- 移動できなかった場合（最後のバッファ）は前のバッファへ
  if buf == vim.api.nvim_get_current_buf() then
    vim.cmd("bprevious")
  end
  -- 元のバッファを削除
  vim.cmd("bdelete " .. buf)
end, { silent = true, desc = "Delete buffer" })
vim.keymap.set("n", "<leader>bD", function()
  local current = vim.api.nvim_get_current_buf()
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if buf ~= current and vim.api.nvim_buf_is_loaded(buf) then
      vim.cmd("bdelete " .. buf)
    end
  end
end, { silent = true, desc = "Delete all buffers except current" })
vim.keymap.set("n", "<leader>bx", ":%bd<CR>", { silent = true, desc = "Delete all buffers" })

-- Better indenting
vim.keymap.set("v", "<", "<gv", { desc = "Indent left" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right" })

-- Move selected lines
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })
