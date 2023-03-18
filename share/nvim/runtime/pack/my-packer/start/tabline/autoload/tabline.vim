fu tabline#get_fname(n)
  let buflist = tabpagebuflist(a:n)
  let winnr = tabpagewinnr(a:n)
  let bufname = nvim_buf_get_name(buflist[winnr-1])
  if len(trim(bufname)) == 0
    return '[No Name]'
  endif
  let bufname = substitute(bufname, '\', '/', 'g')
  let res = split(bufname, ':')[0][0] .'\'
  try
    let res .= join(split(bufname, '/')[-3:-2], '/')
  catch
    let res .= split(bufname, '/')[-2]
  endtry
  return res
endfu

fu tabline#tabline()
  let s = ''
  for i in range(tabpagenr('$'))
    if i + 1 == tabpagenr()
      let s ..= '%#TabLineSel#'
    else
      let s ..= '%#TabLine#'
    endif
    let s ..= '%' .. (i + 1) .. 'T'
    let s ..= ' %{tabline#get_fname(' .. (i + 1) .. ')} '
  endfor
  let s ..= '%#TabLineFill#%T'
  if tabpagenr('$') > 1
    let s ..= "%=%#TabLine#[%{tabpagenr('$')}]"
  endif
  return s
endfu
