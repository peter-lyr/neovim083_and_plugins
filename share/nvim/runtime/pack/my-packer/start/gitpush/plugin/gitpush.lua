local g = vim.g
local s = vim.keymap.set

g.gitpush_lua = vim.fn['expand']('<sfile>')

local gitpush_exe = function(cmd)
  if not g.loaded_do_gitpush then
    g.loaded_do_gitpush = 1
    do_gitpush = nil
    sta, do_gitpush = pcall(require, 'do_gitpush')
    if not sta then
      print('no do_gitpush')
      return
    end
  end
  if not do_gitpush then
    return
  end
  do_gitpush.do_gitpush(cmd)
end


s({'n', 'v'}, '<leader>g1', function() gitpush_exe("add_commit_push") end, {silent = true})
s({'n', 'v'}, '<leader>g2', function() gitpush_exe("commit_push") end, {silent = true})
s({'n', 'v'}, '<leader>g3', function() gitpush_exe("just_push") end, {silent = true})
s({'n', 'v'}, '<leader>g4', function() gitpush_exe("add_commit") end, {silent = true})
s({'n', 'v'}, '<leader>g5', function() gitpush_exe("just_commit") end, {silent = true})
s({'n', 'v'}, '<leader>gI', function() gitpush_exe("git_init") end, {silent = true})
s({'n', 'v'}, '<leader>g<f1>', function() os.execute('start cmd /c "git log --all --graph --decorate --oneline && pause"') end, {silent = true})
