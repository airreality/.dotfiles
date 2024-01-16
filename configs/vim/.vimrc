set nocompatible

let data_dir = '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source '~/.vimrc'
endif

call plug#begin('~/.vim/plugged')
Plug 'rakr/vim-one'                  " vim theme
Plug 'sheerun/vim-polyglot'          " multi-language highlighting
call plug#end()

" general settings

aunmenu Help.
aunmenu Window.
let no_buffers_menu=1
let mapleader=','

tab sball
set autoread
set backspace=indent,eol,start
set clipboard^=unnamed
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
set noshowmode
set novisualbell
set number
set scrolloff=5
set showcmd
set showmatch
set switchbuf=useopen
if $TERM == "xterm-256color" || $TERM == "screen-256color" || $COLORTERM == "gnome-terminal"
  set t_Co=256
endif
set ttyfast
set visualbell t_vb=
set wildmenu
set wrap

" tabs
set tabstop=2       " number of visual spaces per TAB
set softtabstop=2   " number of spaces in tab when editing
set shiftwidth=2    " number of spaces to use for autoindent
set expandtab       " expand tab to spaces so that tabs are spaces
set smarttab

autocmd FileType python setlocal shiftwidth=4 tabstop=4 softtabstop=4

" colors
set background=dark
if (has("termguicolors"))
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    set termguicolors
endif
let g:terminal_ansi_colors = [
\  '#2c323c', '#e06c75', '#98c379', '#e5c07b',
\  '#61afef', '#c678dd', '#56b6c2', '#5c6370',
\  '#3e4452', '#e06c75', '#98c379', '#e5c07b',
\  '#61afef', '#c678dd', '#56b6c2', '#abb2bf',
\ ]
highlight Terminal guibg='#282c34'
highlight Terminal guifg='#abb2bf'
let g:one_allow_italics = 1
silent! colorscheme one

" :W = :w and :Q = :q
command! W w
command! Q q

" undo history
if isdirectory($HOME . '/.vim/undo') == 0
:silent !mkdir -p ~/.vim/undo > /dev/null 2>&1
endif
set undodir=./.vim-undo// undodir+=~/.vim/undo// undofile

" highlight if line > 120 symbols
augroup vimrc_autocmds
    autocmd!
    autocmd FileType python highlight Excess ctermbg=DarkGrey guibg=Black
    autocmd FileType python match Excess /\%121v.*/
augroup END

" auto-resize splits when Vim gets resized
autocmd VimResized * wincmd =

" python-syntax
syntax on
let g:python_highlight_all = 1

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

" reset search highlighting
nmap <Leader>q :nohlsearch<CR>

" vertical term in vim
nmap <Leader>v :vert term<CR>
