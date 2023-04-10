local s = vim.keymap.set
local c = vim.cmd
local g = vim.g


local tortoisesvn_exe = function(cmd, root, yes)
  if not g.loaded_do_tortoisesvn then
    g.loaded_do_tortoisesvn = 1
    sta, do_tortoisesvn = pcall(require, 'do_tortoisesvn')
    if not sta then
      print('no do_tortoisesvn')
      return
    end
  end
  if not do_tortoisesvn then
    return
  end
  do_tortoisesvn.do_tortoisesvn(cmd, root, yes)
end

local opt = {silent = true}

s({'n', 'v'}, '<leader>vo', function() tortoisesvn_exe('settings', 'cur', 1) end, opt)

s({'n', 'v'}, '<leader>vd', function() tortoisesvn_exe('diff', 'cur', 1) end, opt)
s({'n', 'v'}, '<leader>vD', function() tortoisesvn_exe('diff', 'root', 1) end, opt)

s({'n', 'v'}, '<leader>vb', function() tortoisesvn_exe('blame', 'cur', 1) end, opt)

s({'n', 'v'}, '<leader>vw', function() tortoisesvn_exe('repobrowser', 'cur', 1) end, opt)
s({'n', 'v'}, '<leader>vW', function() tortoisesvn_exe('repobrowser', 'root', 1) end, opt)

s({'n', 'v'}, '<leader>vs', function() tortoisesvn_exe('repostatus', 'cur', 1) end, opt)
s({'n', 'v'}, '<leader>vS', function() tortoisesvn_exe('repostatus', 'root', 1) end, opt)

s({'n', 'v'}, '<leader>vr', function() tortoisesvn_exe('rename', 'cur', 1) end, opt)

s({'n', 'v'}, '<leader>vR', function() tortoisesvn_exe('remove', 'cur', 1) end, opt)

s({'n', 'v'}, '<leader>vv', function() tortoisesvn_exe('revert', 'cur', 1) end, opt)
s({'n', 'v'}, '<leader>vV', function() tortoisesvn_exe('revert', 'root', 1) end, opt)

s({'n', 'v'}, '<leader>va', function() tortoisesvn_exe('add', 'cur', 1) end, opt)
s({'n', 'v'}, '<leader>vA', function() tortoisesvn_exe('add', 'root', 1) end, opt)

s({'n', 'v'}, '<leader>vc', function() tortoisesvn_exe('commit', 'cur', 1) end, opt)
s({'n', 'v'}, '<leader>vC', function() tortoisesvn_exe('commit', 'root', 1) end, opt)

s({'n', 'v'}, '<leader>vu', function() tortoisesvn_exe('update', 'root', 0) end, opt)
s({'n', 'v'}, '<leader>vU', function() tortoisesvn_exe('update /rev', 'root', 1) end, opt)

s({'n', 'v'}, '<leader>vl', function() tortoisesvn_exe('log', 'cur', 1) end, opt)
s({'n', 'v'}, '<leader>vL', function() tortoisesvn_exe('log', 'root', 1) end, opt)

s({'n', 'v'}, '<leader>vk', function() tortoisesvn_exe('checkout', 'root', 1) end, opt)
