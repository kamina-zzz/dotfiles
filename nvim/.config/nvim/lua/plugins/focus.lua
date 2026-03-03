-- Focus configuration
return {
  "nvim-focus/focus.nvim",
  event = "VeryLazy",
  config = function()
    require("focus").setup({
      enable = true,
      autoresize = {
        enable = true,
        width = 0,
        height = 0,
        minwidth = 20,
        minheight = 5,
      },
    })
  end,
}
