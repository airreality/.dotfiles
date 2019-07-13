set nocompatible

" vundle package manager
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'           " vim package manager
Plugin 'scrooloose/nerdtree'         " tree of directory files
Plugin 'majutsushi/tagbar'           " structure of source files
Plugin 'bling/vim-airline'           " statusbar
Plugin 'fisadev/FixedTaskList.vim'   " todo list
Plugin 'tpope/vim-commentary'        " commentaries
Plugin 'tpope/vim-fugitive'          " git
Plugin 'tpope/vim-surround'          " add, del, edit brackets, quotes, etc
Plugin 'Raimondi/delimitMate'        " auto-complete brackets, quotes, etc
Plugin 'valloric/youcompleteme'      " multi-language autocomplete
Plugin 'vim-python/python-syntax'    " python highlighting
Plugin 'pallets/jinja'               " jinja2 highlighting
Plugin 'ekalinin/dockerfile.vim'     " dockerfile highlighting
Plugin 'mhinz/vim-signify'           " git diff
Plugin 'w0rp/ale'                    " linting

" markdown
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
Plugin 'iamcco/markdown-preview.nvim'
" after install md-preview do :call mkdp#util#install()

" snippets
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'garbas/vim-snipmate'
Plugin 'honza/vim-snippets'

call vundle#end()

filetype on
filetype plugin on
filetype plugin indent on

" general settings

aunmenu Help.
aunmenu Window.
let no_buffers_menu=1

tab sball
set backspace=indent,eol,start
set cmdheight=2
set confirm
set completeopt-=preview
set encoding=utf-8
set equalalways
set expandtab
set gcr=a:blinkon0
set hlsearch
set incsearch
set list
set listchars=tab:>-,trail:-
set ls=2
set mousemodel=popup
set novisualbell
set nu
set scrolloff=5
set shiftwidth=4
set showcmd
set showmatch
set showmode
set smarttab
set switchbuf=useopen
set tabstop=4
set ttyfast
set visualbell t_vb=
set wildmenu

" :W = :w and :Q = :q
command! W w
command! Q q

" highlight if line > 80 symbols
augroup vimrc_autocmds
    autocmd!
    autocmd FileType python highlight Excess ctermbg=DarkGrey guibg=Black
    autocmd FileType python match Excess /\%80v.*/
    autocmd FileType python set nowrap
augroup END

" auto-resize splits when Vim gets resized
autocmd VimResized * wincmd =

" youcompleteme
let g:ycm_python_interpreter_path = ''
let g:ycm_python_sys_path = []
let g:ycm_extra_conf_vim_data = [
\  'g:ycm_python_interpreter_path',
\  'g:ycm_python_sys_path'
\]
let g:ycm_global_ycm_extra_conf = '~/.global_extra_conf.py'

" python-syntax
syntax on
let g:python_highlight_all = 1

" ale
let g:ale_virtualenv_dir_names = []
let g:ale_linters = {
\  'sh': ['shell'],
\  'python': ['flake8', 'pylint', 'autopep8']
\}
let g:ale_fixers = {
\  'python': [
\    'isort',
\    'add_blank_lines_for_python_control_statements',
\    'black'
\  ]
\}

" markdown preview
let g:mkdp_auto_start = 1

" snippets
let g:snippets_dir = "~/.vim/vim-snippets/snippets"

" airline
set laststatus=2
let g:airline_theme='behelit'
let g:airline_powerline_fonts = 1
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'

" signify
let g:signify_vcs_list = [ 'git' ]

" plasticboy
let g:vim_markdown_folding_disabled = 1

" F2 = Tasks
nmap <F2> :TaskList<CR>

" F3 = NerdTree
nmap <F3> :NERDTreeToggle<CR>
let NERDTreeIgnore=['\~$', '\.pyc$', '\.pyo$', '\.class$', 'pip-log\.txt$', '\.o$']
let g:NERDTreeQuitOnOpen = 1
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" F4 = Structure of src files
nmap <F4> :TagbarToggle<CR>
let g:Tlist_Ctags_Cmd='/usr/bin/ctags'
let g:tagbar_autofocus = 0

" F5, F6 = Run python scripts
autocmd FileType python nmap <F5> :w<CR> :! clear; python %<CR>
autocmd FileType python nmap <F6> :w<CR> :! clear; python % 
autocmd FileType sh nmap <F5> :w<CR> :! sh %<CR>
autocmd FileType sh nmap <F6> :w<CR> :! sh % 

" F8 = ale fixer
nmap <F8> :ALEFix<CR>

" close buffer
nmap <C-q> :bd<CR>
