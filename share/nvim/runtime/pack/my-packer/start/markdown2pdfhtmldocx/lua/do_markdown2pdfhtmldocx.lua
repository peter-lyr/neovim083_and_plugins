local M = {}

local g = vim.g
local c = vim.cmd
local a = vim.api

local Path = require("plenary.path")

local p6 = Path:new(g.markdown2pdfhtmldocx_lua)
g.markdown2pdfhtmldocx_dir = p6:parent():parent()['filename']
local p6 = Path:new(g.markdown2pdfhtmldocx_dir)

g.markdown2pdfhtmldocx_py = p6:joinpath('autoload', 'main.py')['filename']

do_terminal = nil
sta, do_terminal = pcall(require, 'do_terminal')
if not sta then
  print('no do_terminal')
end

function M.do_markdown2pdfhtmldocx(cmd)
  print(cmd)
  if cmd == 'create' then
    if do_terminal then
      do_terminal.send_cmd('cmd', 'python ' .. g.markdown2pdfhtmldocx_py .. ' ' .. a['nvim_buf_get_name'](0))
    end
  elseif cmd == 'delete' then
    print('delete')
  end
end

return M
