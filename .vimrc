set shell=/bin/bash
set nocompatible

scripte utf-8
" set fencs=ucs-bom,cp949,utf-8

call plug#begin('~/.vim/plugged')
Plug 'christoomey/vim-tmux-navigator'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-abolish'
Plug 'bling/vim-airline'
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'kshenoy/vim-signature'
Plug 'raichoo/purescript-vim'
Plug 'wavded/vim-stylus'
Plug 'dag/vim-fish'
Plug 'tpope/vim-sleuth', { 'for' : 'javascript,html' }
call plug#end()

filetype plugin indent on
filetype indent on
filetype on

set title

set ruler
set showcmd
set number
hi clear SpellBad
hi SpellBad cterm=bold ctermbg=lightmagenta

" Restore the last editing position
au BufReadPost *
\ if line("'\"") > 0 && line("'\"") <= line("$")  && &filetype != "gitcommit"
\ | exe "norm g`\""
\ | endif

set hlsearch
set incsearch
set nowrapscan
set backspace=indent,eol,start
set autoindent
set ve=onemore " enable moving to the end of the line

sy enable
set tabstop=4
set shiftwidth=4
set softtabstop=4
" set smarttab
set expandtab

" hide certain file types in netrw
let g:netrw_list_hide= '.*\.swp$,.*\.pyc$'

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
hi Comment ctermfg=Red cterm=italic
hi Visual ctermbg=LightMagenta
" color of matching parenthesis
hi MatchParen cterm=bold ctermbg=lightblue ctermfg=black

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

" 79th and 80th column is colored. From
" https://github.com/simnalamburt/.dotfiles/blob/master/.vimrc
set textwidth=78
set colorcolumn=+1,+2
hi ColorColumn ctermbg=lightgray
set formatoptions-=t
set formatoptions+=c
set formatoptions+=r

autocmd FileType markdown,text
    \ nnoremap <F5> :Saha<CR>
    \ | inoremap <F5> <ESC>:Saha<CR>
    \ | setlocal formatoptions=q
    \ | setlocal colorcolumn=
autocmd FileType gitcommit
    \ set smarttab
    \ | setlocal formatoptions+=t
    \ | setlocal textwidth=72
autocmd FileType markdown,gitcommit setlocal spell

" turn off spell checking
nnoremap <leader>` :set spell!<CR>

" visually select the last inserted text
nnoremap gV `[v`]

" turn off search highlight
nnoremap <leader><space> :nohlsearch<CR>

" visual mode backspace is now "delete without copy"
vnoremap <backspace> "_d

" minimal number of screen lines to keep above and below the cursor
set scrolloff=5

" Haskell spell checking for comments only
syn match   hsLineComment      "---*\([^-!#$%&\*\+./<=>\?@\\^|~].*\)\?$" contains=@Spell
syn region  hsBlockComment     start="{-"  end="-}" contains=hsBlockComment,@Spell
autocmd FileType haskell setlocal spell
