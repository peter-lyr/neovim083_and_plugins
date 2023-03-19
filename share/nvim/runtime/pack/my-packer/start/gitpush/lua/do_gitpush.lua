local M = {}

local g = vim.g
local f = vim.fn
local a = vim.api

local Path = require "plenary.path"
local path = Path:new(g.gitpush_lua)

g.gitpush_dir = path:parent():parent()['filename']

function M.add_commit_push()
  local bat = Path:new(g.gitpush_dir):joinpath('autoload', 'add_commit_push.bat')['filename']
  f['system'](string.format('cd %s && start cmd /c "%s"', Path:new(a['nvim_buf_get_name'](0)):parent()['filename'], bat))
end

return M
