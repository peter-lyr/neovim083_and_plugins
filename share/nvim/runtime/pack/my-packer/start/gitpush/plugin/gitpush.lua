local g = vim.g
local s = vim.keymap.set

g.gitpush_lua = vim.fn['expand']('<sfile>')

local gitpush_exe = function(cmd)
  if not g.loaded_do_gitpush then
    g.loaded_do_gitpush = 1
    sta, do_gitpush = pcall(require, 'do_gitpush')
    if not sta then
      print('no do_gitpush')
      return
    end
  end
  if not do_gitpush then
    return
  end
  if cmd == 'add_commit_push' then
    do_gitpush.add_commit_push()
  end
end


s({'n', 'v'}, '<leader>g1', function() gitpush_exe("add_commit_push") end, {silent = true})
