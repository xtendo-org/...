local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "

require("lazy").setup({
  'Vimjas/vim-python-pep8-indent',
  'chrisbra/Recover.vim',
  'christoomey/vim-tmux-navigator',
  'ctrlpvim/ctrlp.vim',
  'glts/vim-magnum',
  'glts/vim-radical',
  'jparise/vim-graphql',
  'jremmen/vim-ripgrep',
  'junegunn/fzf.vim',
  'kamykn/spelunker.vim',
  'simnalamburt/vim-mundo',
  'tpope/vim-commentary',
  'tpope/vim-eunuch',
  'tpope/vim-fugitive',
  'tpope/vim-obsession',
  'tpope/vim-repeat',
  'tpope/vim-surround',
  'tpope/vim-vinegar',
  'vim-airline/vim-airline',
  'vim-python/python-syntax',

  -- LSP
  'neovim/nvim-lspconfig',
  'hrsh7th/nvim-cmp',
  'hrsh7th/cmp-nvim-lsp',

  {"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"},
  {'junegunn/fzf', run = "./install --all"},
})

-- some custom settings

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.smarttab = true
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.nu = true

-- begin neovim-lsp --

local lspconfig = require('lspconfig')

local function get_root_dir(fname)
  return lspconfig.util.root_pattern('.git')(fname) or vim.fn.getcwd()
end

lspconfig.ruff.setup{root_dir = get_root_dir}
lspconfig.basedpyright.setup{root_dir = get_root_dir}
lspconfig.hls.setup{
  root_dir = get_root_dir,
  filetypes = { 'haskell', 'lhaskell', 'cabal' },
  settings = {
    haskell = {
      formattingProvider = "fourmolu",
      plugin = {
        hlint = { globalOn = true },
        semanticTokens = { globalOn = true },
      },
    },
  },
}

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)

    -- Check if the language server supports formatting
    if client.supports_method('textDocument/formatting') then
      -- Map the key combination to format the entire document
      vim.api.nvim_buf_set_keymap(args.buf, 'n', 'gf', '<cmd>lua vim.lsp.buf.format({ async = true })<CR>', { noremap = true, silent = true })
    end
  end,
})

vim.o.updatetime = 250  -- Update diagnostics quickly

vim.cmd [[autocmd CursorHold * lua vim.diagnostic.open_float(nil, {focus=false, scope="cursor"})]]

local cmp = require'cmp'

cmp.setup({
  snippet = {
    expand = function(args)
      vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
    end,
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<C-j>'] = cmp.mapping.confirm({
       -- Accept currently selected item. Set `select` to `false` to only
       -- confirm explicitly selected items.
      select = true
    }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
  })
})

-- For vim-airline

function LspStatus()
  local clients = vim.lsp.get_active_clients()
  if next(clients) == nil then
    return ''
  end
  local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
  for _, client in ipairs(clients) do
    if client.config.filetypes and vim.fn.index(client.config.filetypes, buf_ft) ~= -1 then
      return client.name
    end
  end
  return ''
end

-- Some `q` bindings to run LSP actions

vim.api.nvim_set_keymap('n', 'q', '<Nop>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'qr', '<cmd>lua vim.lsp.buf.rename()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'qq', '<cmd>lua vim.lsp.buf.code_action({ filter = function(a) return a.isPreferred end, apply = true })<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'qa', '<cmd>lua vim.lsp.buf.code_action()<CR>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', { noremap = true, silent = true })

function ClearAndHighlight()
  vim.lsp.buf.clear_references()
  vim.lsp.buf.document_highlight()
end

vim.api.nvim_set_keymap('n', '<leader>r', '<cmd>lua ClearAndHighlight()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>R', '<cmd>lua vim.lsp.buf.clear_references()<CR>', { noremap = true, silent = true })

-- Disable the wraparound behavior of "go to prev/next diagnostic"
vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev({ wrap = false })<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next({ wrap = false })<CR>', { noremap = true, silent = true })

-- end neovim-lsp --

local vimrc = vim.fn.stdpath("config") .. "/nvim_init.vim"
vim.cmd.source(vimrc)

vim.cmd.colorscheme('xtsimple')
