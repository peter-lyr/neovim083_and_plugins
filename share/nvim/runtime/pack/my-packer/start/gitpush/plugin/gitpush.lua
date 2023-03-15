local g = vim.g
local s = vim.keymap.set


g.gitpush_lua = vim.fn['expand']('<sfile>')


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


s({'n', 'v'}, '<leader>g1', function() gitpush_exe("add_commit_push") end, {silent = true})
