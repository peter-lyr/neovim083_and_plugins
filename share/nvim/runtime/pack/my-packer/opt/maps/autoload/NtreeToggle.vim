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

fu! NtreeToggle#UpdateList()
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
  call insert(s:ntree_list, item)
endfu

fu! NtreeToggle#SearchFname(text)
  call search(escape(a:text, '.'))
  if getline(1)[0:2] != '../'
    if line('.') < 8
      norm 8gg0
    endif
  endif
endfu

fu! NtreeToggle#OpenDir(dirname)
  Ntree
  if len(a:dirname) > 0
    exe printf("Ntree %s", a:dirname)
  endif
  norm i
endfu

fu! NtreeToggle#GoSearch(dirname, fname)
  leftabove split
  call NtreeToggle#OpenDir(a:dirname)
  call NtreeToggle#UpdateList()
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

fu! NtreeToggle#Test()
  echomsg s:ntree_list
endfu

nnoremap <F7> :call NtreeToggle#Test()<cr>
