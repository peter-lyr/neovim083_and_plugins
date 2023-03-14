local Path = require "plenary.path"
local path = Path:new(vim.fn['expand']('<sfile>'))

local g = vim.g
g.gitpush_dir = path:parent():parent()['filename']


local gitpush_exe = function(cmd)
  local sta, gitpush = pcall(require, 'gitpush')
  if not sta then
    print('no gitpush')
    return
  end
  if cmd == 'add_commit_push' then
    gitpush.add_commit_push()
  end
end


local s = vim.keymap.set


s({'n', 'v'}, '<leader>g1', function() gitpush_exe("add_commit_push") end, {silent = true})
