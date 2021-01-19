" =============================================================================
" SETTINGS
" =============================================================================

" No VI
set nocompatible

" Tabs and indents
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set autoindent
set backspace=indent,eol,start

" Visual settings
set background=dark
set textwidth=80
hi ColorColumn ctermbg=lightgrey guibg=lightgrey
set colorcolumn=80
syntax on
colorscheme OceanicNext
set ignorecase
set hidden
set noerrorbells
set scrolloff=8
set signcolumn=yes
set foldenable
set conceallevel=2
set title

" Line numbering
set number
set relativenumber

" Directories for swp files
set nobackup 
set noswapfile 

" Windows 
set splitbelow
set splitright

" displays tabs with :set list & displays when a line runs off-screen
set listchars=tab:<.,trail:.,precedes:<,extends:>
set list

" File Settings
set encoding=utf8
set undodir=~/.vim_runtime/undodir
set undofile

" Searching and patterns
set ignorecase
set smartcase
set smarttab
set incsearch

" =============================================================================
" Filetype settings
" =============================================================================

" Markdown
au FileType *.md expandtab shiftwidth=2 tabstop=2 smartindent

" Python
" -----------------------------------------------------------------------------
"au BufRead *.py compiler nose
au FileType python set omnifunc=pythoncomplete#Complete
au FileType python setlocal expandtab shiftwidth=4 tabstop=4 smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class,with
au BufRead *.py set efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m
au BufWritePre *.py %s/\s\+$//e
au FileType python set foldmethod=indent foldlevel=99

""rope options
"map <leader>j :RopeGotoDefinition<CR>
"map <leader>r :RopeRename<CR>

" " Don't let pyflakes use the quickfix window
" let g:pyflakes_use_quickfix = 0

" " Run pyflake8
" autocmd FileType python map <Leader>8 :call Flake8()<CR>
" " Run when saving py files
" autocmd BufWritePost *.py call Flake8()
" " Ignore Errors
" let g:flake8_ignore="E501,W293"

" Ignore these files when completing
set wildignore+=*.o,*.obj,.git,*.pyc
set wildignore+=eggs/**
set wildignore+=*.egg-info/**

" Add the virtualenv's site-packages to vim path
if has('python')
py << EOF
import os.path
import sys
import vim
if 'VIRTUAL_ENV' in os.environ:
    project_base_dir = os.environ['VIRTUAL_ENV']
    sys.path.insert(0, project_base_dir)
    activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
    execfile(activate_this, dict(__file__=activate_this))
EOF
endif

" Load up virtualenv's vimrc if it exists
if filereadable($VIRTUAL_ENV . '/.vimrc')
    source $VIRTUAL_ENV/.vimrc
endif

" =============================================================================
" PLUG-INS
" =============================================================================
" https://github.com/roman/golden-ratio
" https://github.com/preservim/nerdtree
" https://github.com/wellle/targets.vim
" https://github.com/ap/vim-buftabline
" https://github.com/tpope/vim-commentary
" https://github.com/terryma/vim-multiple-cursors
" https://github.com/junegunn/vim-peekaboo
" https://github.com/machakann/vim-sandwich
" https://github.com/liuchengxu/vim-which-key
" https://github.com/junegunn/vim-easy-align
" https://github.com/plasticboy/vim-markdown
" https://github.com/godlygeek/tabular
" https://github.com/dkarter/bullets.vim

" =============================================================================
" Plugin settings
" =============================================================================

" netrw
" -----------------------------------------------------------------------------
let g:netrw_liststyle=3

" vim-markdown
" -----------------------------------------------------------------------------
let g:vim_markdown_fenced_languages =[
    \ 'python=.py', 
    \ 'bash=sh', 
    \ 'ini=dowini'
    \ ]

" let g:vim_markdown_conceal
let g:vim_markdown_follow_anchor = 1
let g:vim_markdown_strikethrough = 1
let g:vim_markdown_new_list_item_indent = 0
let g:vim_markdown_no_extensions_in_markdown = 0
let g:im_markdown_autowrite = 1
let g:vim_markdown_edit_url_in = 'tab'

" Bullets
let g:bullets_enabled_file_types = [
    \ 'markdown',
    \ 'text',
    \ 'gitcommit',
    \ 'python'
    \]

" Nerd Tree
" -----------------------------------------------------------------------------
let NERDTreeShowHidden=1 "Always show dot (hidden) files
let NERDTreeQuitOnOpen=1 "Close the NERDTree after opening a file
let g:NERDTreeDirArrowExpandable = '+'
let g:NERDTreeDirArrowCollapsible = '-'

" Leader Mappings
" -----------------------------------------------------------------------------
let g:mapleader = " "

nnoremap <silent> <leader>fd :e $MYVIMRC<CR>

" Next tab
nnoremap <silent> <leader>n :tabnext<CR>
nnoremap <silent> <tab> :bnext<CR>

" Previous tab
nnoremap <silent> <leader>p :tabprev<CR>
nnoremap <silent> <S-tab> :bprev<CR>

" Expand|Shrink Window
nnoremap <silent> <leader>h <C-w>5<
nnoremap <silent> <leader>j :resize -5<CR>
nnoremap <silent> <leader>k :resize +5<CR>
nnoremap <silent> <leader>l <C-w>5>

" All windows same size
nnoremap <silent> <leader>= <C-w>=

" Splits
nnoremap <silent> <leader>s :split<CR>
nnoremap <silent> <leader>v :vsplit<CR>
nnoremap <silent> <leader>ts :term<CR>
nnoremap <silent> <leader>tv :vsplit<CR>:term<CR>

nnoremap <leader>pe :w<CR>:vertical terminal python3 %<CR>
nnoremap <leader>pr :w<CR>:vertical terminal bash python3<CR>

" Toggle Nerdtree
nnoremap <silent> <leader>ft :NERDTreeToggle<CR>

" NON LEADER MAPPINGS
" -----------------------------------------------------------------------------

" Open NERDTree
" nnoremap <S-n> :NERDTreeToggle<CR>

" Easyalign
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" vim-which-key

" Y to work as D and C work
nnoremap <S-y> y$

" Terminal escape
tnoremap <C-[> <C-\><C-n>

" When /search is activated this turns off highlighting
nnoremap <CR> :noh<CR>

" " Use tab to tab in normal mode
" nnoremap <tab> >>
" nnoremap <S-tab> <<

" " Use tab to tab in visual mode
" vnoremap <tab> >gv
" vnoremap <S-tab> <gv
vnoremap > >gv
vnoremap < <gv

" Shift selction up
vnoremap m :m '>+1<CR>gv=gv

" Shift secection down
vnoremap M :m '<-2<CR>gv=gv

" Window selction
nnoremap <silent> <C-h> <C-w>h
nnoremap <silent> <C-j> <C-w>j
nnoremap <silent> <C-k> <C-w>k
nnoremap <silent> <C-l> <C-w>l

" =============================================================================


" MAPPINGS
" =============================================================================


" WHICH KEY MENU
" -----------------------------------------------------------------------------
let g:mapleader = "\<Space>"
call which_key#register('<Space>', "g:which_key_map")

nnoremap <silent> <leader> :<c-u>WhichKey '<Space>'<CR>
vnoremap <silent> <leader> :<c-u>WhichKeyVisual '<Space>'<CR>
let g:which_key_vertical = 1

let g:which_key_map =  {}

nnoremap <silent> <leader> :WhichKey '<Space>'<CR>


" FILE MENU
" -----------------------------------------------------------------------------
let g:which_key_map.f = { 'name' : '+file' }

nnoremap <silent> <leader>fd :e $MYVIMRC<CR>
let g:which_key_map.f.d = 'open-vimrc'

nnoremap <silent> <leader>fs :w<CR>
let g:which_key_map.f.s = 'save-file'

nnoremap <silent> <leader>fq :w<CR>
let g:which_key_map.f.q = 'quit-file'

nnoremap <silent> <leader>ff :NERDTree<CR>
let g:which_key_map.f.f = 'search-file'

nnoremap <silent> <leader>fn :tabnext<CR>
let g:which_key_map.f.n = 'next-tab'

nnoremap <silent> <leader>fp :tabprev<CR>
let g:which_key_map.f.p = 'prev-tab'


" SEARCH MENU
" -----------------------------------------------------------------------------
let g:which_key_map.s = { 'name' : '+search' }

nnoremap <silent> <leader>sf :Ag <C-r><C-w><CR>
let g:which_key_map.s.f = 'search-selected-word'

nnoremap <silent> <leader>se :Ag<space>
let g:which_key_map.s.e = 'search-for-pattern'


" WINDOW MENU
" -----------------------------------------------------------------------------
let g:which_key_map.w = { 'name' : '+window' }

nnoremap <silent> <leader>wl <C-w>l
let g:which_key_map.w.l = 'select-left-window'

nnoremap <silent> <leader>wh <C-w>h
let g:which_key_map.w.h = 'select-right-window'

nnoremap <silent> <leader>wk <C-w>k
let g:which_key_map.w.k = 'select-up-window'

nnoremap <silent> <leader>wj <C-w>j
let g:which_key_map.w.j = 'select-down-window'

nnoremap <silent> <leader>wL <C-w>5<
let g:which_key_map.w.L = 'expand-window-to-right'

nnoremap <silent> <leader>wH <C-w>5>
let g:which_key_map.w.H = 'expand-window-to-left'

nnoremap <silent> <leader>wJ :resize -5<CR>
let g:which_key_map.w.J = 'expand-window-to-below'

nnoremap <silent> <leader>wK :resize +5<CR>
let g:which_key_map.w.K = 'expand-window-to-above'

nnoremap <silent> <leader>wb <C-w>=
let g:which_key_map.w.b = 'windows-same-size'

nnoremap <silent> <leader>ws <C-w>s
let g:which_key_map.w.s = 'split-window-below'

nnoremap <silent> <leader>wv <C-w>v
let g:which_key_map.w.v = 'split-window-right'


" TERMINAL MENU
" -----------------------------------------------------------------------------
nnoremap <silent> <leader>ts :term<CR>:termwinsize 30x0
let g:which_key_map.w.v = 'open-terminal-below'

nnoremap <silent> <leader>tv :vsplit<CR>:term<CR>:termwinsize 0x80
let g:which_key_map.w.v = 'open-terminal-right'


:autocmd FileType python    nnoremap <buffer> <leader>c I#<esc>
:autocmd FileType python    nnoremap <buffer> <leader>c I#<esc>
