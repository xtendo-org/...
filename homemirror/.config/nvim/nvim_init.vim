filetype plugin indent on
syntax on

augroup netrw_mapping
  autocmd!
  autocmd filetype netrw call NetrwMapping()
augroup END

function! NetrwMapping()
  nnoremap <silent> <buffer> <c-l> :TmuxNavigateRight<CR>
  nnoremap <silent> <buffer> <c-p> :CtrlPMRU<CR>
  nnoremap <silent> <buffer> ' :FZF<CR>
endfunction

" let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_max_depth = 40
let g:ctrlp_max_files = 100000
let g:ctrlp_types = ['fil', 'mru', 'buf']

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

" augroup SuggestDisable
"   autocmd FileType markdown let b:coc_suggest_disable = 1
"   autocmd FileType text let b:coc_suggest_disable = 1
"   autocmd BufRead,BufNewFile * if &filetype == '' | let b:coc_suggest_disable = 1 | endif
"   autocmd VimEnter * if &filetype == '' | let b:coc_suggest_disable = 1 | endif
" augroup END

let g:dirvish_git_indicators = {
\ 'Modified'  : '✹',
\ 'Staged'    : '✚',
\ 'Untracked' : '✭',
\ 'Renamed'   : '➜',
\ 'Unmerged'  : '═',
\ 'Ignored'   : '☒',
\ 'Unknown'   : '?'
\ }

" let g:coc_global_extensions =
"       \[ '@yaegassy/coc-ruff'
"       \, 'coc-git'
"       \, 'coc-highlight'
"       \, 'coc-json'
"       \, 'coc-pyright'
"       \, 'coc-rust-analyzer'
"       \]

let g:ctrlp_working_path_mode = 'rw'

function! TrimEnd()
  " Find the last non-empty line from the end of the file
  let total_lines = line('$')
  let last_non_empty_line = total_lines
  while last_non_empty_line > 0 && getline(last_non_empty_line) == ''
    let last_non_empty_line -= 1
  endwhile

  " Delete all empty lines after the last non-empty line
  if last_non_empty_line < total_lines
    execute (last_non_empty_line + 1) . ',$d'
  endif
endfunction

command! Fourmolu
    \ write
    \ | execute ':silent !fourmolu --mode inplace' shellescape(expand('%'))
    \ | edit!
    \ | call TrimEnd()
    \ | write

command! RuffFormat
    \ write
    \ | execute ':silent !ruff format' shellescape(expand('%'))
    \ | edit!

command! CargoFmt
    \ write
    \ | execute ':silent !rustfmt +nightly --edition 2021 --' shellescape(expand('%'))
    \ | edit!

" augroup FileTypeMappings
"   autocmd!

"   autocmd FileType haskell
"     \ nnoremap <buffer> <C-s> :CocCommand editor.action.formatDocument<CR>:w<CR>
"     \ | inoremap <buffer> <C-s> <ESC>:CocCommand editor.action.formatDocument<CR>:w<CR>
"     \ | nnoremap <leader>gf :CocCommand editor.action.formatDocument<CR>

"   autocmd FileType python
"     \ nnoremap <buffer> <C-s> :RuffFormat<CR>
"     \ | inoremap <buffer> <C-s> <ESC>:RuffFormat<CR>

"   autocmd FileType rust
"     \ nnoremap <buffer> <C-s> :CargoFmt<CR>
"     \ | inoremap <buffer> <C-s> <ESC>:CargoFmt<CR>

"   autocmd BufEnter * if index(['haskell', 'python', 'rust'], &filetype) == -1 | nnoremap <buffer> <C-s> :w<CR> | inoremap <buffer> <C-s> <ESC>:w<CR> | endif

" augroup END

nnoremap <C-s> :w<CR>
inoremap <C-s> <ESC>:w<CR>

" nnoremap <leader>gf :CocCommand editor.action.formatDocument<CR>
" nnoremap gf :CocCommand editor.action.formatDocument<CR>

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

command! -range DedentBlock <line1>,<line2>call DedentToMaxCommonDepth()

vnoremap <leader>d :DedentBlock<CR>

nnoremap <leader>` :set spell!<CR>
nnoremap <leader><space> :nohlsearch<CR>

" visually select the last inserted text
nnoremap gV `[v`]

command! GitFilePath let @+=system('git rev-parse --show-prefix')[:-2] . expand('%') | echo @+
command! CoreURL let @+='https://github.prex.sh/Prex/prex-core/tree/' . system('git rev-parse HEAD')[:-2] . '/' . system('git rev-parse --show-prefix')[:-2] . expand('%') | echo @+

set mouse=

let g:enable_spelunker_vim = 1
let g:ctrlp_custom_ignore = 'target\|\.stack-work\|\.git\|_pb2\.py\|\.pyi\|\.pyc'

function! s:FinishTaskFunction(line1, line2)
  let l:original_search = @/
  execute a:line1 . ',' . a:line2 . 's/\(\s*-\s*\)\(.*\)/\1<del>\2<\/del>/'
  let @/ = l:original_search
endfunction
command! -range FinishTask call s:FinishTaskFunction(<line1>, <line2>)
nnoremap <leader>f :FinishTask<CR>
vnoremap <leader>f :'<,'>FinishTask<CR>

" Copy to clipboard
vnoremap <C-c> "+ygv

nnoremap <silent> <c-l> :TmuxNavigateRight<CR>
nnoremap <silent> <c-p> :CtrlPMRU<CR>
nnoremap <silent> ' :FZF<CR>

" Do not wrap around when searching
set nowrapscan

set cursorline
set cursorcolumn

" Restore the last editing position
au BufReadPost *
\ if line("'\"") > 0 && line("'\"") <= line("$")  && &filetype != "gitcommit"
\ | exe "norm g`\""
\ | endif

" Highlight EOL whitespace, http://vim.wikia.com/wiki/Highlight_unwanted_spaces
highlight ExtraWhitespace ctermbg=darkred guibg=#382424
augroup ExtraWhiteSpaceOn
  autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
  autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
augroup END

" The above flashes annoyingly while typing, be calmer in insert mode
augroup ExtraWhiteSpaceOff
  autocmd InsertLeave * match ExtraWhitespace /\s\+$/
  autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
augroup END

function! s:FixWhitespace(line1,line2)
    let l:save_cursor = getpos(".")
    silent! execute ':' . a:line1 . ',' . a:line2 . 's/\s\+$//'
    call setpos('.', l:save_cursor)
endfunction

" Run :FixWhitespace to remove end of line white space
command! -range=% FixWhitespace call <SID>FixWhitespace(<line1>,<line2>)

" 'Fix' the behavior of including a space (?!) in the `a` motion for quotes
function! SelectInsideQuotes(quote)
    let l:quote = a:quote
    " Check if cursor is at a quote
    if getline('.')[col('.') - 1] == l:quote || getline('.')[col('.')] == l:quote
        " Determine if at the start or end of the quote
        let l:start_pos = search(l:quote, 'bcnW')
        let l:end_pos = search(l:quote, 'cnW')
        if l:end_pos > l:start_pos
            execute "normal! " . (l:start_pos - 1) . '|lv' . (l:end_pos - 2) . '|'
        endif
    else
        " Normal case: search backward then forward
        execute "normal! F" . l:quote . "vf" . l:quote
    endif
endfunction

onoremap <silent> a' :<C-U>call SelectInsideQuotes("'")<CR>
onoremap <silent> a" :<C-U>call SelectInsideQuotes('"')<CR>
onoremap <silent> a` :<C-U>call SelectInsideQuotes('`')<CR>
xnoremap <silent> a' :<C-U>call SelectInsideQuotes("'")<CR>
xnoremap <silent> a" :<C-U>call SelectInsideQuotes('"')<CR>
xnoremap <silent> a` :<C-U>call SelectInsideQuotes('`')<CR>

" Stop auto wrapping
augroup FormatOptions
  autocmd!
  autocmd BufEnter,BufWinEnter,BufRead,BufNewFile * set formatoptions-=tc
augroup END

" vim-airline
let g:airline_section_b=""
let g:airline_section_x="%{airline#util#wrap(airline#parts#filetype(),0)}"
let g:airline_section_y=""
let g:airline_section_z="%l/%L,%v"

" Semshi colors
function MySemshiOverrides()
  hi semshiLocal           ctermfg=2
  hi semshiGlobal          ctermfg=3
  hi semshiImported        ctermfg=2
  hi semshiParameter       ctermfg=5
  hi semshiParameterUnused ctermfg=14
  hi semshiFree            ctermfg=9
  hi semshiBuiltin         ctermfg=4 cterm=BOLD
  hi semshiAttribute       ctermfg=5
  hi semshiSelf            ctermfg=3 cterm=BOLD
  hi semshiUnresolved      ctermfg=1 cterm=none
  hi semshiSelected        ctermbg=14 ctermfg=0

  hi semshiErrorSign       ctermfg=231 guifg=#ffffff ctermbg=160 guibg=#d70000
  hi semshiErrorChar       ctermfg=231 guifg=#ffffff ctermbg=160 guibg=#d70000
  sign define semshiError text=🚨 texthl=semshiErrorSign
endfunction
autocmd FileType python call MySemshiOverrides()

nnoremap <leader>tm a™<ESC>
nnoremap <leader>em a—<ESC>
nnoremap <leader>en a–<ESC>
" insert ISO 8601 timestamp
nnoremap <leader>d i<C-r>=strftime("%FT%T%z")<CR><Esc>
nnoremap <leader>t i<C-r>=strftime("%s")<CR><Esc>

" " FZF colors
" let g:fzf_colors =
" \ { 'fg':      ['fg', 'Normal'],
"   \ 'bg':      ['bg', 'Normal'],
"   \ 'hl':      ['fg', 'Comment'],
"   \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
"   \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
"   \ 'hl+':     ['fg', 'Statement'],
"   \ 'info':    ['fg', 'PreProc'],
"   \ 'border':  ['fg', 'Ignore'],
"   \ 'prompt':  ['fg', 'Conditional'],
"   \ 'pointer': ['fg', 'Exception'],
"   \ 'marker':  ['fg', 'Keyword'],
"   \ 'spinner': ['fg', 'Label'],
"   \ 'header':  ['fg', 'Comment'] }
"
" function! s:update_fzf_colors()
"   let rules =
"   \ { 'fg':      [['Normal',       'fg']],
"     \ 'bg':      [['Normal',       'bg']],
"     \ 'hl':      [['Comment',      'fg']],
"     \ 'fg+':     [['CursorColumn', 'fg'], ['Normal', 'fg']],
"     \ 'bg+':     [['CursorColumn', 'bg']],
"     \ 'hl+':     [['Statement',    'fg']],
"     \ 'info':    [['PreProc',      'fg']],
"     \ 'prompt':  [['Conditional',  'fg']],
"     \ 'pointer': [['Exception',    'fg']],
"     \ 'marker':  [['Keyword',      'fg']],
"     \ 'spinner': [['Label',        'fg']],
"     \ 'header':  [['Comment',      'fg']] }
"   let cols = []
"   for [name, pairs] in items(rules)
"     for pair in pairs
"       let code = synIDattr(synIDtrans(hlID(pair[0])), pair[1])
"       if !empty(name) && code > 0
"         call add(cols, name.':'.code)
"         break
"       endif
"     endfor
"   endfor
"   let s:orig_fzf_default_opts = get(s:, 'orig_fzf_default_opts', $FZF_DEFAULT_OPTS)
"   let $FZF_DEFAULT_OPTS = s:orig_fzf_default_opts .
"         \ empty(cols) ? '' : (' --color='.join(cols, ','))
" endfunction

" augroup _fzf
"   autocmd!
"   autocmd ColorScheme * call <sid>update_fzf_colors()
" augroup END
