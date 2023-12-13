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

" return to last cursor position on file opening
augroup resume_cursor_position
  autocmd!
  autocmd BufReadPost * call s:resume_cursor_position()
augroup END

" return to last cursor position when there is no go-to-line command (something like '+23').
function s:resume_cursor_position() abort
  if line("'\"") > 1 && line("'\"") <= line("$") && &ft !~# 'commit'
    let l:args = v:argv  " command line arguments
    for l:cur_arg in l:args
      " check if a go-to-line command is given.
      let idx = match(l:cur_arg, '\v^\+(\d){1,}$')
      if idx != -1
        return
      endif
    endfor

    execute "normal! g`\"zvzz"
  endif
endfunction

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
  highlight YankColor ctermfg=59 ctermbg=41 guifg=#34495E guibg=#2ECC71
  highlight Cursor cterm=bold gui=bold guibg=#00c918 guifg=black
  highlight Cursor2 guifg=red guibg=red
  highlight FloatBorder guifg=LightGreen guibg=NONE
  highlight MatchParen cterm=bold,underline gui=bold,underline
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
