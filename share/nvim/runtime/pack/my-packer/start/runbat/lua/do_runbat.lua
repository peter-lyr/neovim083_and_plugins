local g = vim.g
local a = vim.api
local f = vim.fn
local c = vim.cmd
local s = vim.keymap.set

local M = {}

local Path = require("plenary.path")

local runbat_path = Path:new(g.runbat_lua):parent():parent()
local proxy_on_bat_path = runbat_path:joinpath('autoload', 'proxy_on.bat')
local proxy_off_bat_path = runbat_path:joinpath('autoload', 'proxy_off.bat')
local path_bat_path = runbat_path:joinpath('autoload', 'path.bat')

M.run = function(params)

  if not params or #params == 0 then
    return
  end

  if params[1] == 'sel' then
  elseif params[1] == 'proxy_on' then
    c('silent !start cmd /c ' .. proxy_on_bat_path.filename)
  elseif params[1] == 'proxy_off' then
    c('silent !start cmd /c ' .. proxy_off_bat_path.filename)
  elseif params[1] == 'path' then
    c('silent !start cmd /c ' .. path_bat_path.filename)
  end

end

return M
