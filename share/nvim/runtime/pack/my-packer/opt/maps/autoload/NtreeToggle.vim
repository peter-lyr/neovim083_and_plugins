" fu! NtreeToggle#GetNetrwInfo()
"   let g:t = ""
"   if getbufvar(bufnr(), '&filetype') == 'netrw'
"     for [k, v] in items(getbufvar(bufnr(), "&"))
"       let g:t .= printf("%s: %s\n", k, string(v))
"     endfor
"     let g:t .= "---------\n"
"     for [k, v] in items(getbufvar(bufnr(), ""))
"       let g:t .= printf("%s: %s\n", k, string(v))
"     endfor
"     let g:t .= "=========\n"
"   endif
" endfu

fu! NtreeToggle#NextDir(next)
  let item = getbufvar(bufnr(), 'netrw_curdir')
  let l = len(s:ntree_list)
  let i = 0
  let idx = index(s:ntree_list, item)
  if idx != -1
    let i = idx
    if a:next == 1
      if idx < l - 1
        let idx += 1
      else
        let idx = 0
      endif
    else
      if idx > 0
        let idx -= 1
      else
        let idx = l - 1
      endif
    endif
    if i == idx
      return
    endif
  else
    let idx = 0
  endif
  exe printf("Ntree %s", s:ntree_list[idx])
  ec printf("Ntree %s", s:ntree_list[idx])
  call NtreeToggle#NextDirMap()
endfu

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

" fu! NtreeToggle#SetWidth()
"   let MaxWidth = &columns
"   let MaxWidth /= 2
"   let columns = 0
"   let res = 0
"   if getline(1)[0:2] == '../'
"     let start = 1
"   else
"     let start = 8
"   endif
"   for i in range(start, line('$'))
"     let width = strwidth(getline(i))
"     if width >= MaxWidth - 4
"       let res = MaxWidth
"       break
"     endif
"     if width >= columns
"       let columns = width
"     endif
"   endfor
"   let res = max([columns + 4, 24])
"   call nvim_win_set_width(0, res)
" endfu

fu! NtreeToggle#UpdateList(remove_only)
  if !exists("s:ntree_list")
    let s:ntree_list = []
  endif
  let item = getbufvar(bufnr(), 'netrw_curdir')
  try
    let idx = index(s:ntree_list, item)
    if idx != -1
      call remove(s:ntree_list, idx)
    endif
  catch
  endtry
  if !a:remove_only
    let s:ntree_list += [item]
  endif
endfu

fu! NtreeToggle#SearchFname(text)
  call search(escape(a:text, '.'))
  if getline(1)[0:2] != '../'
    if line('.') < 8
      norm 8gg0
    endif
  endif
endfu

fu! NtreeToggle#NextDirMap()
  if &ft == 'netrw'
    nnoremap <silent><nowait><buffer> > :call NtreeToggle#NextDir(1)<cr>
    nnoremap <silent><nowait><buffer> < :call NtreeToggle#NextDir(0)<cr>
    nnoremap <silent><nowait><buffer> J :call NtreeToggle#UpdateList(1)<cr>
    nnoremap <silent><nowait><buffer> K :call NtreeToggle#UpdateList(0)<cr>
  endif
endfu

fu! NtreeToggle#OpenDir(dirname)
  Ntree
  if len(a:dirname) > 0
    exe printf("Ntree %s", a:dirname)
  endif
  norm i
  call NtreeToggle#NextDirMap()
endfu

fu! NtreeToggle#GoSearch(dirname, fname)
  leftabove split
  call NtreeToggle#OpenDir(a:dirname)
  call NtreeToggle#UpdateList(0)
  call NtreeToggle#SearchFname(a:fname)
  " call NtreeToggle#SetWidth()
endfu

fu! NtreeToggle#GetDirname()
  let fname = nvim_buf_get_name(0)
  let fname = substitute(fname, '\', '/', 'g')
  try
    let dirname = join(split(fname, '/')[0:-2], '/')
    return dirname
  catch
    return ''
  endtry
endfu

fu! NtreeToggle#GetFname()
  let fname = bufname("%")
  let fname = substitute(fname, '\', '/', 'g')
  try
    let fname = split(fname, '/')[-1]
    return fname
  catch
    return ''
  endtry
endfu

fu! NtreeToggle#ToggleSearchFname()
  let ntree_winid = NtreeToggle#GetNetrwWinId()
  if ntree_winid != -1
    call NtreeToggle#GoAndQuit(ntree_winid)
  else
    let dirname = NtreeToggle#GetDirname()
    let fname = NtreeToggle#GetFname()
    call NtreeToggle#GoSearch(dirname, fname)
  endif
endfu

fu! NtreeToggle#ToggleSearchDirnameFname()
  let ntree_winid = NtreeToggle#GetNetrwWinId()
  if ntree_winid != -1
    call NtreeToggle#GoAndQuit(ntree_winid)
  else
    let dirname = getcwd()
    let fname = NtreeToggle#GetFname()
    call NtreeToggle#GoSearch(dirname, fname)
  endif
endfu
