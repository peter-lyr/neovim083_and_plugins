local sta, _ = pcall(vim.cmd, 'colorscheme sierra')
if not sta then
  return
end
