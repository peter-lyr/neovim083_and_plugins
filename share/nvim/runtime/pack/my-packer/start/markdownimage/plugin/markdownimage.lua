local g = vim.g
local c = vim.cmd
local s = vim.keymap.set

g.markdownimage_lua = vim.fn['expand']('<sfile>')

local markdownimage_exe = function(cmd, arg1)
  if not g.loaded_do_markdownimage then
    g.loaded_do_markdownimage = 1
    do_markdownimage = nil
    sta, do_markdownimage = pcall(require, 'do_markdownimage')
    if not sta then
      print('no do_markdownimage')
      return
    end
  end
  if not do_markdownimage then
    return
  end
  if cmd == 'getimage' then
    do_markdownimage.getimage(arg1) -- 1:jpg, 0:png
  end
end


s({'n', 'v'}, '\\<f3>', function() markdownimage_exe('getimage', 1) end, {silent = true})
s({'n', 'v'}, '\\\\<f3>', function() markdownimage_exe('getimage', 0) end, {silent = true})
