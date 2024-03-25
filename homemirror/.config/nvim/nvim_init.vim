augroup netrw_mapping
  autocmd!
  autocmd filetype netrw call NetrwMapping()
augroup END

function! NetrwMapping()
  nnoremap <silent> <buffer> <c-l> :TmuxNavigateRight<CR>
endfunction

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

command! RuffFormat
    \ execute ':w'
    \ | execute ':silent !ruff format' shellescape(expand('%'))
    \ | execute ':e!'

command! CargoFmt
    \ execute ':w'
    \ | execute ':silent !cargo +nightly fmt --' shellescape(expand('%'))
    \ | execute ':e!'

augroup FileTypeMappings
  autocmd!

  autocmd FileType haskell
    \ nnoremap <buffer> <C-s> :Fourmolu<CR>
    \ | inoremap <buffer> <C-s> <ESC>:Fourmolu<CR>

  autocmd FileType python
    \ nnoremap <buffer> <C-s> :RuffFormat<CR>
    \ | inoremap <buffer> <C-s> <ESC>:RuffFormat<CR>

  autocmd FileType rust
    \ nnoremap <buffer> <C-s> :CargoFmt<CR>
    \ | inoremap <buffer> <C-s> <ESC>:CargoFmt<CR>

  autocmd BufEnter * if index(['haskell', 'python', 'rust'], &filetype) == -1 | nnoremap <buffer> <C-s> :w<CR> | inoremap <buffer> <C-s> <ESC>:w<CR> | endif

augroup END

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

command! GitFilePath let @+=system('git rev-parse --show-prefix')[:-2] . expand('%') | echo @+
command! CoreURL let @+='https://github.prex.sh/Prex/prex-core/tree/' . system('git rev-parse HEAD')[:-2] . '/' . system('git rev-parse --show-prefix')[:-2] . expand('%') | echo @+

set mouse=

let g:enable_spelunker_vim = 1
let g:ctrlp_custom_ignore = 'target\|\.stack-work\|\.git\|_pb2\.py\|\.pyi'
