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

fu! NtreeToggle#GoSearch(dirname, fname)
  leftabove vsplit
  try
    exe printf("b%d", s:ntree_bufnr)
  catch
    Ntree
  endtry
  if len(a:dirname) > 0
    exe printf("Ntree %s", getcwd())
  endif
  let bufnr = bufnr()
  if exists("s:ntree_bufnr") && bufnr != s:ntree_bufnr
    try
      exe printf("%dbw", s:ntree_bufnr)
    catch
    endtry
  endif
  let s:ntree_bufnr = bufnr
  norm iii
  call search(escape(a:fname, '.'))
  let width = NtreeToggle#GetWidth()
  call nvim_win_set_width(0, width)
endfu

fu! NtreeToggle#Toggle()
  let ntree_winid = NtreeToggle#GetNetrwWinId()
  if ntree_winid != -1
    call NtreeToggle#GoAndQuit(ntree_winid)
  else
    call NtreeToggle#GoSearch('', '')
  endif
endfu

fu! NtreeToggle#ToggleSearchFname()
  let ntree_winid = NtreeToggle#GetNetrwWinId()
  if ntree_winid != -1
    call NtreeToggle#GoAndQuit(ntree_winid)
  else
    call NtreeToggle#GoSearch('', bufname("%"))
  endif
endfu

fu! NtreeToggle#ToggleSearchDirnameFname()
  let ntree_winid = NtreeToggle#GetNetrwWinId()
  if ntree_winid != -1
    call NtreeToggle#GoAndQuit(ntree_winid)
  else
    call NtreeToggle#GoSearch(getcwd(), bufname("%"))
  endif
endfu
