local M = {}

local g = vim.g
local f = vim.fn
local c = vim.cmd
local o = vim.opt
local a = vim.api

local Path = require "plenary.path"
local path = Path:new(g.gitpush_lua)

g.gitpush_dir = path:parent():parent()['filename']

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
  c'DiffviewClose'
end

return M
