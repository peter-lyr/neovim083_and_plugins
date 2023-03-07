function! NtreeToggle#GetNetrwWinId()
  for i in range(1, winnr('$'))
    let bufnr = winbufnr(i)
    if getbufvar(bufnr, '&filetype') == 'netrw'
      return win_getid(bufwinnr(bufnr))
    endif
  endfor
  return -1
endfunction

fu! NtreeToggle#Toggle()
  let netrw_winid = NtreeToggle#GetNetrwWinId()
  if netrw_winid != -1
    call win_gotoid(netrw_winid)
    q
  else
    leftabove vnew
    Ntree
  endif
endfu
