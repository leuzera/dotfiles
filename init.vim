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
" Plug 'edkolev/tmuxline.vim'

" Intellisense engine for vim8 & neovim,
" full language server protocol support as VSCode
Plug 'neoclide/coc.nvim', {'tag': '*', 'do': './install.sh'}

" Dark powered asynchronous unite all interfaces for Neovim/Vim8
Plug 'Shougo/denite.nvim'

" A Vim plugin for visually displaying indent levels in code
" Plug 'yggdroot/indentline'

" A tree explorer plugin for vim.
Plug 'scrooloose/nerdtree'

" colorscheme
Plug 'altercation/vim-colors-solarized'
Plug 'chriskempson/base16-vim'
Plug 'dracula/vim'

" Vue syntax highlight
Plug 'posva/vim-vue'

Plug 'majutsushi/tagbar'

" ============================================================================
"                                   RUST
" ============================================================================
" This is a Vim plugin that provides Rust file detection, syntax highlighting,
" formatting, Syntastic integration, and more.
Plug 'rust-lang/rust.vim'
Plug 'racer-rust/vim-racer'
Plug 'roxma/nvim-cm-racer'
" ============================================================================


" Initialize plugin system
call plug#end()

" ============================================================================
"                                   General
" ============================================================================
let mapleader=","       " Change the <leader> key
set linebreak	        " Break lines at word (requires Wrap lines)
set showbreak=+++ 	    " Wrap-broken line prefix

set wrap                " Break lines
set textwidth=79        " Text width
set formatoptions=qrn1
set colorcolumn=79,99,119 " Colored collum at 79,99,119 characters

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

set nobackup            " No backup file
set nowritebackup

syntax enable           " Turn on color syntax highlighting
let base16colorspace=256  " Access colors present in 256 colorspace
set termguicolors
colorscheme base16-dracula

  " Show invisible characters
" set showbreak=↪\
" set listchars=tab:→\ ,eol:↲,nbsp:␣,trail:•,extends:⟩,precedes:⟨
" set list

" Advanced
set ruler	            " Show row and column ruler information

set undolevels=1000	    " Number of undo levels
" let $NVIM_TUI_ENABLE_TRUE_COLOR=1 "TrueColor

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
set wildmenu                " show a navigable menu for tab completion
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

" ============================================================================
"                                   Airline
" ============================================================================
" Dont show empty sections
let g:airline_skip_empty_sections = 1
" Tabline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
" Disable TagBar extension
let g:airline#extensions#tagbar#enabled = 0
" Dont use powerline separators on tmuxline
" let g:tmuxline_powerline_separators = 0
" Change airlone theme
let g:airline_theme='dracula'

" Use coc-git to show git infos
function! GitProjectStatus()
  return get(g:, 'coc_git_status', '')
endfunction
call airline#parts#define_function('branch', 'GitProjectStatus')

function! GitBufferStatus()
    return get(b:, 'coc_git_status', '')
endfunction
call airline#parts#define_function('hunks', 'GitBufferStatus')

" ============================================================================
"                                   NERDTree
" ============================================================================
map <C-n> :NERDTreeToggle<CR>
let NERDTreeShowHidden=1
" Autoclose nvim if only NERDTree is open
autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" ============================================================================
"                                  Tagbar
" ============================================================================
nmap <silent> <F8> :TagbarToggle<CR>

" ============================================================================
"                                 Denite 
" ============================================================================
nnoremap <silent> ; :Denite buffer<CR>
nnoremap <C-p> :Denite file/rec<CR> 
nnoremap <C-f> :<C-u>Denite grep:. -no-empty -mode=normal<CR> 

" ============================================================================
"                                coc.vim 
" ============================================================================
let g:coc_global_extensions = [
    \'coc-python',
    \'coc-rls',
    \'coc-json',
    \'coc-eslint',
    \'coc-tslint',
    \'coc-prettier',
    \'coc-tslint-plugin',
    \'coc-git'
    \] 

" Better display for messages
set cmdheight=2
" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300
" don't give |ins-completion-menu| messages.
set shortmess+=c
" always show signcolumns
set signcolumn=yes

" Use `lp` and `ln` for navigate diagnostics
nmap <silent> <leader>lp <Plug>(coc-diagnostic-prev)
nmap <silent> <leader>ln <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> <leader>ld <Plug>(coc-definition)
nmap <silent> <leader>lt <Plug>(coc-type-definition)
nmap <silent> <leader>li <Plug>(coc-implementation)
nmap <silent> <leader>lf <Plug>(coc-references)

" Remap for rename current word
nmap <leader>lr <Plug>(coc-rename)

" Use K for show documentation in preview window
nnoremap <silent> K :call <SID>show_docs()<CR>

function! s:show_docs()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')
