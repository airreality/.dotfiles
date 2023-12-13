set confirm
set fillchars=fold:\ ,vert:\│,eob:\ ,msgsep:‾
set gcr=a:blinkon0
set history=100
set linebreak
set list
set listchars=tab:▸\ ,extends:❯,precedes:❮,nbsp:␣,trail:·
set mouse=nic
set mousemodel=popup
set mousescroll=ver:1,hor:0
set noerrorbells
set noruler
set noshowmode
set noswapfile
set number
set relativenumber
set scrolloff=5
set shortmess+=I
set shortmess+=S
set shortmess+=c
set signcolumn=yes:1
set splitbelow
set splitright
set termguicolors
set undofile
set virtualedit=block
set visualbell
set wrap

set tabstop=2       " number of visual spaces per TAB
set softtabstop=2   " number of spaces in tab when editing
set shiftwidth=2    " number of spaces to use for autoindent
set expandtab       " expand tab to spaces so that tabs are spaces

" align indent to next multiple value of shiftwidth
" http://vim.1045645.n5.nabble.com/shiftround-option-td5712100.html
set shiftround

set ignorecase
set smartcase

set colorcolumn=120

set title
set titlestring=
set titlestring=%{utils#Get_titlestr()}

set clipboard+=unnamedplus  " use clipboard for all delete, yank, change, put

set timeoutlen=500  " time in milliseconds to wait for a mapped sequence to complete
set updatetime=500  " for CursorHold events

" file and script encoding
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1

set completeopt+=menuone
set completeopt-=preview

" util for grep command
set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
set grepformat=%f:%l:%c:%m

" spell
set spelllang=en
set spellsuggest+=9  " show 9 spell suggestions at most

" diff options
set diffopt=
set diffopt+=vertical  " show diff in vertical position
set diffopt+=filler  " show filler for deleted lines
set diffopt+=closeoff  " turn off diff when one file window is closed
set diffopt+=context:3  " context for diff
set diffopt+=internal,indent-heuristic,algorithm:histogram
set diffopt+=linematch:60

" set up cursor color and shape in various mode
" https://github.com/neovim/neovim/wiki/FAQ#how-to-change-cursor-color-in-the-terminal
set guicursor=n-v-c:block-Cursor/lCursor,i-ci-ve:ver25-Cursor2/lCursor2,r-cr:hor20,o:hor20

set pumheight=10  " maximum number of items to show in popup menu
set pumblend=10  " pseudo transparency for completion menu
set winblend=0  " pseudo transparency for floating window

" insert mode key word completion setting
set complete+=kspell complete-=w complete-=b complete-=u complete-=t
