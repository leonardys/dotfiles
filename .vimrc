set nocompatible

filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Let Vundle manages Vundle
Plugin 'gmarik/Vundle.vim'

" My Plugins
Plugin 'matchit.zip'
Plugin 'kien/ctrlp.vim'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-liquid'
Plugin 'gabrielelana/vim-markdown'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/syntastic'
Plugin 'ervandew/supertab'
Plugin 'bling/vim-airline'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'Raimondi/delimitMate'
Plugin 'rking/ag.vim'
Plugin 'godlygeek/tabular'
Plugin 'pangloss/vim-javascript'
Plugin 'xsbeats/vim-blade'
Plugin 'jnwhiteh/vim-golang'
Plugin 'othree/html5.vim'
Plugin 'joshtronic/php.vim'

Plugin 'noahfrederick/Hemisu'
Plugin 'chriskempson/vim-tomorrow-theme'
Plugin 'nanotech/jellybeans.vim'

call vundle#end()

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

set spelllang=

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

nnoremap j gj
nnoremap k gk

" No more sudo
cmap w!! w !sudo tee %

" File Support
au BufRead,BufNewFile *.twig set filetype=jinja.html
au BufRead,BufNewFile *.md set wrap
au FileType ruby set tabstop=2 shiftwidth=2 softtabstop=2

" Airline
let g:airline_left_sep=''
let g:airline_right_sep=''
let g:airline_theme='simple'

" CtrlP
let g:ctrlp_match_window="top,order:ttb"

" Go auto FMT on save
au FileType go au BufWritePre <buffer> silent Fmt
