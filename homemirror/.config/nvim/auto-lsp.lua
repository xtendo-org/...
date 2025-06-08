-- Returns the Git repo root, or nil if no .git is found
-- before reaching /home/<anyuser> or /
local function get_git_root()
  local fn   = vim.fn
  local path = fn.getcwd()

  while path and path ~= "" do
    -- Found a .git directory here?
    if fn.isdirectory(path .. "/.git") == 1 then
      return path
    end

    -- Stop if we've hit any /home/<username> or the root '/'
    if path == "/" or path:match("^/home/[^/]+$") then
      return nil
    end

    -- Climb up one directory
    path = fn.fnamemodify(path, ":h")
  end

  return nil
end

-- helper: look for `name` in ./.venv/bin/, else in $PATH
local function find_executable(name)
  local root = get_git_root()
  if root == nil then
    return nil
  end

  local venv_bin = root .. "/.venv/bin/" .. name
  if vim.fn.executable(venv_bin) == 1 then
    return venv_bin
  elseif vim.fn.executable(name) == 1 then
    return name
  end

  return nil
end


vim.lsp.config('*', {
  capabilities = {
    textDocument = {
      semanticTokens = {
        multilineTokenSupport = true,
      }
    }
  },
  root_markers = { '.git' },
})

vim.lsp.enable('ruff')

-- Setup BasedPyright if found
do
  local cmd = find_executable("basedpyright-langserver")
  if cmd then
    vim.lsp.config('basedpyright', {
      cmd = { cmd, "--stdio" },
    })
    vim.lsp.enable('basedpyright')
  else
    vim.lsp.enable('ty')
  end
end

vim.lsp.config('hls', {
  settings = {
    haskell = {
      formattingProvider = "fourmolu",
      plugin = {
        hlint = { globalOn = true },
        semanticTokens = { globalOn = true },
      },
    },
  },
})
vim.lsp.enable('hls')

vim.lsp.enable('openscad_lsp')

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

vim.api.nvim_set_keymap('n', 'qr', '<cmd>lua vim.lsp.buf.rename()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'qq', '<cmd>lua vim.lsp.buf.code_action({ filter = function(a) return a.isPreferred end, apply = true })<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'qa', '<cmd>lua vim.lsp.buf.code_action()<CR>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', { noremap = true, silent = true })

function ClearAndHighlight()
  vim.lsp.buf.clear_references()
  vim.lsp.buf.document_highlight()
end

vim.api.nvim_set_keymap('n', '<leader>r', '<cmd>lua ClearAndHighlight()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>R', '<cmd>lua vim.lsp.buf.clear_references()<CR>', { noremap = true, silent = true })

-- Disable the wraparound behavior of "go to prev/next diagnostic"
vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev({ wrap = false })<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next({ wrap = false })<CR>', { noremap = true, silent = true })


----------------------------------------------------------------------
-- 1. Stop LSP from hijacking gq and other built-in format commands
----------------------------------------------------------------------
-- Make it global, but also reset it every time an LSP attaches
-- (some servers / plugins set it again)
vim.o.formatexpr = ""

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    vim.bo[ev.buf].formatexpr = ""   -- keep it empty for this buffer
  end,
})

----------------------------------------------------------------------
-- 2. Map NORMAL-mode gf → LSP format whole buffer
----------------------------------------------------------------------
vim.keymap.set("n", "gf",
  function() vim.lsp.buf.format({ async = true }) end,
  { desc = "LSP format (whole file)" }
)
