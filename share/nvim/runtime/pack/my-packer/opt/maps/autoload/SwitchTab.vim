fu! SwitchTab#SpaceCr()
  if !exists('g:lasttab')
    echomsg '2222222'
    return
  endif
  exe "tabn ".g:lasttab
endfu
