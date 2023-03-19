local s = vim.keymap.set
local g = vim.g

local buffernew_exe = function(cmd)
  if not g.loaded_do_buffernew then
    g.loaded_do_buffernew = 1
    sta, do_buffernew = pcall(require, 'do_buffernew')
    if not sta then
      print('no do_buffernew')
      return
    end
  end
  if cmd == 'copy_fpath' then
    do_buffernew.copy_fpath()
  else
    do_buffernew.open(cmd)
  end
end

s({'n', 'v'}, '<leader>ba', '<c-w>s', {silent = true})
s({'n', 'v'}, '<leader>bb', '<cmd>:new<cr>', {silent = true})
s({'n', 'v'}, '<leader>bc', '<c-w>v', {silent = true})
s({'n', 'v'}, '<leader>bd', '<cmd>:vnew<cr>', {silent = true})
s({'n', 'v'}, '<leader>be', '<c-w>s<c-w>t', {silent = true})
s({'n', 'v'}, '<leader>bf', '<cmd>:tabnew<cr>', {silent = true})
s({'n', 'v'}, '<leader>bg', function() buffernew_exe('copy_fpath') end, {silent = true})
s({'n', 'v'}, '<leader>bi', function() buffernew_exe('here') end, {silent = true})
s({'n', 'v'}, '<leader>bk', function() buffernew_exe('up') end, {silent = true})
s({'n', 'v'}, '<leader>bj', function() buffernew_exe('down') end, {silent = true})
s({'n', 'v'}, '<leader>bh', function() buffernew_exe('left') end, {silent = true})
s({'n', 'v'}, '<leader>bl', function() buffernew_exe('right') end, {silent = true})
