local M = {}
local a = vim.api
local o = vim.opt
local c = vim.cmd

local open_fpath = function()
  if M.split == 'up' then
    c'leftabove split'
  elseif M.split == 'right' then
    c'rightbelow vsplit'
  elseif M.split == 'down' then
    c'rightbelow split'
  elseif M.split == 'left' then
    c'leftabove vsplit'
  end
  c('e ' .. M.stack_fpath)
end

function M.open(mode)
  M.split = mode
  open_fpath()
end

function M.copy_fpath()
  M.stack_fpath = a['nvim_buf_get_name'](0)
  print(M.stack_fpath)
end

function M.copy_fpath_silent()
  local fname = a['nvim_buf_get_name'](0)
  if #fname > 0 then
    M.stack_fpath = fname
  end
end

return M
