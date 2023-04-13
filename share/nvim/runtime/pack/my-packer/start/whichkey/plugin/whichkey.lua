local sta, whichkey = pcall(require, "which-key")
if not sta then
  print('no which-key')
  return
end

whichkey.setup({})
