" disable smart case in command line mode
augroup dynamic_smartcase
  autocmd!
  autocmd CmdLineEnter : set nosmartcase
  autocmd CmdLineLeave : set smartcase
augroup END

augroup term_settings
  autocmd!
  " disable numbers for terminal
  autocmd TermOpen * setlocal norelativenumber nonumber
  " open insert mode by default
  autocmd TermOpen * startinsert
augroup END

augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu | set rnu   | endif
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu | set nornu | endif
augroup END

augroup custom_highlight
  autocmd!
  autocmd ColorScheme * call s:custom_highlight()
augroup END

function! s:custom_highlight() abort
  highlight YankColor ctermfg=59 ctermbg=41 guifg=#34495E guibg=#8EBD6B
  highlight Cursor cterm=bold gui=bold guibg=#8EBD6B guifg=#34495E
  highlight Cursor2 guifg=#E55561 guibg=#E55561
  highlight FloatBorder guifg=LightGreen guibg=NONE
  highlight MatchParen cterm=bold,underline gui=bold,underline
  highlight CursorLineNr guifg=#A3BE8C
endfunction

augroup git_repo_check
  autocmd!
  autocmd VimEnter,DirChanged * call utils#Inside_git_repo()
augroup END

function! s:handle_large_file() abort
  let g:large_file = 1 * 1024 * 1024  " 1MB
  let f = expand("<afile>")

  if getfsize(f) > g:large_file || getfsize(f) == -2
    set eventignore+=all
    set norelativenumber
    setlocal noswapfile bufhidden=unload buftype=nowrite undolevels=-1
  else
    set eventignore-=all relativenumber
  endif
endfunction

augroup LargeFile
  autocmd!
  autocmd BufReadPre * call s:handle_large_file()
augroup END
