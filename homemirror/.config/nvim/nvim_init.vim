filetype plugin indent on
syntax on

augroup netrw_mapping
  autocmd!
  autocmd filetype netrw call NetrwMapping()
augroup END

function! NetrwMapping()
  nnoremap <silent> <buffer> <c-r> :Ex<CR>
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

" Paste from clipboard
nnoremap <leader>p "+p
nnoremap <leader>P "+P

nnoremap <silent> <c-l> :TmuxNavigateRight<CR>
nnoremap <silent> <c-p> :CtrlPMRU<CR>
nnoremap <silent> ' :FZF<CR>

" Do not wrap around when searching
set nowrapscan

set cursorcolumn

set colorcolumn=79,80

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
let g:airline_section_z="%l/%L,%v"

nnoremap <leader>tm a™<ESC>
nnoremap <leader>em a—<ESC>
nnoremap <leader>en a–<ESC>
" insert ISO 8601 timestamp
nnoremap <leader>td a<C-r>=strftime("%FT%T%z")<CR><Esc>
nnoremap <leader>ts a<C-r>=strftime("%s")<CR><Esc>
nnoremap <leader>< a《<ESC>
nnoremap <leader>> a》<ESC>
nnoremap <leader>zh a←<ESC>
nnoremap <leader>zj a↓<ESC>
nnoremap <leader>zk a↑<ESC>
nnoremap <leader>zl a→<ESC>
nnoremap <leader>: aː<ESC>

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

" Dictionary!

" Helper function: get selection from Visual mode
function! s:get_visual_selection() abort
  " Save current register
  let old_reg = getreg('"')

  " Yank the visually selected text into register x
  normal! gv"xy

  " Capture that text
  let selected_text = getreg('x')

  " Restore old register
  call setreg('"', old_reg)
  return selected_text
endfunction

" Function to allow `:En keyword`, `:Ja keyword`, etc.
function! MyDictLookupDirect(lang, word) abort
  " Open a 20-line horizontal split at the bottom
  execute 'botright 20split'

  " Run `mydict <lang> <word>` in a terminal
  execute 'terminal flatdict ' . a:lang . ' ' . shellescape(a:word)
endfunction

function! MyDictLookupSelected(lang) range
  let l:selected_text = s:get_visual_selection()
  if empty(l:selected_text)
    echo "No text selected."
    return
  endif

  call MyDictLookupDirect(a:lang, l:selected_text)
endfunction

function! MyDictLookupWord(lang) abort
  " Get the word under the cursor
  let l:word = expand('<cword>')
  if empty(l:word)
    echo "No word under the cursor."
    return
  endif

  call MyDictLookupDirect(a:lang, l:word)
endfunction

" Visual‐mode mappings:
"   - <leader>k for Korean
"   - <leader>l for English
"   - <leader>j for Japanese

" First, let's reconfigure GitGutter mappings
let g:gitgutter_map_keys = 0
nmap ]c <Plug>(GitGutterNextHunk)
nmap [c <Plug>(GitGutterPrevHunk)

xnoremap <silent> <leader>l :<C-u>call MyDictLookupSelected('en')<CR>
xnoremap <silent> <leader>k :<C-u>call MyDictLookupSelected('ko')<CR>
xnoremap <silent> <leader>j :<C-u>call MyDictLookupSelected('ja')<CR>
xnoremap <silent> <leader>h :<C-u>call MyDictLookupSelected('hanja')<CR>

" Custom commands for direct dictionary lookup
command! -nargs=1 Ko call MyDictLookupDirect('ko', <q-args>)
command! -nargs=1 Eo call MyDictLookupDirect('en', <q-args>)
command! -nargs=1 Ja call MyDictLookupDirect('ja', <q-args>)
command! -nargs=1 Hanja call MyDictLookupDirect('hanja', <q-args>)

nnoremap <silent> <leader>l :call MyDictLookupWord('en')<CR>
nnoremap <silent> <leader>k :call MyDictLookupWord('ko')<CR>
nnoremap <silent> <leader>j :call MyDictLookupWord('ja')<CR>
nnoremap <silent> <leader>h :call MyDictLookupWord('hanja')<CR>

" End of Dictionary!

function! Autosync() abort
  " Get the full path of the file being edited.
  let l:current_file = expand('%:p')
  if empty(l:current_file)
    echoerr "No file name found."
    return
  endif

  " Get the directory of the current file.
  let l:file_dir = fnamemodify(l:current_file, ':h')

  " Determine the Git repository root for the current file.
  let l:repo_root = system('git -C ' . shellescape(l:file_dir) . ' rev-parse --show-toplevel')
  if v:shell_error
    echoerr "Not a Git repository."
    return
  endif
  " Remove any trailing newline
  let l:repo_root = substitute(l:repo_root, '\n', '', 'g')

  " Stage all changes (tracked, untracked, and removals)
  let l:add_cmd = 'git -C ' . shellescape(l:repo_root) . ' add -A :/'
  let l:add_out = system(l:add_cmd)
  if v:shell_error
    echoerr "Error staging changes:" . l:add_out
    return
  endif

  " Commit the staged changes
  let l:commit_cmd = 'git -C ' . shellescape(l:repo_root) . ' commit -m autosync'
  let l:commit_out = system(l:commit_cmd)
  if v:shell_error
    echoerr "Git commit failed:" . l:commit_out
  else
    echo l:commit_out
  endif
endfunction

command! Autosync call Autosync()

function! UrlEncodeSelection() range
  " Get the visually selected text (as lines) and join into a single string.
  let l:orig = join(getline("'<", "'>"), "\n")
  " Call Python to percent-encode the text.
  let l:encoded = system('python3 -c "import sys, urllib.parse; sys.stdout.write(urllib.parse.quote(sys.stdin.read()))"', l:orig)
  " Replace the selected text with the encoded version.
  call setline("'<", split(l:encoded, "\n"))
endfunction

" Map <leader>c in visual mode to URL-encode the selection.
vnoremap <leader>cu :<C-U>call UrlEncodeSelection()<CR>

" For spelunker.vim
" <https://github.com/kamykn/spelunker.vim>
"
" Spellcheck type: (default: 1)
" 1: File is checked for spelling mistakes when opening and saving. This
" may take a bit of time on large files.
" 2: Spellcheck displayed words in buffer. Fast and dynamic. The waiting time
" depends on the setting of CursorHold `set updatetime=1000`.
let g:spelunker_check_type = 1

" https://neovim.io/doc/user/pi_netrw.html#g%3Anetrw_sort_sequence
let g:netrw_sort_options='n'
let g:netrw_sort_by='extension'

" Buffer cleanup: On entering any buffer, set it to delete itself when hidden
augroup AutoBufHiddenDelete
  autocmd!
  autocmd BufEnter * setlocal bufhidden=delete
augroup END

" disable PageUp / PageDown in INSERT mode
inoremap <PageUp>   <Nop>
inoremap <PageDown> <Nop>
