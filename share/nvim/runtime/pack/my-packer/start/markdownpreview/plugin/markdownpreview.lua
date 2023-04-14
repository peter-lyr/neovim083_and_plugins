local g = vim.g
local a = vim.api
local c = vim.cmd
local s = vim.keymap.set

g.markdownpreview_lua = vim.fn['expand']('<sfile>')

local markdownpreview_exe = function(cmd)
  if not g.loaded_do_markdownpreview then
    g.loaded_do_markdownpreview = 1
    do_markdownpreview = nil
    sta, do_markdownpreview = pcall(require, 'do_markdownpreview')
    if not sta then
      print('no do_markdownpreview')
      return
    end
  end
  if not do_markdownpreview then
    return
  end
  do_markdownpreview.do_markdownpreview(cmd)
end

a.nvim_create_user_command('MPreview', function(params)
  markdownpreview_exe(unpack(params['fargs']))
end, { nargs = "*", })

s({'n', 'v'}, '<f3>', ":MPreview MarkdownPreviewToggle<cr>", {silent = true})


g.mkdp_theme = 'light'
g.mkdp_auto_close = 0
