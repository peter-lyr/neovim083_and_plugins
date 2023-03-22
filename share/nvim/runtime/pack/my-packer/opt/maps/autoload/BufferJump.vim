let s:bufferjump_miximize = 1

fu! BufferJump#Up(cnt)
  exe string(a:cnt) . 'wincmd k'
  if s:bufferjump_miximize && &winfixheight == 0
    wincmd _
  endif
  " if &winfixheight == 1
  "   call nvim_win_set_height(0, 12)
  " endif
endfu

fu! BufferJump#Down(cnt)
  exe string(a:cnt) . 'wincmd j'
  if s:bufferjump_miximize && &winfixwidth == 0
    wincmd _
  endif
  if &winfixwidth == 1
    call nvim_win_set_width(0, 36)
  endif
endfu

fu! BufferJump#Left(cnt)
  exe string(a:cnt) . 'wincmd h'
endfu

fu! BufferJump#Right(cnt)
  exe string(a:cnt) . 'wincmd l'
endfu

fu! BufferJump#Miximize(enable)
  if a:enable
    let s:bufferjump_miximize = 1
    wincmd _
  else
    let s:bufferjump_miximize = 0
    wincmd =
  endif
endfu

fu! BufferJump#MaxHeight()
  wincmd _
endfu

fu! BufferJump#SameWidthHeight()
  wincmd =
  if &winfixheight == 1
    set nowinfixheight
    wincmd =
    set winfixheight
  endif
endfu

fu! BufferJump#SameWidthHeightFix()
  let cur_winid = win_getid(winnr())
  for i in range(1, winnr('$'))
    let bufnr = winbufnr(i)
    call win_gotoid(win_getid(bufwinnr(bufnr)))
    if &winfixheight == 1
      call nvim_win_set_height(0, 12)
    endif
    if &winfixwidth == 1
      call nvim_win_set_width(0, 36)
    endif
  endfor
  wincmd =
  call win_gotoid(cur_winid)
endfu

fu! BufferJump#MaxWidth()
  wincmd |
endfu

fu! BufferJump#WinFixHeight()
  set winfixheight
endfu

fu! BufferJump#NoWinFixHeight()
  set nowinfixheight
endfu

fu! BufferJump#WinFixWidth()
  set winfixwidth
endfu

fu! BufferJump#NoWinFixWidth()
  set nowinfixwidth
endfu
