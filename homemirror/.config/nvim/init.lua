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

-- Example using a list of specs with the default options
vim.g.mapleader = " " -- Make sure to set `mapleader` before lazy so your mappings are correct

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

  'neovim/nvim-lspconfig',
  'hrsh7th/nvim-cmp',
  'hrsh7th/cmp-nvim-lsp',

  -- lazy = false,
  -- dependencies = {
  --   { "ms-jpq/coq_nvim", branch = "coq" },
  -- },

  -- 'nvim-lua/plenary.nvim',
  -- 'nvim-tree/nvim-web-devicons',
  -- 'tamago324/lir.nvim',
  -- {'neoclide/coc.nvim', branch = 'release'},
  {"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"},
  {'junegunn/fzf', run = "./install --all"},
})

-- require'nvim-treesitter.configs'.setup {
--   ensure_installed = {
--     "c",
--     "lua",
--     "python",
--     "query",
--     "vim",
--     "vimdoc",
--   },
--   sync_install = false,
--   auto_install = true,
--   highlight = {
--     enable = true,
--     additional_vim_regex_highlighting = false,
--   },
-- }



-- some custom settings

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.smarttab = true
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.nu = true

---- begin coc.nvim --

--vim.opt.backup = false
--vim.opt.writebackup = false

---- Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
---- delays and poor user experience
--vim.opt.updatetime = 300

---- Always show the signcolumn, otherwise it would shift the text each time
---- diagnostics appeared/became resolved
--vim.opt.signcolumn = "yes"

--local keyset = vim.keymap.set
---- Autocomplete
--function _G.check_back_space()
--    local col = vim.fn.col('.') - 1
--    return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
--end

---- Use Tab for trigger completion with characters ahead and navigate
---- NOTE: There's always a completion item selected by default, you may want to enable
---- no select by setting `"suggest.noselect": true` in your configuration file
---- NOTE: Use command ':verbose imap <tab>' to make sure Tab is not mapped by
---- other plugins before putting this into your config
--local opts = {silent = true, noremap = true, expr = true, replace_keycodes = false}
--keyset("i", "<TAB>", 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', opts)
--keyset("i", "<S-TAB>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], opts)

---- -- Make <CR> to accept selected completion item or notify coc.nvim to format
---- -- <C-g>u breaks current undo, please make your own choice
---- keyset("i", "<cr>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], opts)

---- Use <c-j> to trigger snippets
--keyset("i", "<c-j>", "<Plug>(coc-snippets-expand-jump)")
---- Use <c-space> to trigger completion
--keyset("i", "<c-space>", "coc#refresh()", {silent = true, expr = true})

--local opts = {silent = true, noremap = true, expr = true, replace_keycodes = false}
--keyset("i", "<c-e>", 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', opts)
--keyset("i", "<c-a>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], opts)
--keyset("i", "<c-j>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], opts)

---- Use `[g` and `]g` to navigate diagnostics
---- Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
--keyset("n", "[g", "<Plug>(coc-diagnostic-prev)", {silent = true})
--keyset("n", "]g", "<Plug>(coc-diagnostic-next)", {silent = true})

---- GoTo code navigation
--keyset("n", "gd", "<Plug>(coc-definition)", {silent = true})
--keyset("n", "gy", "<Plug>(coc-type-definition)", {silent = true})
--keyset("n", "gi", "<Plug>(coc-implementation)", {silent = true})
--keyset("n", "gr", "<Plug>(coc-references)", {silent = true})


---- Use K to show documentation in preview window
--function _G.show_docs()
--    local cw = vim.fn.expand('<cword>')
--    if vim.fn.index({'vim', 'help'}, vim.bo.filetype) >= 0 then
--        vim.api.nvim_command('h ' .. cw)
--    elseif vim.api.nvim_eval('coc#rpc#ready()') then
--        vim.fn.CocActionAsync('doHover')
--    else
--        vim.api.nvim_command('!' .. vim.o.keywordprg .. ' ' .. cw)
--    end
--end
--keyset("n", "K", '<CMD>lua _G.show_docs()<CR>', {silent = true})


---- Highlight the symbol and its references on a CursorHold event (cursor is idle)
--vim.api.nvim_create_augroup("CocGroup", { clear = true})

---- List of file types to exclude from coc highlighting
--local coc_highlight_excluded_filetypes = { "text", "markdown" }

---- Function to check if a file type is excluded
--local function is_coc_highlight_excluded_filetype(filetype)
--    for _, ft in ipairs(coc_highlight_excluded_filetypes) do
--        if ft == filetype then
--            return true
--        end
--    end
--    return false
--end

---- Define the autocmd for files not in the excluded list
--vim.api.nvim_create_autocmd("CursorHold", {
--    group = "CocGroup",
--    pattern = "*",
--    callback = function()
--        if not is_coc_highlight_excluded_filetype(vim.bo.filetype) then
--            vim.cmd("silent call CocActionAsync('highlight')")
--        end
--    end,
--    desc = "Highlight symbol under cursor on CursorHold for allowed file types",
--})

---- Symbol renaming
--keyset("n", "<leader>rn", "<Plug>(coc-rename)", {silent = true})


---- Formatting selected code
--keyset("x", "<leader>f", "<Plug>(coc-format-selected)", {silent = true})
--keyset("n", "<leader>f", "<Plug>(coc-format-selected)", {silent = true})


---- Setup formatexpr specified filetype(s)
--vim.api.nvim_create_autocmd("FileType", {
--    group = "CocGroup",
--    pattern = "typescript,json",
--    command = "setl formatexpr=CocAction('formatSelected')",
--    desc = "Setup formatexpr specified filetype(s)."
--})

---- Update signature help on jump placeholder
--vim.api.nvim_create_autocmd("User", {
--    group = "CocGroup",
--    pattern = "CocJumpPlaceholder",
--    command = "call CocActionAsync('showSignatureHelp')",
--    desc = "Update signature help on jump placeholder"
--})

---- Apply codeAction to the selected region
---- Example: `<leader>aap` for current paragraph
--local opts = {silent = true, nowait = true}
--keyset("x", "<leader>a", "<Plug>(coc-codeaction-selected)", opts)
--keyset("n", "<leader>a", "<Plug>(coc-codeaction-selected)", opts)

---- Remap keys for apply code actions at the cursor position.
--keyset("n", "<leader>ac", "<Plug>(coc-codeaction-cursor)", opts)
---- Remap keys for apply source code actions for current file.
--keyset("n", "<leader>as", "<Plug>(coc-codeaction-source)", opts)
---- Apply the most preferred quickfix action on the current line.
--keyset("n", "<leader>qf", "<Plug>(coc-fix-current)", opts)

---- Remap keys for apply refactor code actions.
--keyset("n", "<leader>re", "<Plug>(coc-codeaction-refactor)", { silent = true })
--keyset("x", "<leader>r", "<Plug>(coc-codeaction-refactor-selected)", { silent = true })
--keyset("n", "<leader>r", "<Plug>(coc-codeaction-refactor-selected)", { silent = true })

---- Run the Code Lens actions on the current line
--keyset("n", "<leader>cl", "<Plug>(coc-codelens-action)", opts)


---- Map function and class text objects
---- NOTE: Requires 'textDocument.documentSymbol' support from the language server
--keyset("x", "if", "<Plug>(coc-funcobj-i)", opts)
--keyset("o", "if", "<Plug>(coc-funcobj-i)", opts)
--keyset("x", "af", "<Plug>(coc-funcobj-a)", opts)
--keyset("o", "af", "<Plug>(coc-funcobj-a)", opts)
--keyset("x", "ic", "<Plug>(coc-classobj-i)", opts)
--keyset("o", "ic", "<Plug>(coc-classobj-i)", opts)
--keyset("x", "ac", "<Plug>(coc-classobj-a)", opts)
--keyset("o", "ac", "<Plug>(coc-classobj-a)", opts)


---- Remap <C-f> and <C-b> to scroll float windows/popups
-----@diagnostic disable-next-line: redefined-local
--local opts = {silent = true, nowait = true, expr = true}
--keyset("n", "<C-f>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', opts)
--keyset("n", "<C-b>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', opts)
--keyset("i", "<C-f>",
--       'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(1)<cr>" : "<Right>"', opts)
--keyset("i", "<C-b>",
--       'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(0)<cr>" : "<Left>"', opts)
--keyset("v", "<C-f>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', opts)
--keyset("v", "<C-b>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', opts)

--keyset("n", "gn", "<Plug>(coc-git-nextchunk)", {})
--keyset("n", "gp", "<Plug>(coc-git-prevchunk)", {})

---- end coc.nvim --

--vim.g.coc_default_semantic_highlight_groups = 1


-- begin neovim-lsp --

-- vim.g.coq_settings = {
--   auto_start = 'shut-up',
--   clients = {
--     lsp = { enabled = true },
--     snippets = { enabled = false },
--     buffers = { enabled = false },
--     paths = { enabled = false },
--     tmux = { enabled = false },
--   },
--   keymap = {
--     manual_complete = "<c-j>",
--   }
-- }

local lspconfig = require('lspconfig')

local function get_root_dir(fname)
  return lspconfig.util.root_pattern('.git')(fname) or vim.fn.getcwd()
end

lspconfig.ruff.setup{root_dir = get_root_dir}
lspconfig.basedpyright.setup{root_dir = get_root_dir}

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

-- end neovim-lsp --

local vimrc = vim.fn.stdpath("config") .. "/nvim_init.vim"
vim.cmd.source(vimrc)

vim.cmd.colorscheme('xtsimple')
