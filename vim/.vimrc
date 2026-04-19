" Basic {{{
set nocompatible
filetype on
filetype plugin on
filetype indent on
syntax off
" }}}

" Leader {{{
let mapleader = "\\"
let maplocalleader = "\\"
" }}}

" Theme {{{
set background=dark
colorscheme zenwritten
" }}}

" Options {{{
set nobackup
set nowritebackup
set viminfo=
set noswapfile
set nowrap
set spelllang=en_us
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set smarttab
set number
set relativenumber
set autoindent
set smartindent
set breakindent
set nrformats+=alpha
set nrformats+=octal
set nrformats+=hex
set nrformats+=bin
set nrformats+=blank
set showmode
set showcmd
set showmatch
set hlsearch
set incsearch
set ignorecase
set smartcase
set autoread
set backspace=indent,eol,start
set t_Co=256
set termguicolors
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8
set ttyfast
set ruler
set smoothscroll
set hidden
set wildmenu
set wildmode=list:longest
set scrolloff=10
set sidescrolloff=10
set noerrorbells visualbell t_vb=
set path+=**
set cryptmethod=xchacha20v2
set modeline
set modelines=5
set viewoptions-=options

if !isdirectory($HOME."/.vim")
    call mkdir($HOME."/.vim", "", 0770)
endif

if !isdirectory($HOME."/.vim/undo")
    call mkdir($HOME."/.vim/undo", "", 0700)
endif

set undodir=~/.vim/undo/
set undofile

" }}}

" Keymaps {{{
" Map J and K to escape
inoremap jk <esc>
inoremap Jk <esc>
inoremap JK <esc>
inoremap jK <esc>
vnoremap jk <esc>
vnoremap Jk <esc>
vnoremap JK <esc>
vnoremap jK <esc>
cnoremap jk <esc>
cnoremap Jk <esc>
cnoremap JK <esc>
cnoremap jK <esc>

" Disable arrow keys
nnoremap <Up>    <Nop>
nnoremap <Down>  <Nop>
nnoremap <Left>  <Nop>
nnoremap <Right> <Nop>
inoremap <Up>    <Nop>
inoremap <Down>  <Nop>
inoremap <Left>  <Nop>
inoremap <Right> <Nop>
vnoremap <Up>    <Nop>
vnoremap <Down>  <Nop>
vnoremap <Left>  <Nop>
vnoremap <Right> <Nop>

" Stamp the current date and time
nnoremap <leader>d :r!date <CR>

" Quick indenting and return to last place
map <leader>i gg=G``

" }}}

" Folds {{{
" Create fold (visual mode): zf
" Create fold over N lines: zfNj
" Delete fold: zd
" Delete all folds: zE
" Close fold under cursor: zc
" Open fold under cursor: zo
" Toggle fold under cursor: za
" Close all folds: zM
" Open all folds: zR
" Close folds recursively: zC
" Open folds recursively: zO
" Jump to next fold: zj
" Jump to previous fold: zk
" Jump to start of fold: [z
" Jump to end of fold: ]z
set foldenable
set foldmethod=marker
set foldmarker={{{,}}}
set foldlevelstart=0
set foldlevel=0
set foldminlines=1
set foldcolumn=2
" }}}

" Autocmd {{{
" Persist folds and cursor across sessions
autocmd BufWinLeave *.* mkview
autocmd BufWinEnter *.* silent loadview

" Remove trailing white space
autocmd BufWritePre * %s/\s\+$//e
" }}}
