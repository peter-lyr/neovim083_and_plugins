local g = vim.g
local a = vim.api
local s = vim.keymap.set

local quickfix_exe = function()
  if not g.loaded_do_quickfix then
    g.loaded_do_quickfix = 1
    do_quickfix = nil
    sta, do_quickfix = pcall(require, 'do_quickfix')
    if not sta then
      print('no do_quickfix')
      return
    end
  end
  if not do_quickfix then
    return
  end
  do_quickfix.toggle()
end

a.nvim_create_user_command('QuickFix', function(params)
  quickfix_exe()
end, { nargs = "*", })

s({ 'n', 'v' }, '<leader><leader>d', ':QuickFix toggle<cr>', { silent = true })
