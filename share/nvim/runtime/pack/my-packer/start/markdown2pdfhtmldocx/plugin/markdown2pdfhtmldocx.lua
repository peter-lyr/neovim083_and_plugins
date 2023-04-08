local g = vim.g
local o = vim.opt
local c = vim.cmd
local s = vim.keymap.set

g.markdown2pdfhtmldocx_lua = vim.fn['expand']('<sfile>')

local markdown2pdfhtmldocx_exe = function(cmd)
  if not g.loaded_do_markdown2pdfhtmldocx then
    g.loaded_do_markdown2pdfhtmldocx = 1
    do_markdown2pdfhtmldocx = nil
    sta, do_markdown2pdfhtmldocx = pcall(require, 'do_markdown2pdfhtmldocx')
    if not sta then
      print('no do_markdown2pdfhtmldocx')
      return
    end
  end
  if not do_markdown2pdfhtmldocx then
    return
  end
  if o.ft:get() == 'markdown' then
    do_markdown2pdfhtmldocx.do_markdown2pdfhtmldocx(cmd)
  end
end


s({'n', 'v'}, '\\1', function() markdown2pdfhtmldocx_exe("create") end, {silent = true})
s({'n', 'v'}, '\\2', function() markdown2pdfhtmldocx_exe("delete") end, {silent = true})
