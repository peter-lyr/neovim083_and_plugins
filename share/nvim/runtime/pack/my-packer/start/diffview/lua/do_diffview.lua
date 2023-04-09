local M = {}

local g = vim.g
local f = vim.fn
local c = vim.cmd
local o = vim.opt
local a = vim.api

function M.filehistory()
  if o.modifiable:get() == false or o.diff:get() == true then
    return
  end
  c'DiffviewFileHistory'
end

function M.open()
  if o.modifiable:get() == false or o.diff:get() == true then
    c'DiffviewFocusFiles'
  else
    c'DiffviewOpen -u'
  end
end

function M.quit()
  local tabpagenr = f['tabpagenr']()
  local tabpagecnt = f['tabpagenr']('$')
  c'DiffviewClose'
  if tabpagenr > 1 and tabpagecnt > f['tabpagenr']('$') then
    c(string.format([[norm %dgt]], tabpagenr - 1))
  end
end

return M
