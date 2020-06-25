" ========================================
" core installs
" ========================================
if has('vim_starting')
  set nocompatible               " Be iMproved
endif

let vimplug_exists=expand('~/.config/nvim/autoload/plug.vim')

let g:vim_bootstrap_langs = "javascript,php,python,ruby"
let g:vim_bootstrap_editor = "nvim"				" nvim or vim

if !filereadable(vimplug_exists)
  echo "Installing Vim-Plug..."
  echo ""
  silent !\curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  let g:not_finish_vimplug = "yes"

  autocmd VimEnter * PlugInstall
endif

" ========================================
" Settings
" ========================================

" Tabs and indents
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set autoindent

" Visual settings
set background=dark
set textwidth=80
hi ColorColumn ctermbg=lightgrey guibg=lightgrey
set colorcolumn=80
syntax on
set ruler
set number

" Encoding
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8

" Fix backspace indent
set backspace=indent,eol,start

" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase

" Directories for swp files
set nobackup
set noswapfile

" Windows
set splitbelow
set splitright

" ========================================
" Plugins
" ========================================
call plug#begin('~/.config/nvim/plugged')

Plug 'wellle/targets.vim'
Plug 'https://github.com/junegunn/vim-peekaboo'
Plug 'ap/vim-buftabline'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'machakann/vim-sandwich'
Plug 'terryma/vim-multiple-cursors'
Plug 'vim-scripts/indentpython.vim'
" Plug 'roman/golden-ratio'
Plug 'andymass/vim-matchup'
Plug 'scrooloose/nerdtree'
Plug 'rafi/awesome-vim-colorschemes'
Plug 'dracula/vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

" ========================================
" Colorscheme
" ========================================
" colorscheme dracula
colorscheme gruvbox

" ========================================
" Key mappings
" ========================================

" Leader
let mapleader=","

" Save and source
nnoremap <Leader>w :so %<cr>

" Escape
nnoremap <C-[> <Esc>
inoremap <C-[> <Esc>
vnoremap <C-[> <Esc>
tnoremap <C-[> <C-\><C-n>

" Maintain Visual Mode after shifting > and <
vmap < <gv
vmap > >gv 

" Move visual block
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv 

" Set working directory
nnoremap <leader>. :lcd %:p:h<CR>

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" NERDTree
map <leader>f :NERDTreeFind<cr>
map <leader>n :NERDTreeToggle<cr>

" ========================================
"  NERDTree
" ========================================
let NERDTreeShowHidden=1
let NERDTreeQuitOnOpen=1

" ========================================
" Copy/Paste/Cut
" ========================================
if has('unnamedplus')
  set clipboard=unnamed,unnamedplus
endif

if has('macunix')
  " pbcopy for OSX copy/paste
  vmap <C-x> :!pbcopy<CR>
  vmap <C-c> :w !pbcopy<CR><CR>
endif

" ========================================
" coc.nvim settings
" ========================================
nnoremap <Leader>r :CocCommand python.startREPL<cr><cr>
nnoremap <Leader>e python.execInTerminal<cr><cr>

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Trigger completion.
inoremap <silent><expr> <C-s> coc#refresh()

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif
