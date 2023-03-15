local M = {}

local g = vim.g
local f = vim.fn

local Path = require "plenary.path"
local path = Path:new(g.gitpush_lua)

g.gitpush_dir = path:parent():parent()['filename']

function M.xxx()
  print('22222cccccf')
end

return M
