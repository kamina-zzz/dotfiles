-- nvim-tree configuration
return {
  "nvim-tree/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  cmd = { "NvimTreeToggle", "NvimTreeFocus" },
  keys = {
    { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Toggle file explorer" },
  },
  config = function()
    -- Disable netrw
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    local WIDTH = 50

    require("nvim-tree").setup({
      view = {
        width = WIDTH,
        preserve_window_proportions = true,
      },
      filters = {
        dotfiles = false,
      },
      git = {
        enable = true,
        ignore = false,
      },
      renderer = {
        group_empty = true,
        icons = {
          show = {
            git = true,
            folder = true,
            file = true,
            folder_arrow = true,
          },
        },
      },
    })

    -- Restore nvim-tree width after any window layout change
    vim.api.nvim_create_autocmd({ "WinResized", "WinEnter" }, {
      callback = function()
        for _, win in ipairs(vim.api.nvim_list_wins()) do
          local buf = vim.api.nvim_win_get_buf(win)
          if vim.bo[buf].filetype == "NvimTree" and vim.api.nvim_win_get_width(win) ~= WIDTH then
            vim.api.nvim_win_set_width(win, WIDTH)
          end
        end
      end,
    })
  end,
}
