local g = vim.g
local c = vim.cmd
local a = vim.api
local f = vim.fn

local g = vim.g
local a = vim.api
local c = vim.cmd

if not g.statusline_loaded then
  g.statusline_loaded = 1
  g.statusline_cursormoved = a.nvim_create_autocmd({ "CursorMoved" }, {
    callback = function()
      a.nvim_del_autocmd(g.statusline_cursormoved)
      c [[
        call timer_start(10, 'statusline#timerUpdate',{'repeat':-1})
        autocmd WinEnter,BufEnter,VimResized * call statusline#watch()
        autocmd ColorScheme * call statusline#color()
      ]]
    end,
  })
end
