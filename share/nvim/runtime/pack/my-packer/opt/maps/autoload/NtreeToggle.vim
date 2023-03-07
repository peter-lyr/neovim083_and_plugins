fu! NtreeToggle#GetNetrwWinId()
  for i in range(1, winnr('$'))
    let bufnr = winbufnr(i)
    if getbufvar(bufnr, '&filetype') == 'netrw'
      return win_getid(bufwinnr(bufnr))
    endif
  endfor
  return -1
endfu

fu! NtreeToggle#GoAndQuit(winid)
  if &ft == 'netrw'
    wincmd p
  endif
  let cur_winid = win_getid(winnr())
  call win_gotoid(a:winid)
  if winnr('$') > 1
    hide
  endif
  call win_gotoid(cur_winid)
endfu

fu! NtreeToggle#GetWidth()
  let MaxWidth = &columns
  let MaxWidth /= 2
  let columns = 0
  for i in range(8, line('$'))
    let width = strwidth(getline(i))
    if width >= MaxWidth - 4
      return MaxWidth
    endif
    if width >= columns
      let columns = width
    endif
  endfor
  return max([columns + 4, 24])
endfu

fu! NtreeToggle#Go()
  leftabove vsplit
  try
    exe printf("b%d", s:ntree_bufnr)
  catch
    Ntree
    let s:ntree_bufnr = bufnr()
  endtry
  norm iii
  let width = NtreeToggle#GetWidth()
  call nvim_win_set_width(0, 24)
endfu

fu! NtreeToggle#Toggle()
  let ntree_winid = NtreeToggle#GetNetrwWinId()
  if ntree_winid != -1
    call NtreeToggle#GoAndQuit(ntree_winid)
  else
    call NtreeToggle#Go()
  endif
endfu
