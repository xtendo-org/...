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

set spell
