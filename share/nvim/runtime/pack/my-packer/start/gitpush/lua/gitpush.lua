local M = {}

local g = vim.g
local f = vim.fn

local Path = require "plenary.path"

function M.add_commit_push()
  local bat = Path:new(g.gitpush_dir):joinpath('autoload', 'add_commit_push.bat')['filename']
  f['system'](string.format('cd %s && start cmd /c "%s"', g.gitpush_dir, bat))
end

return M
