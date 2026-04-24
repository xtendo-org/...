local l_modules = {
  'airblade/vim-gitgutter',
  'chrisbra/Recover.vim',
  'christoomey/vim-tmux-navigator',
  'ctrlpvim/ctrlp.vim',
  'junegunn/fzf.vim',
  'simnalamburt/vim-mundo',
  'tpope/vim-eunuch',
  'tpope/vim-fugitive',
  'tpope/vim-obsession',
  'tpope/vim-repeat',
  'tpope/vim-surround',
  'vim-airline/vim-airline',

  {
    'stevearc/oil.nvim',
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {},
    -- Optional dependencies
    dependencies = { { "nvim-mini/mini.icons", opts = {} } },
    lazy = false,
  },

  {
    'refractalize/oil-git-status.nvim',
    dependencies = {
      "stevearc/oil.nvim",
    },
    config = false,
  },

  -- 'tpope/vim-commentary',
  -- 'tpope/vim-vinegar',

  {'junegunn/fzf', run = "./install --all"},
}

return { l_modules = l_modules }
