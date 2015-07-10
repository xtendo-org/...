set shell=/bin/bash
scripte utf-8
" vim: set fenc=utf-8 tw=0:

set nocompatible
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Bundle 'christoomey/vim-tmux-navigator'
Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-vinegar'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-markdown'
Plugin 'bling/vim-airline'
Plugin 'oblitum/rainbow'
Plugin 'kshenoy/vim-signature'
Plugin 'raichoo/purescript-vim'
Plugin 'raichoo/haskell-vim'
call vundle#end()
filetype plugin indent on
filetype on

set ru
set sc
set nu

au BufReadPost *
\ if line("'\"") > 0 && line("'\"") <= line("$") |
\ exe "norm g`\"" |
\ endif

set hls
set incsearch

sy enable
set tabstop=4
set shiftwidth=4
set softtabstop=4
" set smarttab
set expandtab

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

" always show file name
set ls=2

set fillchars+=vert:│
hi VertSplit ctermfg=White ctermbg=Black term=NONE

if filereadable($HOME . "/.vim/local.vim")
    so ~/.vim/local.vim
endif

" call pathogen#infect()

let g:airline_left_sep=''
let g:airline_right_sep=''

hi Search ctermbg=LightYellow ctermfg=Black
hi Constant ctermfg=DarkBlue
hi Comment ctermfg=Red term=italic

hi clear SignColumn
hi GitGutterAdd ctermfg=Green
hi GitGutterChange ctermfg=DarkYellow
hi GitGutterDelete ctermfg=Red
hi GitGutterChangeDelete ctermfg=Red

autocmd BufNewFile,BufReadPost *.md set filetype=markdown

"" ctrl+c to copy
"vmap <C-c> "*y

au FileType haskell,python,javascript,c,cpp call rainbow#load()
