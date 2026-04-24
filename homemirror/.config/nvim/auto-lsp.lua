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

-- -- Use "local" BasedPyright if found
-- do
--   local cmd = find_executable("basedpyright-langserver")
--   if cmd then
--     vim.lsp.config('basedpyright', {
--       cmd = { cmd, "--stdio" },
--     })
--   end
-- end
vim.lsp.enable('basedpyright')

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

  flags = { allow_incremental_sync = false },

})
vim.lsp.enable('hls')

vim.api.nvim_create_autocmd("BufDelete", {
  pattern = {"*.hs","*.lhs"},
  callback = function(args)
    vim.lsp.buf_notify(args.buf, "textDocument/didClose", {
      textDocument = { uri = vim.uri_from_bufnr(args.buf) },
    })
  end,
})

vim.lsp.enable('openscad_lsp')

if vim.fn.executable("./node_modules/.bin/typescript-language-server") == 1 then
  vim.lsp.config('ts_ls', {
    cmd = { "pnpx", "typescript-language-server", "--stdio" },
    on_attach = function(client)
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.documentRangeFormattingProvider = false
    end,
  })
  vim.lsp.enable('ts_ls')
end

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

-- Some `q` and `g` bindings to run LSP actions

vim.api.nvim_set_keymap('n', 'qr', '<cmd>lua vim.lsp.buf.rename()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'qq', '<cmd>lua vim.lsp.buf.code_action({ filter = function(a) return a.isPreferred end, apply = true })<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'qa', '<cmd>lua vim.lsp.buf.code_action()<CR>', { noremap = true, silent = true })

vim.keymap.set("n", "qd", function() vim.diagnostic.open_float() end, { desc = "Open float of LSP diagnostic" })

vim.api.nvim_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', { noremap = true, silent = true })

function ClearAndHighlight()
  vim.lsp.buf.clear_references()
  vim.lsp.buf.document_highlight()
end

vim.api.nvim_set_keymap('n', '<leader>r', '<cmd>lua ClearAndHighlight()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>R', '<cmd>lua vim.lsp.buf.clear_references()<CR>', { noremap = true, silent = true })

-- LSP Diagnostic
vim.diagnostic.config({
  jump = {
    on_jump = function(diagnostic, bufnr)
      if not diagnostic then
        return
      end

      vim.diagnostic.open_float({
        bufnr = bufnr,
        scope = "cursor",
        pos = { diagnostic.lnum, diagnostic.col },
        source = "if_many",
      })
    end,
  },
})

local function diagnostic_jump(count)
  return function()
    vim.diagnostic.jump({
      count = count,
      -- wrap = false,
    })
  end
end

vim.keymap.set("n", "[d", diagnostic_jump(-1), { silent = true, desc = "Previous diagnostic" })
vim.keymap.set("n", "]d", diagnostic_jump(1),  { silent = true, desc = "Next diagnostic" })

-- Stop LSP from hijacking gq and other built-in format commands
----------------------------------------------------------------------
-- Make it global, but also reset it every time an LSP attaches
-- (some servers / plugins set it again)
vim.o.formatexpr = ""

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    vim.bo[ev.buf].formatexpr = ""   -- keep it empty for this buffer
  end,
})

vim.highlight.priorities.semantic_tokens = 1

-- suppress semantic highlight for certain Syntax groups
do
  -- empty attrs group
  vim.api.nvim_set_hl(0, "SemNoop", {})

  local function syntax_has_builtin(buf, row0, col0)
    local pos = vim.inspect_pos(buf, row0, col0, {
      treesitter = false, extmarks = false, semantic_tokens = false, syntax = true,
    })
    for _, it in ipairs(pos.syntax or {}) do
      if it.hl_group == "Builtin" then return true end
    end
    return false
  end

  vim.api.nvim_create_autocmd("LspTokenUpdate", {
    callback = function(ev)
      local t = ev.data.token
      if t.type ~= "method" then return end
      if syntax_has_builtin(ev.buf, t.line, t.start_col) then
        -- overwrite this token with an inert HL at higher semantic priority
        vim.lsp.semantic_tokens.highlight_token(
          t, ev.buf, ev.data.client_id, "SemNoop",
          { priority = vim.hl.priorities.semantic_tokens + 3 } -- > @lsp.type/@lsp.typemod
        )
      end
    end,
  })
end

local conform = require("conform")

conform.setup({
  formatters_by_ft = {
    javascript = { "eslint_d", "prettierd" },
    javascriptreact = { "eslint_d", "prettierd" },
    typescript = { "eslint_d", "prettierd" },
    typescriptreact = { "eslint_d", "prettierd" },
  },

  -- formatters = {
  --   eslint_d = {
  --     command = "pnpm",
  --     args = { "exec", "eslint_d", "--stdin", "--stdin-filename", "$FILENAME" },
  --     stdin = true,
  --   },
  -- },

  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 1000,
    lsp_format = "fallback",
  },
})

-- LSP-aware format command that falls back to conform.nvim
local js_ts_fts = {
  javascript = true,
  javascriptreact = true,
  typescript = true,
  typescriptreact = true,
}

local function format_lsp_or_conform()
  local bufnr = vim.api.nvim_get_current_buf()
  local ft = vim.bo[bufnr].filetype

  if not js_ts_fts[ft] then
    vim.lsp.buf.format({ bufnr = bufnr, async = true })
    return
  end

  conform.format({
    bufnr = bufnr,
    lsp_format = "never",
  })
end

-- Map NORMAL-mode gf → LSP format whole buffer
vim.keymap.set("n", "gf",
  format_lsp_or_conform,
  { desc = "LSP format (whole file)" }
)

vim.keymap.set("n", "<leader>ss", function() require("fzf-lua").lsp_workspace_symbols() end)
vim.keymap.set("n", "<leader>so", function() require("fzf-lua").lsp_document_symbols() end)

-- Configure nvim-lint
local lint = require("lint")

local function configure_nvim_lint()
  -- 1. Configure the default eslint_d linter to use pnpm
  lint.linters.eslint_d = {
    cmd = "pnpm",
    args = { "exec", "eslint_d", "--format", "json", "--stdin", "--stdin-filename", function() return vim.api.nvim_buf_get_name(0) end },
    stdin = true,
    append_fname = false,
    stream = "stdout",
    ignore_exitcode = true,
    parser = require("lint.parser").from_errorformat("%f:%l:%c: %m", {
      source = "eslint_d",
    }),
  }

  vim.keymap.set("n", "ql", function()
    lint.try_lint()
  end, { desc = "Run lint" })

  vim.keymap.set("n", "qf", function()
    local buf = vim.api.nvim_get_current_buf()
    local filename = vim.api.nvim_buf_get_name(buf)

    -- 2. Update the command to use pnpm instead of a hardcoded path
    local cmd = "pnpm"
    local args = { "exec", "eslint_d", "--stdin", "--fix-to-stdout", "--stdin-filename", filename }

    if filename == "" then
      return
    end

    local input = table.concat(vim.api.nvim_buf_get_lines(buf, 0, -1, false), "\n")
    if vim.bo[buf].endofline then
      input = input .. "\n"
    end

    require("conform").format({
      bufnr = buf,
      lsp_format = "never",
    })

    -- 3. Update vim.system to use the pnpm command structure
    vim.system(vim.list_extend({ cmd }, args), { text = true, stdin = input }, function(res)
      vim.schedule(function()
        if res.code ~= 0 then
          vim.notify(res.stderr ~= "" and res.stderr or res.stdout, vim.log.levels.ERROR)
          return
        end

        local output = res.stdout
        if output == input then
          lint.try_lint()
          return
        end

        local view = vim.fn.winsaveview()
        local lines = vim.split(output, "\n", { plain = true, trimempty = false })
        local has_eol = output:sub(-1) == "\n"

        if has_eol then
          table.remove(lines, #lines)
        end

        vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
        vim.bo[buf].endofline = has_eol
        vim.fn.winrestview(view)
        lint.try_lint()
      end)
    end)
  end)
end

configure_nvim_lint()
