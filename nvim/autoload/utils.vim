function! utils#SwitchLine(src_line_idx, direction) abort
  if a:direction ==# 'up'
    if a:src_line_idx == 1
        return
    endif
    move-2
  elseif a:direction ==# 'down'
    if a:src_line_idx == line('$')
        return
    endif
    move+1
  endif
endfunction

function! utils#MoveSelection(direction) abort
  " only do this if previous mode is visual line mode. Once we press some keys in
  " visual line mode, we will leave this mode. So the output of `mode()` will be
  " `n` instead of `V`. We can use `visualmode()` instead to check the previous
  " mode, see also https://stackoverflow.com/a/61486601/6064933
  if visualmode() !=# 'V'
    return
  endif

  let l:start_line = line("'<")
  let l:end_line = line("'>")
  let l:num_line = l:end_line - l:start_line + 1

  if a:direction ==# 'up'
    if l:start_line == 1
      " we can also directly use `normal gv`, see https://stackoverflow.com/q/9724123/6064933
      normal! gv
      return
    endif
    silent execute printf('%s,%smove-2', l:start_line, l:end_line)
    normal! gv
  elseif a:direction ==# 'down'
    if l:end_line == line('$')
      normal! gv
      return
    endif
    silent execute printf('%s,%smove+%s', l:start_line, l:end_line, l:num_line)
    normal! gv
  endif
endfunction


function! utils#Get_titlestr() abort
  let l:title_str = ''
  let l:buf_path = expand('%:p:~')
  let l:title_str = l:title_str . l:buf_path . '  '
  return l:title_str
endfunction

" Check if we are inside a Git repo.
function! utils#Inside_git_repo() abort
  let res = system('git rev-parse --is-inside-work-tree')
  if match(res, 'true') == -1
    return v:false
  else
    " Manually trigger a special user autocmd InGitRepo (used lazyloading.
    doautocmd User InGitRepo
    return v:true
  endif
endfunction
