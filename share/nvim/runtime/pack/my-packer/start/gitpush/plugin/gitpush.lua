local g = vim.g
local a = vim.api
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

a.nvim_create_user_command('GitPush', function(params)
  gitpush_exe(unpack(params['fargs']))
end, { nargs = "*", })

s({ 'n', 'v' }, '<leader>g1', ":GitPush add_commit_push<cr>", { silent = true })
s({ 'n', 'v' }, '<leader>g2', ":GitPush commit_push<cr>", { silent = true })
s({ 'n', 'v' }, '<leader>g3', ":GitPush just_push<cr>", { silent = true })
s({ 'n', 'v' }, '<leader>g4', ":GitPush add_commit<cr>", { silent = true })
s({ 'n', 'v' }, '<leader>g5', ":GitPush just_commit<cr>", { silent = true })
s({ 'n', 'v' }, '<leader>gI', ":GitPush git_init<cr>", { silent = true })
s({ 'n', 'v' }, '<leader>g<f1>', ":!git log --all --graph --decorate --oneline && pause<cr>", { silent = true })
