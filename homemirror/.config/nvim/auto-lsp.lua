local lspconfig = require('lspconfig')

local function get_root_dir(fname)
  return lspconfig.util.root_pattern('.git')(fname) or vim.fn.getcwd()
end

lspconfig.ruff.setup{root_dir = get_root_dir}
lspconfig.basedpyright.setup{root_dir = get_root_dir}
lspconfig.hls.setup{
  root_dir = lspconfig.util.root_pattern("hie.yaml", "stack.yaml", "cabal.project", "*.cabal", "package.yaml"),
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
lspconfig.openscad_lsp.setup{
  root_dir = get_root_dir,
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
  }),
  enabled = function()
    -- disable completion in comments
    local context = require 'cmp.config.context'
    -- keep command mode completion enabled when cursor is in a comment
    if vim.api.nvim_get_mode().mode == 'c' then
      return true
    else
      return not context.in_treesitter_capture("comment")
        and not context.in_syntax_group("Comment")
    end
  end
})

-- For vim-airline

function LspStatus()
  local clients = vim.lsp.get_clients()
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

vim.g.airline_section_y = "%{v:lua.LspStatus()}"

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
