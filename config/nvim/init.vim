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

" Dark powered asynchronous completion framework for neovim/Vim8
Plug 'shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

" Dark powered asynchronous unite all interfaces for Neovim/Vim8
Plug 'Shougo/denite.nvim'

" Check syntax in Vim asynchronously and fix files, with Language Server Protocol (LSP) support
Plug 'dense-analysis/ale'

" A solid language pack for Vim.
Plug 'sheerun/vim-polyglot'

" colorscheme
" Plug 'altercation/vim-colors-solarized'
" Plug 'chriskempson/base16-vim'
" Plug 'dracula/vim'
Plug 'joshdick/onedark.vim'

" Vue syntax highlight
Plug 'posva/vim-vue'

" A very fast, multi-syntax context-sensitive color name highlighter
Plug 'ap/vim-css-color'
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
let mapleader="ç"       " Change the <leader> key
set hidden
set linebreak	        " Break lines at word (requires Wrap lines)
set showbreak=+++ 	    " Wrap-broken line prefix

set wrap                " Break lines
set textwidth=79        " Text width
set formatoptions=qrn1
set colorcolumn=79,99,119 " Colored collum at 79,99,119 characters

set showmatch	        " Highlight matching brace
set visualbell	        " Use visual bell (no beeping)
set showcmd             " Display an incomplete command in the corner of Vim

set hlsearch	        " Highlight all search results
set smartcase	        " Enable smart-case search
set ignorecase	        " Always case-insensitive
set incsearch	        " Searches for strings incrementally

set autoindent	        " Auto-indent new lines
set expandtab	        " Use spaces instead of tabs
set shiftwidth=2	    " Number of auto-indent spaces
set smartindent	        " Enable smart-indent
set smarttab	        " Enable smart-tabs
set softtabstop=2	    " Number of spaces per Tab

set backspace=indent,eol,start " make that backspace key work the way it should
set whichwrap+=<,>,h,l

set nobackup            " No backup file
set nowritebackup

if (has("termguicolors"))
    set termguicolors
endif

syntax enable           " Turn on color syntax highlighting
colorscheme onedark

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
set wildignore+=**/bower_components/**,**/node_modules/**,**vendor/bundle**,
      \**target/scala**,**project/target**,*.jpg,*.gif,*.png,*.svg,*.zip

set cmdheight=2     " Better display for messages
set updatetime=300  " Smaller updatetime for CursorHold & CursorHoldI
set shortmess+=c    " don't give |ins-completion-menu| messages.
set signcolumn=yes  " always show signcolumns

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
try
" Disable TagBar extension
let g:airline#extensions#tagbar#enabled = 0
let g:airline#extensions#whitespace#enabled = 0

" Change airline theme
let g:airline_theme='onedark'

" Custom setup that removes filetype/whitespace from default vim airline bar
let g:airline#extensions#default#layout = [['a', 'b', 'c'], ['x', 'z', 'warning', 'error']]

" Update section z to just have line number
let g:airline_section_z = airline#section#create(['linenr'])

" Smartly uniquify buffers names with similar filename, suppressing common parts of paths.
let g:airline#extensions#tabline#formatter = 'unique_tail'

catch
  echo 'Run :PlugInstall to install Airline'
endtry

" ============================================================================
"                                 Denite 
" ============================================================================
try
call denite#custom#option('default', {
            \ 'auto_resize': 1,
            \ 'prompt': 'λ:',
            \ 'winminheight': '10',
            \ 'split': 'floating'})

nnoremap <silent> ; :Denite buffer<CR>
nnoremap <C-p> :Denite file/rec<CR> 
nnoremap <leader>f :<C-u>Denite grep:. -no-empty <CR> 
nnoremap <leader>F :<C-u>DeniteCursorWord grep:. <CR> 

autocmd FileType denite call s:denite_my_settings()
function! s:denite_my_settings() abort
  nnoremap <silent><buffer><expr> <CR>    denite#do_map('do_action')
  nnoremap <silent><buffer><expr> <Tab>   denite#do_map('choose_action')
  nnoremap <silent><buffer><expr> <ESC>   denite#do_map('quit')
  nnoremap <silent><buffer><expr> <Space> denite#do_map('toggle_select').'j'
  nnoremap <silent><buffer><expr> d       denite#do_map('do_action', 'delete')
  nnoremap <silent><buffer><expr> p       denite#do_map('do_action', 'preview')
  nnoremap <silent><buffer><expr> i       denite#do_map('open_filter_buffer')
endfunction

" Open file commands
call denite#custom#map('insert,normal', "<C-v>", '<denite:do_action:vsplit>')
call denite#custom#map('insert,normal', "<C-h>", '<denite:do_action:split>')

" Change file/rec command.
call denite#custom#var('file/rec', 'command',
	\ ['rg', '--files', '--hidden', '--glob', '!.git'])

" Change ignore_globs
call denite#custom#filter('matcher/ignore_globs', 'ignore_globs',
	      \ [ '.git/', '.ropeproject/', '__pycache__/',
	      \   'venv/', 'images/', '*.min.*', 'img/', 'fonts/'])
catch
  echo 'Run :PlugInstall to install Denite'
endtry

" ============================================================================
"                                 Deoplete 
" ============================================================================
try
let g:deoplete#enable_at_startup = 1
catch
  echo 'Run :PlugInstall to install Deoplete'
endtry

" ============================================================================
"                                 ALE 
" ============================================================================
try
let g:airline#extensions#ale#enabled = 1
catch
  echo 'Run :PlugInstall to install ALE'
endtry
