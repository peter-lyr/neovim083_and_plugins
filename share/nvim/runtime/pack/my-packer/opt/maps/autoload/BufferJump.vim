let s:bufferjump_miximize = 1

fu! BufferJump#Up()
  wincmd k
  if s:bufferjump_miximize
    wincmd _
  endif
endfu

fu! BufferJump#Down()
  wincmd j
  if s:bufferjump_miximize
    wincmd _
  endif
endfu

fu! BufferJump#Left()
  wincmd h
endfu

fu! BufferJump#Right()
  wincmd l
endfu

fu! BufferJump#Miximize(enable)
  if a:enable
    let s:bufferjump_miximize = 1
  else
    let s:bufferjump_miximize = 0
  endif
endfu

fu! BufferJump#MaxHeight()
  wincmd _
endfu

fu! BufferJump#SameWidthHeight()
  wincmd =
endfu

fu! BufferJump#MaxWidth()
  wincmd |
endfu
