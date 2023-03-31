fun! test#echo(msgs)
  let msgs = []
  for msg in a:msgs
    let msgs += [type(msg) == type('') ? msg : string(msg)]
  endfor
  call writefile([join(msgs, ' ')], 'C:\Users\llydr\Desktop\mm.txt', 'a')
endfu

call test#echo([234, 'asdf', 872347823])
