local l_modules = {
  'Vimjas/vim-python-pep8-indent',
  'glts/vim-magnum',
  'glts/vim-radical',
  'jparise/vim-graphql',
  'vim-python/python-syntax',

  -- LSP
  'neovim/nvim-lspconfig',
  'hrsh7th/nvim-cmp',
  'hrsh7th/cmp-nvim-lsp',

  {"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"},
}

return { l_modules = l_modules }
