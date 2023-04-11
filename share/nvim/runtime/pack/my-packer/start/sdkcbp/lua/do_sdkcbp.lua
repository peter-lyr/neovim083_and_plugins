local M = {}

local Path = require("plenary.path")
local Scan = require("plenary.scandir")

local g = vim.g
local b = vim.b
local f = vim.fn
local c = vim.cmd
local o = vim.opt
local a = vim.api
local m = string.match
local s = vim.keymap.set

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
    -- print(i, ':', v)
  end
end

-- function search_cbp(dirPath)
--   cnt = 0
--   to_break = 0
--   for i, j, k in os.walk(dirPath) do
--     if to_break == 1 then
--       break
--     end
--     for f in k do
--       cnt += 1
--       if cnt >= 1000 then
--         to_break = 1
--         break
--       end
--       if f.split('.')[-1] == 'cbp' then
--         vim.command(f"let cbps += ['{os.path.join(i, f)}']")
--       end
--     end
--   end
--   return cbps
-- end

M.searched_folders = {}

function M.traverse_folder(abspath)
  local path = Path:new(abspath)
  local entries = Scan.scan_dir(path.filename, { hidden = false, depth = 1, add_dirs = true })
  for _, entry in ipairs(entries) do
    local entry_path = Path:new(entry)
    local entry_path_name = entry_path.filename
    if entry_path:is_file() then
      if string.match(entry_path_name, '%.([^%.]+)$') == 'cbp' then
        -- print(entry_path_name)
        break
      end
    else
      if not index_of(M.searched_folders, entry_path_name) then
        print(entry_path_name)
        table.insert(M.searched_folders, entry_path_name)
        M.traverse_folder(entry_path_name)
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
    dname = path
    M.searched_folders = {}
    local cnt = 0
    while 1 do
      M.traverse_folder(dname['filename'])
      dname = dname:parent()
      cnt = cnt + 1
      if cnt > 20 then
        break
      end
    end
  --   -- local fname = parentDir(fname)
  --   -- local subDir = printf('%s\%s', fname, 'app')
  --   -- if isdirectory(subDir) then
  --   --   return search_cbp(subDir)
  --   -- end
  --   -- local dirName = split(fname, '\\')[-1]
  --   -- if 'app' == dirName then
  --   --   return search_cbp(fname)
  --   -- end
  --   -- if 'libs' == dirName then
  --   --   return search_cbp(ParentDir(fname) .. '\\app')
  --   -- end
  end
  return {}
end

function M.do_sdkcbp(cmd)
  M.find_cbp()
end

return M
