set nocompatible

filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" Let Vundle manages Vundle
Bundle 'gmarik/vundle'

" My Bundles
Bundle 'matchit.zip'
Bundle 'kien/ctrlp.vim'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-markdown'
Bundle 'tpope/vim-liquid'
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/nerdcommenter'
Bundle 'scrooloose/syntastic'
Bundle 'ervandew/supertab'
Bundle 'bling/vim-airline'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'Raimondi/delimitMate'
Bundle 'rking/ag.vim'
Bundle 'godlygeek/tabular'
Bundle 'pangloss/vim-javascript'
Bundle 'xsbeats/vim-blade'
Bundle 'jnwhiteh/vim-golang'
Bundle 'othree/html5.vim'

Bundle 'noahfrederick/Hemisu'
Bundle 'chriskempson/vim-tomorrow-theme'
Bundle 'nanotech/jellybeans.vim'

filetype plugin indent on
syntax on

" Color Scheme
set t_Co=256
set background=dark
let g:jellybeans_background_color_256="000000"
let g:jellybeans_use_lowcolor_black=0
colorscheme jellybeans

" Editor configuration
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set smarttab

set number
set cpo+=$
set encoding=utf-8
set cursorline
set scrolloff=8
set showcmd
set noshowmode
set wildmenu
set wildmode=list:longest,full
set completeopt=menu,longest,preview
set laststatus=2

set mouse=a

set history=100

set autoindent
set nowrap

set ignorecase
set smartcase
set gdefault
set incsearch
set showmatch
set hlsearch

" No backup
set nobackup
set nowritebackup
set noswapfile

" Key configuration
let mapleader=','

nnoremap <silent> <leader><space> :nohls<cr>

map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>
map <F1> <ESC>
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
map <F3> :NERDTreeToggle<cr>

nnoremap ; :
vnoremap ; :

inoremap jj <ESC>

nnoremap <S-TAB> <C-w>W
nnoremap <TAB> <C-w>w

nnoremap p ]p
nnoremap P ]P

nnoremap n nzz
nnoremap N Nzz

" No more sudo
cmap w!! w !sudo tee %

" File Support
au BufRead,BufNewFile *.twig set filetype=jinja.html

au FileType ruby set tabstop=2 shiftwidth=2 softtabstop=2

" Airline
let g:airline_left_sep=''
let g:airline_right_sep=''
let g:airline_theme='luna'

" CtrlP
let g:ctrlp_match_window="top,order:ttb"

" Go auto FMT on save
au FileType go au BufWritePre <buffer> silent Fmt
