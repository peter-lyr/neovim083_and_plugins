local M = {}

local g = vim.g
local f = vim.fn
local a = vim.api

local Path = require "plenary.path"
local path = Path:new(g.gitpush_lua)

g.gitpush_dir = path:parent():parent()['filename']
local path = Path:new(g.gitpush_dir)

M.add_commit = path:joinpath('autoload', 'add_commit.bat')['filename']
M.add_commit_push = path:joinpath('autoload', 'add_commit_push.bat')['filename']
M.commit_push = path:joinpath('autoload', 'commit_push.bat')['filename']
M.git_init = path:joinpath('autoload', 'git_init.bat')['filename']
M.just_commit = path:joinpath('autoload', 'just_commit.bat')['filename']
M.just_push = path:joinpath('autoload', 'just_push.bat')['filename']

function M.do_gitpush(cmd)
  if cmd == "add_commit" then
    cc = M.add_commit
  elseif cmd == "add_commit_push" then
    cc = M.add_commit_push
  elseif cmd == "commit_push" then
    cc = M.commit_push
  elseif cmd == "git_init" then
    cc = M.git_init
  elseif cmd == "just_commit" then
    cc = M.just_commit
  elseif cmd == "just_push" then
    cc = M.just_push
  end
  f['system'](string.format('cd %s && start cmd /c "%s"', Path:new(a['nvim_buf_get_name'](0)):parent()['filename'], cc))
end

return M
