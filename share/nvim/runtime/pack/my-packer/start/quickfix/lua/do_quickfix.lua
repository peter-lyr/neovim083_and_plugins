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

return M
