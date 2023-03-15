local g = vim.g
local s = vim.keymap.set


g.diffview_lua = vim.fn['expand']('<sfile>')


local diffview_exe = function(cmd)
  local sta, do_diffview = pcall(require, 'do_diffview')
  if not sta then
    print('no do_diffview')
    return
  end
  if cmd == 'filehistory' then
    do_diffview.filehistory()
  elseif cmd == 'open' then
    do_diffview.open()
  elseif cmd == 'quit' then
    do_diffview.quit()
  end
end


s({'n', 'v'}, '<leader>gi', function() diffview_exe("filehistory") end, {silent = true})
s({'n', 'v'}, '<leader>go', function() diffview_exe("open") end, {silent = true})
s({'n', 'v'}, '<leader>gq', function() diffview_exe("quit") end, {silent = true})
