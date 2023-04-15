local M = {}

local f = vim.fn
local c = vim.cmd
local o = vim.opt

local is_copened = function()
  for i = 1, f['winnr']('$') do
    local bnum = f['winbufnr'](i)
    if f['getbufvar'](bnum, '&buftype') == 'quickfix' then
      return 1
    end
  end
  return nil
end

function M.toggle()
  if is_copened() then
    if o.ft:get() == 'qf' then
      c 'wincmd p'
    end
    c 'ccl'
  else
    c 'copen'
  end
end

local sta, nvim_bqf = pcall(c, 'packadd nvim-bqf')
if not sta then
  print('no nvim-bqf')
  return
end

local sta, bqf = pcall(require, "bqf")
if sta then
  bqf.setup({
    auto_resize_height = true,
    preview = {
      win_height = 28,
      win_vheight = 28,
      wrap = true,
    },
  })
end

return M
