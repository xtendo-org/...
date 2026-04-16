local l_modules = {
  'Vimjas/vim-python-pep8-indent',
  'glts/vim-magnum',
  'glts/vim-radical',
  'jparise/vim-graphql',
  'stevearc/conform.nvim',
  'vim-python/python-syntax',

  -- LSP
  "ibhagwan/fzf-lua",
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/nvim-cmp',
  'neovim/nvim-lspconfig',

  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPost", "BufWritePost", "InsertLeave" },
    config = function()
      local lint = require("lint")

      lint.linters_by_ft = {
        javascript = { "eslint_d" },
        javascriptreact = { "eslint_d" },
        typescript = { "eslint_d" },
        typescriptreact = { "eslint_d" },
      }

      lint.linters.eslint_d.cmd = "./node_modules/.bin/eslint_d"

      local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost" }, {
        group = lint_augroup,
        callback = function()
          lint.try_lint()
        end,
      })

      vim.keymap.set("n", "<leader>l", function()
        lint.try_lint()
      end, { desc = "Run lint" })
    end,
  },

  -- {"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"},

}

return { l_modules = l_modules }
