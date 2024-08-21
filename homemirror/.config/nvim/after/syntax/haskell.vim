syntax keyword haskellFocus mconcat map filter foldr
highlight! haskellFocus ctermfg=3

" augroup HaskellLspTokenUpdate
"   autocmd!
"   autocmd LspTokenUpdate *
"     \ echom "HaskellLspTokenUpdate Firing!11"
"     \ | syntax keyword haskellFocus
"     \ mconcat
"     \ map
"     \ filter
"     \ foldr
"     \ | highlight! haskellFocus ctermfg=3
" augroup END

" lua << EOF
" function HighlightSpecificMethods()
"   local bufnr = vim.api.nvim_get_current_buf()
"   local specific_methods = { "mconcat", "map", "filter", "foldr" }
"   for _, method in ipairs(specific_methods) do
"     vim.fn.matchadd('HaskellSpecificMethod', '\\<' .. method .. '\\>', 100, -1, {buffer = bufnr})
"   end
" end
" EOF

" highlight! HaskellSpecificMethod ctermfg=3

" augroup HaskellSpecificMethodHighlight
"   autocmd!
"   autocmd LspTokenUpdate * lua HighlightSpecificMethods()
" augroup END
