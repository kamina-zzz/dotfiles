-- Autocommands configuration

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
  end,
  desc = "Highlight on yank",
})

-- Close certain windows with 'q'
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "qf", "help", "man", "lspinfo", "spectre_panel" },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
  desc = "Close with 'q'",
})

-- Check if file changed when focus is gained
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
  command = "checktime",
  desc = "Check if file changed outside of Neovim",
})

-- Resize splits if window got resized (preserve nvim-tree width)
vim.api.nvim_create_autocmd({ "VimResized" }, {
  callback = function()
    local nvim_tree_width = 50
    vim.cmd("tabdo wincmd =")
    -- Restore nvim-tree width after equalize
    for _, win in ipairs(vim.api.nvim_list_wins()) do
      local buf = vim.api.nvim_win_get_buf(win)
      if vim.bo[buf].filetype == "NvimTree" then
        vim.api.nvim_win_set_width(win, nvim_tree_width)
      end
    end
  end,
  desc = "Resize splits on window resize",
})

-- Open nvim-tree on startup
vim.api.nvim_create_autocmd({ "VimEnter" }, {
  callback = function()
    -- Delay to ensure nvim-tree is loaded
    vim.defer_fn(function()
      local nvim_tree_api = require("nvim-tree.api")
      nvim_tree_api.tree.open()

      -- If file arguments were passed, focus on the file window
      -- Otherwise, keep focus on nvim-tree
      if vim.fn.argc() > 0 then
        vim.cmd("wincmd l")
      end
    end, 10)
  end,
  desc = "Open nvim-tree on startup",
})

-- Auto-delete empty unnamed buffers when opening a real file
vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function()
    -- Don't run for telescope or other special buffers
    local ft = vim.bo.filetype
    if ft == "TelescopePrompt" or ft == "TelescopeResults" or ft == "NvimTree" then
      return
    end

    -- Get list of all buffers
    local buffers = vim.api.nvim_list_bufs()

    -- Find empty unnamed buffers
    for _, buf in ipairs(buffers) do
      if vim.api.nvim_buf_is_valid(buf) and vim.api.nvim_buf_is_loaded(buf) then
        local name = vim.api.nvim_buf_get_name(buf)
        local buf_ft = vim.bo[buf].filetype

        -- Skip special buffers
        if buf_ft == "TelescopePrompt" or buf_ft == "TelescopeResults" or buf_ft == "NvimTree" then
          goto continue
        end

        local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
        local is_empty = #lines == 1 and lines[1] == ""
        local is_modified = vim.bo[buf].modified

        -- Delete if: unnamed, empty, unmodified, and not current buffer
        if name == "" and is_empty and not is_modified and buf ~= vim.api.nvim_get_current_buf() then
          pcall(vim.api.nvim_buf_delete, buf, { force = false })
        end

        ::continue::
      end
    end
  end,
  desc = "Auto-delete empty unnamed buffers",
})
