fun! test#Decho(msgs)
  let msgs = []
  for msg in a:msgs
    let msgs += [string(msg)]
    echomsg string(msg)
  endfor
  call writefile([join(msgs, ' ')], 'C:\Users\llydr\Desktop\mm.txt', 'a')
endfu

call Decho([234, 'asdf', 872347823])
