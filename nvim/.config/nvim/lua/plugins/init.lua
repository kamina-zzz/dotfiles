-- Plugins initialization
require("lazy").setup({
  -- Import all plugin specs
  { import = "plugins.colorscheme" },
  { import = "plugins.treesitter" },
  { import = "plugins.lsp" },
  { import = "plugins.completion" },
  { import = "plugins.telescope" },
  { import = "plugins.nvim-tree" },
  { import = "plugins.lualine" },
  { import = "plugins.bufferline" },
  { import = "plugins.gitsigns" },
  { import = "plugins.formatter" },
  { import = "plugins.linter" },
  { import = "plugins.comment" },
  { import = "plugins.autopairs" },
  { import = "plugins.which-key" },
  { import = "plugins.colorizer" },
  { import = "plugins.todo-comments" },
  { import = "plugins.persistence" },
  { import = "plugins.focus" },
  { import = "plugins.markdown" },
  { import = "plugins.sleuth" },
}, {
  checker = { enabled = true },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
