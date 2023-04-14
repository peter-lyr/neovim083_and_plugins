local s = vim.keymap.set
local g = vim.g
local a = vim.api

local buffernew_exe = function(cmd)
  if not g.loaded_do_buffernew then
    g.loaded_do_buffernew = 1
    sta, do_buffernew = pcall(require, 'do_buffernew')
    if not sta then
      print('no do_buffernew')
      return
    end
  end
  if not do_buffernew then
    return
  end
  if cmd == 'copy_fpath' then
    do_buffernew.copy_fpath()
  else
    do_buffernew.open(cmd)
  end
end

a.nvim_create_user_command('BufferNew', function(params)
  buffernew_exe(unpack(params['fargs']))
end, { nargs = "*", })

local opt = {silent = true}

s({'n', 'v'}, '<leader>ba', '<c-w>s', opt)
s({'n', 'v'}, '<leader>bb', '<cmd>:new<cr>', opt)
s({'n', 'v'}, '<leader>bc', '<c-w>v', opt)
s({'n', 'v'}, '<leader>bd', '<cmd>:vnew<cr>', opt)
s({'n', 'v'}, '<leader>be', '<c-w>s<c-w>t', opt)
s({'n', 'v'}, '<leader>bf', '<cmd>:tabnew<cr>', opt)

s({'n', 'v'}, '<leader>bg', ':BufferNew copy_fpath<cr>', opt)
s({'n', 'v'}, '<leader>bi', ':BufferNew here<cr>', opt)
s({'n', 'v'}, '<leader>bk', ':BufferNew up<cr>', opt)
s({'n', 'v'}, '<leader>bj', ':BufferNew down<cr>', opt)
s({'n', 'v'}, '<leader>bh', ':BufferNew left<cr>', opt)
s({'n', 'v'}, '<leader>bl', ':BufferNew right<cr>', opt)
