fun! test#echo(msgs)
  let msgs = []
  for msg in a:msgs
    let msgs += [type(msg) == type('') ? msg : string(msg)]
  endfor
  call writefile([join(msgs, ' ')], 'C:\test.md', 'a')
endfu
