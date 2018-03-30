set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.config/nvim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" a Git wrapper so awesome, it should be illegal
Plugin 'tpope/vim-fugitive'

" lean & mean status/tabline for vim that's light as air<Paste>
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

" A Vim plugin for visually displaying indent levels in code
Plugin 'yggdroot/indentline'

" Asynchronous Lint Engine
Plugin 'w0rp/ale'

" colorscheme
Plugin 'altercation/vim-colors-solarized' 
Plugin 'dracula/vim'


" ==============================================================================
"                                   RUST
" ==============================================================================
" ⚡️ Fast, Extensible, Async Completion Framework for Neovi
Plugin 'roxma/nvim-completion-manager'

" This is a Vim plugin that provides Rust file detection, syntax highlighting, formatting, Syntastic integration, and more.
Plugin 'rust-lang/rust.vim'
Plugin 'racer-rust/vim-racer'
Plugin 'roxma/nvim-cm-racer'
" ==============================================================================

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required<Paste>

" ==============================================================================
"                                   General
" ==============================================================================
set nu
set history=2000

syntax enable           " Turn on color syntax highlighting
set background=dark
colorscheme solarized
filetype on
filetype plugin on
filetype indent on

" movement
set scrolloff=7                 " keep 3 lines when scrolling

cnoremap <C-j> <t_kd>
cnoremap <C-k> <t_ku>

" Show invisible characters
set showbreak=↪\ 
set listchars=tab:→\ ,eol:↲,nbsp:␣,trail:•,extends:⟩,precedes:⟨
set list

" show
set ruler                       " show the current row and column
set number                      " show line numbers
set nowrap
set showcmd                     " display incomplete commands
set showmode                    " display current modes
set showmatch                   " jump to matches when entering parentheses
set matchtime=2                 " tenths of a second to show the matching parenthesis

" search
set hlsearch                    " highlight searches
set incsearch                   " do incremental searching, search as you type
set smartcase                   " no ignorecase if Uppercase char present

" tab
set expandtab                   " expand tabs to spaces
set smarttab
set shiftround

" indent
set autoindent
set smartindent
set shiftwidth=2
set tabstop=2
set softtabstop=2                " insert mode tab and backspace use 2 spaces


" encoding
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
set termencoding=utf-8
set ffs=unix,dos,mac
set formatoptions+=m

set formatoptions+=B

" select & complete
set selection=inclusive
set selectmode=mouse,key

set completeopt=longest,menu
set wildmenu                           " show a navigable menu for tab completion"
set wildmode=longest,list,full
set wildignore=*.o,*~,*.pyc,*.class

set backspace=indent,eol,start  " make that backspace key work the way it should
set whichwrap+=<,>,h,l

" ==============================================================================
"                                   Airline
" ==============================================================================
let g:airline#extensions#tabline#enabled = 1
" let g:airline#extensions#tabline#left_sep = ' '
" let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#ale#enabled = 1
let g:airline_theme='solarized'
let g:airline_solarized_bg='dark'

" ==============================================================================
"                                   ALE
" ==============================================================================
" Navigate between errors
nmap <silent> <C-k> <Plug>(ale_previous_wrap)   " CTRL+k
nmap <silent> <C-j> <Plug>(ale_next_wrap)       " CTRL+j

let g:ale_linters = {
\   'rust': ['rsl'],
\}

" Run linter on save
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0
let g:ale_completion_enabled = 1
let g:ale_fix_on_save = 1
