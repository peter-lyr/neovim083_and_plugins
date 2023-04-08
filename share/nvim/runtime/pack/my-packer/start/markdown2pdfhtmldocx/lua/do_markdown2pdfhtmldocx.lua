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

function index_of(arr, val)
  if not arr then
    return nil
  end
  for i, v in ipairs(arr) do
    if v == val then
      return i
    end
  end
  return nil
end

local filetypes = {
  'pdf',
  'html',
  'docx',
}

function scandir(directory)
  local files = {}
  for file in io.popen("dir \"" .. directory .. "\" /b"):lines() do
    local extension = file:gsub("^.*%.([^.]+)$", "%1")
    if index_of(filetypes, extension) then
      table.insert(files, file)
    end
  end
  return files
end

function get_dname(readablefile)
  if #readablefile == 0 then
    return ''
  end
  local fname = string.gsub(readablefile, "\\", '/')
  local path = Path:new(fname)
  if path:is_file() then
    return path:parent()['filename']
  end
  return ''
end

function M.do_markdown2pdfhtmldocx(cmd)
  if cmd == 'create' then
    if do_terminal then
      do_terminal.send_cmd('cmd', 'python ' .. g.markdown2pdfhtmldocx_py .. ' ' .. a['nvim_buf_get_name'](0))
    end
  elseif cmd == 'delete' then
    local curdir = get_dname(a['nvim_buf_get_name'](0))
    local curdir = string.gsub(curdir, '/', '\\')
    local files = scandir(curdir)
    local cnt = 0
    for i, v in ipairs(files) do
      cnt = cnt + 1
      local curfile = curdir .. '\\' .. v
      local curcmd = 'del "' .. curfile .. '"'
      os.execute(curcmd)
    end
    print('delete', cnt, 'file(s)')
  end
end

return M
