-- Treesitter configuration
return {
  "nvim-treesitter/nvim-treesitter",
  branch = "master",
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    local status_ok, configs = pcall(require, "nvim-treesitter.configs")
    if not status_ok then
      vim.notify("nvim-treesitter.configs not available yet, will be loaded after installation", vim.log.levels.WARN)
      return
    end

    configs.setup({
      ensure_installed = {
        "typescript",
        "javascript",
        "tsx",
        "go",
        "lua",
        "vim",
        "vimdoc",
        "markdown",
        "json",
        "yaml",
      },
      auto_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      indent = { enable = true },
    })
  end,
}
