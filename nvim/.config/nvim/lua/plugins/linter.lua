-- Linter configuration (nvim-lint)
return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lint = require("lint")

    local js_filetypes = {
      "javascript",
      "typescript",
      "javascriptreact",
      "typescriptreact",
    }

    local function has_local_eslint()
      local found = vim.fs.find({ "node_modules/.bin/eslint" }, {
        upward = true,
        path = vim.fn.expand("%:p:h"),
        type = "file",
      })
      return #found > 0
    end

    local function eslint_available()
      if vim.fn.executable("eslint") == 1 or vim.fn.executable("eslint_d") == 1 then
        return true
      end
      return has_local_eslint()
    end

    lint.linters_by_ft = {}

    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
    vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave" }, {
      group = lint_augroup,
      callback = function()
        if not vim.tbl_contains(js_filetypes, vim.bo.filetype) then
          return
        end
        if not eslint_available() then
          return
        end
        lint.linters_by_ft[vim.bo.filetype] = { "eslint" }
        pcall(function()
          lint.try_lint()
        end)
      end,
    })
  end,
}
