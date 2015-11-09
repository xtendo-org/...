set shell=/bin/bash
set nocompatible

scripte utf-8
" set fencs=ucs-bom,cp949,utf-8

call plug#begin('~/.vim/plugged')
Plug 'christoomey/vim-tmux-navigator'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-markdown'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-abolish'
Plug 'bling/vim-airline'
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'kshenoy/vim-signature'
Plug 'raichoo/purescript-vim'
Plug 'raichoo/haskell-vim'
Plug 'wavded/vim-stylus'
Plug 'dag/vim-fish'
call plug#end()

filetype plugin indent on
filetype indent on
filetype on

set title

set ruler
set showcmd
set number
set cursorline
set cursorcolumn
hi CursorLine cterm=NONE ctermbg=lightgray
hi clear SpellBad
hi SpellBad cterm=bold ctermbg=lightmagenta

" Restore the last editing position
au BufReadPost *
\ if line("'\"") > 0 && line("'\"") <= line("$") |
\ exe "norm g`\"" |
\ endif

set hlsearch
set incsearch
set ignorecase
set backspace=indent,eol,start
set autoindent

sy enable
set tabstop=4
set shiftwidth=4
set softtabstop=4
" set smarttab
set expandtab

" :w!! to save with sudo
cmap w!! %!sudo tee > /dev/null %

" Highlight EOL whitespace, http://vim.wikia.com/wiki/Highlight_unwanted_spaces
highlight ExtraWhitespace ctermbg=darkred guibg=#382424
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/

" The above flashes annoyingly while typing, be calmer in insert mode
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/

function! s:FixWhitespace(line1,line2)
    let l:save_cursor = getpos(".")
    silent! execute ':' . a:line1 . ',' . a:line2 . 's/\s\+$//'
    call setpos('.', l:save_cursor)
endfunction

" Run :FixWhitespace to remove end of line white space
command! -range=% FixWhitespace call <SID>FixWhitespace(<line1>,<line2>)

set fillchars+=vert:│
hi VertSplit ctermfg=White ctermbg=Black term=NONE

if filereadable($HOME . "/.vim/local.vim")
    source ~/.vim/local.vim
endif

" airline settings
set laststatus=2
let g:airline_left_sep=''
let g:airline_right_sep=''

hi Search ctermbg=LightYellow ctermfg=Black
hi Constant ctermfg=DarkBlue
hi Comment ctermfg=Red term=italic
hi Visual ctermbg=LightMagenta

hi clear SignColumn
hi GitGutterAdd ctermfg=Green
hi GitGutterChange ctermfg=DarkYellow
hi GitGutterDelete ctermfg=Red
hi GitGutterChangeDelete ctermfg=Red

autocmd BufNewFile,BufReadPost *.md set filetype=markdown

"" ctrl+c to copy
"vmap <C-c> "*y

augroup rainbow
    autocmd!
    autocmd FileType haskell,python,javascript RainbowParentheses
augroup END

set ttimeoutlen=0
set wildmenu

set swapfile
set dir=~/tmp

nnoremap <C-s> :w<CR>
inoremap <C-s> <ESC>:w<CR>

:command! Saha
    \ execute ':w'
    \ | execute ':silent !saha compile'
    \ | execute ':redraw!'

autocmd FileType markdown nnoremap <F5> :Saha<CR>
autocmd FileType markdown inoremap <F5> <ESC>:Saha<CR>
autocmd FileType markdown setlocal spell spelllang=en_us

" visually select the last inserted text
nnoremap gV `[v`]

" turn off search highlight
nnoremap <leader><space> :nohlsearch<CR>

" visual mode backspace is now "delete without copy"
vnoremap <backspace> "_d
