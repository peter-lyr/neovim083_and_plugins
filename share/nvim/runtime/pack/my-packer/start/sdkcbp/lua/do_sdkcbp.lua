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
M.no_projectroot = false

local Path = require("plenary.path")
local Scan = require("plenary.scandir")

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
        table.insert(M.cbp_files, entry_path_name)
      end
    end
  end
end

function M.find_cbp()
  local fname = a['nvim_buf_get_name'](0)
  local path = Path:new(fname)
  if not path:exists() then
    return {}
  end
  if path:is_file() then
    if string.match(fname, '%.([^%.]+)$') == 'cbp' then
      return {fname}
    else
      dname = path:parent()
    end
    local project = f['projectroot#get'](fname)
    if #project == 0 then
      print('no projectroot:', fname)
      M.no_projectroot = true
      return {}
    end
    dname = path
    M.searched_folders = {}
    M.cbp_files = {}
    M.no_projectroot = false
    local project = string.gsub(project, '\\', '/')
    local cnt = 100000
    while 1 do
      local app = dname:joinpath('app')
      if app:is_dir() then
        M.traverse_folder(project, dname['filename'])
      end
      if project == string.gsub(dname.filename, '\\', '/') then
        break
      end
      dname = dname:parent()
      if #dname.filename > cnt then
        break
      end
      cnt = #dname.filename
    end
  end
  return M.cbp_files
end

function M.do_sdkcbp(cmd)
  M.find_cbp()
  if M.no_projectroot then
    return
  end
  if #M.cbp_files == 0 then
  elseif #M.cbp_files == 1 then
  end
end

return M
