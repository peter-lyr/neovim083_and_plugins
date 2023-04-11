local M = {}

local g = vim.g
local b = vim.b
local f = vim.fn
local c = vim.cmd
local o = vim.opt
local a = vim.api
local m = string.match
local s = vim.keymap.set

M.searched_folders = {}
M.cbp_files = {}

local Path = require("plenary.path")
local Scan = require("plenary.scandir")

local sdkcbp_dir = Path:new(g.sdkcbp_lua):parent():parent()['filename']
g.cmake_app_py = Path:new(sdkcbp_dir):joinpath('autoload', 'cmake_app.py')['filename']

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

function show_array(arr)
  for i, v in ipairs(arr) do
    print(i, ':', v)
  end
end

function M.traverse_folder(project, abspath)
  local path = Path:new(abspath)
  local entries = Scan.scan_dir(path.filename, { hidden = false, depth = 1, add_dirs = true })
  for _, entry in ipairs(entries) do
    local entry_path = Path:new(entry)
    local entry_path_name = entry_path.filename
    if entry_path:is_dir() then
      if not index_of(M.searched_folders, entry_path_name) then
        table.insert(M.searched_folders, entry_path_name)
        if string.find(string.gsub(entry_path_name, '\\', '/'), project) then
          M.traverse_folder(project, entry_path_name)
        end
      end
    else
      if string.match(entry_path_name, '%.([^%.]+)$') == 'cbp' then
        entry_path_name = string.gsub(entry_path_name, '\\', '/')
        table.insert(M.cbp_files, entry_path_name)
      end
    end
  end
end

function M.find_cbp(dtarget)
  local fname = a['nvim_buf_get_name'](0)
  local path = Path:new(fname)
  if not path:exists() then
    return
  end
  if path:is_file() then
    if string.match(fname, '%.([^%.]+)$') == 'cbp' then
      fname = string.gsub(fname, '\\', '/')
      table.insert(M.cbp_files, fname)
      return
    else
      dname = path:parent()
    end
    dname = path
    local cnt = 100000
    while 1 do
      local app = dname:joinpath(dtarget)
      if app:is_dir() then
        M.traverse_folder(M.project, dname['filename'])
      end
      if M.project == string.gsub(dname.filename, '\\', '/') then
        break
      end
      dname = dname:parent()
      if #dname.filename > cnt then
        break
      end
      cnt = #dname.filename
    end
  end
end

function M.cmake_app()
  local app_cbp = M.cbp_files[1]
  if string.match(app_cbp, 'app/projects') then
    c(string.format([[AsyncRun chcp 65001 && python "%s" "%s" %s]], g.cmake_app_py, M.project, 'app'))
  end
end

function M.do_sdkcbp(cmd)
  local fname = a['nvim_buf_get_name'](0)
  M.project = f['projectroot#get'](fname)
  M.project = string.gsub(M.project, '\\', '/')
  if #M.project == 0 then
    print('no projectroot:', fname)
  end
  M.cbp_files = {}
  M.searched_folders = {}
  M.find_cbp('app')
  if #M.cbp_files == 0 then
    M.find_cbp('boot')
    if #M.cbp_files == 0 then
      M.find_cbp('spiloader')
      if #M.cbp_files == 0 then
        M.find_cbp('masklib')
      elseif #M.cbp_files == 1 then
      else
      end
    elseif #M.cbp_files == 1 then
    else
    end
  elseif #M.cbp_files == 1 then
    M.cmake_app()
  else
  end
end

return M
