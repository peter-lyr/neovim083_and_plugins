local g = vim.g
local a = vim.api
local c = vim.cmd
local s = vim.keymap.set

g.markdownimage_lua = vim.fn['expand']('<sfile>')

local markdownimage_exe = function(params)
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
  do_markdownimage.getimage(params)
end

a.nvim_create_user_command('MarkdownImage', function(params)
  markdownimage_exe(params['fargs'])
end, { nargs = "*", })

s({ 'n', 'v' }, '\\<f3>', ':MarkdownImage sel_jpg append<cr>', { silent = true })
s({ 'n', 'v' }, '\\\\<f3>', ':MarkdownImage sel_png append<cr>', { silent = true })
s({ 'n', 'v' }, '<leader><f3>', ':MarkdownImage sel_jpg no_append<cr>', { silent = true })
s({ 'n', 'v' }, '<leader><leader><f3>', ':MarkdownImage sel_png no_append<cr>', { silent = true })
