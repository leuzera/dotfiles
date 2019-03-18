" Install Vim Plug if not installed
if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall
 endif

" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
"
call plug#begin('~/.local/share/nvim/site/plugged')
  " Make sure you use single quotes

  " lean & mean status/tabline for vim that's light as air<Paste>
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

  " A Vim plugin for visually displaying indent levels in code
Plug 'yggdroot/indentline'

  " Asynchronous Lint Engine
Plug 'w0rp/ale'

" Language Server Protocol (LSP) support for vim and neovim. 
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }

" A command-line fuzzy finder 
Plug 'junegunn/fzf'

  " ctrlp.vim
Plug 'ctrlpvim/ctrlp.vim'

  " A tree explorer plugin for vim.
Plug 'scrooloose/nerdtree'

  " colorscheme
Plug 'altercation/vim-colors-solarized'
Plug 'dracula/vim'

  " Vue syntax highlight
Plug 'posva/vim-vue'

  " Dark powered asynchronous completion framework for neovim/Vim8
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif

  " ============================================================================
  "                                   RUST
  " ============================================================================
  " This is a Vim plugin that provides Rust file detection, syntax highlighting, formatting, Syntastic integration, and more.
Plug 'rust-lang/rust.vim'
Plug 'racer-rust/vim-racer'
Plug 'roxma/nvim-cm-racer'
" ==============================================================================

  " Initialize plugin system
call plug#end()

" ==============================================================================
"                                   General
" ==============================================================================
let mapleader=","       " Change the <leader> key
set linebreak	        " Break lines at word (requires Wrap lines)
set showbreak=+++ 	    " Wrap-broken line prefix

set wrap                " Break lines
set textwidth=79        " Text width
set formatoptions=qrn1  
set colorcolumn=85      " Colored collum at 85 characters

set showmatch	        " Highlight matching brace
set visualbell	        " Use visual bell (no beeping)
set showcmd             " Display an incomplete command in the corner of the Vim

set hlsearch	        " Highlight all search results
set smartcase	        " Enable smart-case search
set ignorecase	        " Always case-insensitive
set incsearch	        " Searches for strings incrementally

set autoindent	        " Auto-indent new lines
set expandtab	        " Use spaces instead of tabs
set shiftwidth=4	    " Number of auto-indent spaces
set smartindent	        " Enable smart-indent
set smarttab	        " Enable smart-tabs
set softtabstop=4	    " Number of spaces per Tab

set backspace=indent,eol,start " make that backspace key work the way it should
set whichwrap+=<,>,h,l

syntax enable           " Turn on color syntax highlighting
colorscheme dracula

  " Show invisible characters
" set showbreak=↪\
" set listchars=tab:→\ ,eol:↲,nbsp:␣,trail:•,extends:⟩,precedes:⟨
" set list

  " Advanced
set ruler	            " Show row and column ruler information

set undolevels=1000	    " Number of undo levels
let $NVIM_TUI_ENABLE_TRUE_COLOR=1 "TrueColor

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
set wildmenu                           " show a navigable menu for tab completion
set wildmode=longest,list,full
set wildignore=*.o,*~,*.pyc,*.class

" Navigation
" Disable arrow keys
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
" j and k work the way you expect
nnoremap j gj
nnoremap k gk

" ==============================================================================
"                                   Airline
" ==============================================================================
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline_theme='dracula'

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
let g:ale_completion_enabled = 0
let g:ale_fix_on_save = 1

" =============================================================================
" ctrlp.vim
" =============================================================================
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

set wildignore+=*/tmp/*,*.so,*.swp,*.zip

" =============================================================================
" Deoplete
" =============================================================================
let g:deoplete#enable_at_startup = 1

" =============================================================================
" LanguageClient
" =============================================================================
" Required for operations modifying multiple buffers like rename.
set hidden

let g:LanguageClient_autoStart = 1
let g:LanguageClient_serverCommands = {
    \ 'rust': ['rustup', 'run', 'rls'],
    \ 'javascript': [],
    \ 'css': ['css-languageserver', '--stdio'],
    \ 'vue': ['vls'],
    \ }

nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>

" =============================================================================
" NERDTree
" =============================================================================
map <C-n> :NERDTreeToggle<CR>
let NERDTreeShowHidden=1
" Autoclose nvim if only NERDTree is open
autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
