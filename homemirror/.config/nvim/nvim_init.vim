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

let g:dirvish_git_indicators = {
\ 'Modified'  : '✹',
\ 'Staged'    : '✚',
\ 'Untracked' : '✭',
\ 'Renamed'   : '➜',
\ 'Unmerged'  : '═',
\ 'Ignored'   : '☒',
\ 'Unknown'   : '?'
\ }

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

nnoremap <C-s> :w<CR>
inoremap <C-s> <ESC>:w<CR>

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
let g:airline_section_y="%{v:lua.LspStatus()}"
let g:airline_section_z="%l/%L,%v"

nnoremap <leader>tm a™<ESC>
nnoremap <leader>em a—<ESC>
nnoremap <leader>en a–<ESC>
" insert ISO 8601 timestamp
nnoremap <leader>td i<C-r>=strftime("%FT%T%z")<CR><Esc>
nnoremap <leader>ts i<C-r>=strftime("%s")<CR><Esc>
nnoremap <leader>< a《<ESC>
nnoremap <leader>> a》<ESC>

""" Begin LSP

" It seems nvim-lspconfig dynamically enables/disables the column, which
" results in the whole text shaking sideways whenever I enter/exit the INSERT
" mode.
set signcolumn=yes

" Close quickfix upon choice
autocmd FileType qf nnoremap <silent> <buffer> <CR> <CR>:cclose<CR>
autocmd FileType qf nnoremap <silent> <buffer> <C-c> :cclose<CR>

" Disable the auto pop-up of diagnostic
autocmd! CursorHold,CursorHoldI

""" End LSP

nnoremap <leader>v 0v$h

" Disable fancy indentation for HTML
autocmd FileType html setlocal autoindent
autocmd FileType html setlocal nocindent
autocmd FileType html setlocal nosmartindent
autocmd FileType html setlocal indentexpr=
