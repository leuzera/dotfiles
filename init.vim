" Install Vim Plug if not installed
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs 
          \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
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
" Plug 'vim-airline/vim-airline-themes'

" Intellisense engine for vim8 & neovim,
" full language server protocol support as VSCode
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Dark powered asynchronous unite all interfaces for Neovim/Vim8
Plug 'Shougo/denite.nvim'

" A solid language pack for Vim.
Plug 'sheerun/vim-polyglot'

" colorscheme
" Plug 'altercation/vim-colors-solarized'
" Plug 'chriskempson/base16-vim'
" Plug 'dracula/vim'
Plug 'joshdick/onedark.vim'

" Vue syntax highlight
Plug 'posva/vim-vue'

" Vim plugin that displays tags in a window, ordered by scope
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

" Use coc-git to show git infos
function! GitBufferStatus()
  return get(b:, 'coc_git_status', '')
endfunction
call airline#parts#define_function('hunks', 'GitBufferStatus')

" Change airline theme
let g:airline_theme='onedark'

" Custom setup that removes filetype/whitespace from default vim airline bar
let g:airline#extensions#default#layout = [['a', 'b', 'c'], ['x', 'z', 'warning', 'error']]

" Update section z to just have line number
let g:airline_section_z = airline#section#create(['linenr'])

" Smartly uniquify buffers names with similar filename, suppressing common parts of paths.
let g:airline#extensions#tabline#formatter = 'unique_tail'

let airline#extensions#coc#stl_format_err = '%E{[%e(#%fe)]}'

let airline#extensions#coc#stl_format_warn = '%W{[%w(#%fw)]}'

" Configure error/warning section to use coc.nvim
let g:airline_section_error = '%{airline#util#wrap(airline#extensions#coc#get_error(),0)}'
let g:airline_section_warning = '%{airline#util#wrap(airline#extensions#coc#get_warning(),0)}'
catch
  echo 'Run :PlugInstall to install Airline'
endtry

" ============================================================================
"                                  Tagbar
" ============================================================================
try
nmap <silent> <F8> :TagbarToggle<CR>
catch
  echo 'Run :PlugInstall to install Tagbar'
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
nnoremap <C-f> :<C-u>Denite grep:. -no-empty <CR> 

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
catch
  echo 'Run :PlugInstall to install Denite'
endtry
" ============================================================================
"                                coc.vim 
" ============================================================================
try
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

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" Fix autofix problem of current line
nmap <leader>qf <Plug>(coc-fix-current)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use tab for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

"Close preview window when completion is done.
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use K for show documentation in preview window
nnoremap <silent> K :call <SID>show_docs()<CR>

function! s:show_docs()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')
catch
  echo 'Run :PlugInstall to install CoC.nvim' 
endtry
