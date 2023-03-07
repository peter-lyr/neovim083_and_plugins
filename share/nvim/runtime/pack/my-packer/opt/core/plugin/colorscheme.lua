local status, _ = pcall(vim.cmd, 'colorscheme sierra')
if not status then
  return
end
