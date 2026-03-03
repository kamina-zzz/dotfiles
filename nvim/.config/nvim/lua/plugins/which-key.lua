-- Which-key configuration
return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  config = function()
    local wk = require("which-key")
    wk.setup({
      plugins = {
        marks = true,
        registers = true,
        spelling = {
          enabled = true,
          suggestions = 20,
        },
      },
    })

    -- Register leader key groups
    wk.add({
      { "<leader>f", group = "Find" },
      { "<leader>b", group = "Buffer" },
      { "<leader>c", group = "Code" },
      { "<leader>h", group = "Git Hunk" },
      { "<leader>q", group = "Session" },
      { "<leader>r", group = "Rename" },
    })
  end,
}
