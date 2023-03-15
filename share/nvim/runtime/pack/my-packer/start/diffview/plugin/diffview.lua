local g = vim.g
local s = vim.keymap.set


g.diffview_lua = vim.fn['expand']('<sfile>')


local diffview_exe = function(cmd)
  local sta, do_diffview = pcall(require, 'do_diffview')
  if not sta then
    print('no do_diffview')
    return
  end
  if cmd == 'xxx' then
    do_diffview.xxx()
  end
end


s({'n', 'v'}, '<leader>gi', function() diffview_exe("xxx") end, {silent = true})
