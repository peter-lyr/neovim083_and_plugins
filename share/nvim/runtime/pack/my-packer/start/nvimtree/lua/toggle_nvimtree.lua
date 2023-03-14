local M = {}

local f = vim.fn
local c = vim.cmd

function M.is_nvimtree_opened()
  for i = 1, f['winnr']('$') do
    local bufnr = f['winbufnr'](i)
    if f['getbufvar'](bufnr, '&filetype') == 'NvimTree' then
      return true
    end
  end
  return false
end

function M.toggle(mode)
  if M.is_nvimtree_opened() then
    c'NvimTreeClose'
    return
  end
  if mode == 'cwd' then
    c(string.format('NvimTreeOpen %s', f['getcwd']()))
  elseif mode == 'cur_fname' then
    c'NvimTreeFindFileToggle!'
  end
end

return M
