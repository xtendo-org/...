call plug#begin()

Plug 'christoomey/vim-tmux-navigator'
Plug 'dart-lang/dart-vim-plugin'
Plug 'jeffkreeftmeijer/vim-dim'
Plug 'jremmen/vim-ripgrep'
Plug 'junegunn/fzf.vim'
Plug 'justinmk/vim-dirvish'
Plug 'kristijanhusak/vim-dirvish-git'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'nvim-lualine/lualine.nvim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
Plug 'udalov/kotlin-vim'

call plug#end()

set clipboard+=unnamed

" alt key delay
set ttimeoutlen=0

" Restore the last editing position
au BufReadPost *
\ if line("'\"") > 0 && line("'\"") <= line("$")  && &filetype != "gitcommit"
\ | exe "norm g`\""
\ | endif

set hlsearch
set incsearch
set nowrapscan
set ruler
set showcmd
set number
set laststatus=2
set wildmenu
set swapfile
set dir=~/tmp

" https://github.com/christoomey/vim-tmux-navigator/issues/72
set shell=/bin/sh

nnoremap <C-s> :w<CR>
inoremap <C-s> <ESC>:w<CR>

set nobackup
set nowritebackup
set updatetime=400
set signcolumn=yes

colorscheme dim

hi PMenu ctermbg=black ctermfg=white
hi PMenuSel ctermbg=yellow ctermfg=black
hi Comment cterm=italic ctermfg=red
hi SignColumn ctermbg=lightgray
hi CocInlayHint ctermbg=lightgray ctermfg=gray
hi Search ctermbg=lightgray ctermfg=black

" hi CocMenu ctermbg=cyan guibg=cyan

" fzf
nnoremap <C-p> :FZF<CR>
let g:fzf_layout = { 'down': '~25%' }

let mapleader=" "

" sort the current paragraph
nnoremap <leader>s vip:sort<CR>

set tabstop=2
set shiftwidth=2
set softtabstop=2

" CoC conf begins

" Enter to choose auto-completion
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Formatting selected code
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" coc-git conf

" navigate chunks of current buffer
nmap [g <Plug>(coc-git-prevchunk)
nmap ]g <Plug>(coc-git-nextchunk)
" navigate conflicts of current buffer
nmap [c <Plug>(coc-git-prevconflict)
nmap ]c <Plug>(coc-git-nextconflict)
" show chunk diff at current position
nmap gs <Plug>(coc-git-chunkinfo)

" nnoremap <leader>p "+p
" nnoremap <leader>P "+P

" command! PasteClipboard r!xclip -selection clipboard -t UTF8_STRING -o | sed -e 's/\n//'

command! S execute ':mksession! Session.vim' | execute ':qa'

command! PasteClipboard normal! "+p
nnoremap <leader>p :PasteClipboard<CR>
