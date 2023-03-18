local g = vim.g
local c = vim.cmd
local a = vim.api

local tab_enter = function()
  a.nvim_del_autocmd(g.set_tabline)
  c([[set tabline=%!tabline#tabline()]])
end

g.set_tabline = a.nvim_create_autocmd({"TabEnter"}, {
  callback = tab_enter,
})
