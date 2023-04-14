local s = vim.keymap.set
local a = vim.api
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

a.nvim_create_user_command('TortoiseSvn', function(params)
  tortoisesvn_exe(unpack(params['fargs']))
end, { nargs = "*", })

local opt = {silent = true}

s({'n', 'v'}, '<leader>vo', ':TortoiseSvn settings cur yes<cr>', opt)

s({'n', 'v'}, '<leader>vd', ':TortoiseSvn diff cur yes<cr>', opt)
s({'n', 'v'}, '<leader>vD', ':TortoiseSvn diff root yes<cr>', opt)

s({'n', 'v'}, '<leader>vb', ':TortoiseSvn blame cur yes<cr>', opt)

s({'n', 'v'}, '<leader>vw', ':TortoiseSvn repobrowser cur yes<cr>', opt)
s({'n', 'v'}, '<leader>vW', ':TortoiseSvn repobrowser root yes<cr>', opt)

s({'n', 'v'}, '<leader>vs', ':TortoiseSvn repostatus cur yes<cr>', opt)
s({'n', 'v'}, '<leader>vS', ':TortoiseSvn repostatus root yes<cr>', opt)

s({'n', 'v'}, '<leader>vr', ':TortoiseSvn rename cur yes<cr>', opt)

s({'n', 'v'}, '<leader>vR', ':TortoiseSvn remove cur yes<cr>', opt)

s({'n', 'v'}, '<leader>vv', ':TortoiseSvn revert cur yes<cr>', opt)
s({'n', 'v'}, '<leader>vV', ':TortoiseSvn revert root yes<cr>', opt)

s({'n', 'v'}, '<leader>va', ':TortoiseSvn add cur yes<cr>', opt)
s({'n', 'v'}, '<leader>vA', ':TortoiseSvn add root yes<cr>', opt)

s({'n', 'v'}, '<leader>vc', ':TortoiseSvn commit cur yes<cr>', opt)
s({'n', 'v'}, '<leader>vC', ':TortoiseSvn commit root yes<cr>', opt)

s({'n', 'v'}, '<leader>vu', ':TortoiseSvn update root no<cr>', opt)
s({'n', 'v'}, '<leader>vU', ':TortoiseSvn update /rev root yes<cr>', opt)

s({'n', 'v'}, '<leader>vl', ':TortoiseSvn log cur yes<cr>', opt)
s({'n', 'v'}, '<leader>vL', ':TortoiseSvn log root yes<cr>', opt)

s({'n', 'v'}, '<leader>vk', ':TortoiseSvn checkout root yes<cr>', opt)
