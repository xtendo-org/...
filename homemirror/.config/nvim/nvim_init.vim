augroup netrw_mapping
  autocmd!
  autocmd filetype netrw call NetrwMapping()
augroup END

function! NetrwMapping()
  nnoremap <silent> <buffer> <c-l> :TmuxNavigateRight<CR>
endfunction

nnoremap <C-s> :w<CR>
inoremap <C-s> <ESC>:w<CR>

let g:ctrlp_max_depth = 40
let g:ctrlp_max_files = 100000

function! SetTextWidthFromRuff()
  if filereadable("ruff.toml")
    let content = readfile("ruff.toml")
    let lineLength = matchstr(join(content), 'line-length\s*=\s*\zs\d\+')
    if len(lineLength) > 0
      execute "set textwidth=".lineLength
    endif
  endif
endfunction

call SetTextWidthFromRuff()

autocmd FileType markdown let b:coc_suggest_disable = 1

let g:dirvish_git_indicators = {
\ 'Modified'  : '✹',
\ 'Staged'    : '✚',
\ 'Untracked' : '✭',
\ 'Renamed'   : '➜',
\ 'Unmerged'  : '═',
\ 'Ignored'   : '☒',
\ 'Unknown'   : '?'
\ }

let g:coc_global_extensions =
      \[ '@yaegassy/coc-ruff'
      \, 'coc-git'
      \, 'coc-highlight'
      \, 'coc-json'
      \, 'coc-pyright'
      \, 'coc-rust-analyzer'
      \]

let g:ctrlp_working_path_mode = '0'

command! Fourmolu
    \ execute ':w'
    \ | execute ':silent !fourmolu --mode inplace' shellescape(expand('%'))
    \ | execute ':e!'

autocmd FileType haskell
    \ nnoremap <C-s> :Fourmolu<CR>
    \ | inoremap <C-s> <ESC>:Fourmolu<CR>

command! RuffFormat
    \ execute ':w'
    \ | execute ':silent !ruff format' shellescape(expand('%'))
    \ | execute ':e!'

autocmd FileType python
    \ nnoremap <C-s> :RuffFormat<CR>
    \ | inoremap <C-s> <ESC>:RuffFormat<CR>

command! CargoFmt
    \ execute ':w'
    \ | execute ':silent !cargo +nightly fmt --' shellescape(expand('%'))
    \ | execute ':e!'

autocmd FileType rust
    \ nnoremap <C-s> :CargoFmt<CR>
    \ | inoremap <C-s> <ESC>:CargoFmt<CR>

set spell

function! DedentToMaxCommonDepth() range
  let l:min_indent = -1
  for l:line in getline(a:firstline, a:lastline)
    if l:line =~ '^\s*$' | continue | endif
    let l:current_indent = matchend(l:line, '^\s\+')
    if l:min_indent == -1 || l:current_indent < l:min_indent
      let l:min_indent = l:current_indent
    endif
  endfor
  if l:min_indent > 0
    execute a:firstline . ',' . a:lastline . 's/^\s\{' . l:min_indent . '}//'
  endif
endfunction

command! -range=% DedentBlock <line1>,<line2>call DedentToMaxCommonDepth()

vnoremap <leader>d :DedentBlock<CR>

nnoremap <leader>` :set spell!<CR>
nnoremap <leader><space> :nohlsearch<CR>

" visually select the last inserted text
nnoremap gV `[v`]
