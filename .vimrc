set nocompatible

" vundle package manager

filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'             " vim package manager
Plugin 'drewtempelmeyer/palenight.vim' " vim theme
Plugin 'scrooloose/nerdtree'           " tree of directory files
Plugin 'junegunn/fzf.vim'              " fuzzy finder
Plugin 'majutsushi/tagbar'             " structure of source files
Plugin 'itchyny/lightline.vim'         " statusbar
Plugin 'tpope/vim-commentary'          " commentaries
Plugin 'tpope/vim-fugitive'            " git
Plugin 'tpope/vim-surround'            " add, del, edit brackets, quotes, etc
Plugin 'Raimondi/delimitMate'          " auto-complete brackets, quotes, etc
Plugin 'valloric/youcompleteme'        " multi-language autocomplete
" after install do in terminal
" cd ~/.vim/bundle/youcompleteme && python3 install.py

Plugin 'sheerun/vim-polyglot'          " multi-language highlighting
Plugin 'puremourning/vimspector'       " debugger
Plugin 'vim-test/vim-test'             " run tests
Plugin 'mhinz/vim-signify'             " git diff
Plugin 'w0rp/ale'                      " linting
Plugin 'maximbaz/lightline-ale'        " ale indicator for lightline
Plugin 'pixelneo/vim-python-docstring' " generate python docstring

" markdown
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
Plugin 'iamcco/markdown-preview.nvim'
" after install do :call mkdp#util#install()

call vundle#end()

filetype on
filetype plugin on
filetype plugin indent on

" general settings

aunmenu Help.
aunmenu Window.
let no_buffers_menu=1
let mapleader=','

tab sball
set backspace=indent,eol,start
set clipboard+=unnamedplus
set cmdheight=2
set confirm
set completeopt-=preview
set encoding=utf-8
set equalalways
set gcr=a:blinkon0
set hlsearch
set incsearch
set linebreak
set list
set listchars=tab:»»,trail:·
set ls=2
set mousemodel=popup
set novisualbell
set number
set scrolloff=5
set showcmd
set showmatch
set showmode
set switchbuf=useopen
if $TERM == "xterm-256color" || $TERM == "screen-256color" || $COLORTERM == "gnome-terminal"
  set t_Co=256
endif
set ttyfast
set visualbell t_vb=
set wildmenu
set wrap

" tabs
set expandtab
set tabstop=4
set shiftwidth=4
set smarttab
set softtabstop=4
autocmd FileType yaml setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType markdown setlocal shiftwidth=2 tabstop=2 softtabstop=2

" colors
set background=dark
if (has("termguicolors"))
    set termguicolors
endif
silent! colorscheme palenight

" :W = :w and :Q = :q
command! W w
command! Q q

" undo history
if isdirectory($HOME . '/.vim/undo') == 0
:silent !mkdir -p ~/.vim/undo > /dev/null 2>&1
endif
set undodir=./.vim-undo// undodir+=~/.vim/undo// undofile

" highlight if line > 80 symbols
augroup vimrc_autocmds
    autocmd!
    autocmd FileType python highlight Excess ctermbg=DarkGrey guibg=Black
    autocmd FileType python match Excess /\%121v.*/
augroup END

" auto-resize splits when Vim gets resized
autocmd VimResized * wincmd =

" youcompleteme
let g:ycm_python_interpreter_path = ''
let g:ycm_python_sys_path = []
let g:ycm_extra_conf_vim_data = [
\  'g:ycm_python_interpreter_path',
\  'g:ycm_python_sys_path',
\ ]
let g:ycm_global_ycm_extra_conf = '~/.global_extra_conf.py'
nmap <Leader>g :YcmCompleter GoToDeclaration<CR>
nmap <Leader>r :YcmCompleter RefactorRename 

" python-syntax
syntax on
let g:python_highlight_all = 1

" ale
nmap <Leader>f :ALEFix<CR>
nmap <Leader>i :ALEFix isort<CR>
let g:ale_virtualenv_dir_names = ['venv', 'env']
let g:ale_linters = {
\  'sh': ['shell'],
\  'json': ['jq'],
\  'python': ['flake8'],
\  'markdown': ['markdownlint'],
\  'ansible': ['ansible-lint'],
\ }
let g:ale_fixers = {
\  'sh': ['shfmt'],
\  'json': ['jq'],
\  'python': ['isort', 'black'],
\  'markdown': ['prettier']
\ }
let g:ale_echo_msg_format = '[%linter%] %s'
nmap <Leader>w :lwindow<CR>

" lightline
set laststatus=2
set noshowmode
let g:lightline = {
\ 'colorscheme': 'deus',
\ 'active': {
\   'left': [['mode', 'paste'], ['filename', 'modified']],
\   'right': [['lineinfo'], ['percent'], ['filetype'], ['readonly', 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_infos', 'linter_ok' ]]
\ },
\ 'component_expand': {
\  'linter_checking': 'lightline#ale#checking',
\  'linter_infos': 'lightline#ale#infos',
\  'linter_warnings': 'lightline#ale#warnings',
\  'linter_errors': 'lightline#ale#errors',
\  'linter_ok': 'lightline#ale#ok',
\ },
\ 'component_type': {
\  'linter_checking': 'right',
\  'linter_infos': 'right',
\  'linter_warnings': 'warning',
\  'linter_errors': 'error',
\  'linter_ok': 'right',
\ },
\ }

" signify
let g:signify_vcs_list = [ 'git' ]

" plasticboy
let g:vim_markdown_folding_disabled = 1

" NerdTree
nmap <Leader>t :NERDTreeToggle<CR>
let NERDTreeIgnore=['\~$', '\.pyc$', '\.pyo$', '\.class$', 'pip-log\.txt$', '\.o$']
let g:NERDTreeQuitOnOpen = 1
autocmd StdinReadPre * let s:std_in=1

" structure of src files
nmap <Leader>l :TagbarToggle<CR>
let g:Tlist_Ctags_Cmd='/usr/bin/ctags'
let g:tagbar_autofocus = 0

" run
autocmd FileType python nmap <Leader>e :w<CR> :! python %<CR>
autocmd FileType python nmap <Leader>E :w<CR> :! python % 
autocmd FileType sh nmap <Leader>e :w<CR> :! bash %<CR>
autocmd FileType sh nmap <Leader>E :w<CR> :! bash % 
autocmd FileType markdown nmap <Leader>e :MarkdownPreview<CR>

" yaml switch to ansible
autocmd Filetype yaml nmap <Leader>e :set filetype=ansible.yaml<CR>

" tests
let test#strategy="vimterminal"
let test#python#runner="pytest"
nmap <Leader>n :TestNearest<CR>
nmap <Leader>m :TestFile<CR>
nmap <Leader>b :TestLast<CR>

" debugger
let g:vimspector_enable_mappings="HUMAN"

" nu and paste and signcolumn toggle
function! SignColumnToggle()
    if !exists("b:signcolumn_on") || b:signcolumn_on
        set signcolumn=no
        let b:signcolumn_on=0
    else
        set signcolumn=auto
        let b:signcolumn_on=1
    endif
endfunction

nmap <Leader>p :set nu!<CR>:set paste!<CR>:call SignColumnToggle()<CR>

" choose buffer
nmap <C-c> :buffers<CR>:buffer<Space>

" close buffer
nmap <C-x> :bd<CR>

" show registers
nmap <Leader>' :reg<CR>

" window movement
nmap <C-j> <C-W>j
nmap <C-k> <C-W>k
nmap <C-h> <C-W>h
nmap <C-l> <C-W>l

" docstring
nmap <Leader>- :Docstring<CR>
let g:python_style='google'

" rg
nmap <Leader>a :Rg<CR>

" fzf
nmap <Leader>c :Buffers<CR>
nmap <expr> <Leader>s FugitiveHead() != '' ? ':GFiles<CR>' : ':Files<CR>'

" reset search highlighting
nmap <Leader>q :nohlsearch<CR>
