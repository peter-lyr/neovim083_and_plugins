local M = {}

local Path = require("plenary.path")

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
    print(i, ':', v)
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

function find_cbp()
  local fname = a['nvim_buf_get_name'](0)
  local cbp_path = Path:new(fname)
  if string.match(fname, '%.(%w+)$') == 'cbp' then
    return {fname}
  end
  -- local dirPath = a['nvim_buf_get_name'](0)
  -- while string.gmatch(dirPath, '\\') do
  --   local dirPath = parentDir(dirPath)
  --   local subDir = printf('%s\%s', dirPath, 'app')
  --   if isdirectory(subDir) then
  --     return search_cbp(subDir)
  --   end
  --   local dirName = split(dirPath, '\\')[-1]
  --   if 'app' == dirName then
  --     return search_cbp(dirPath)
  --   end
  --   if 'libs' == dirName then
  --     return search_cbp(ParentDir(dirPath) .. '\\app')
  --   end
  -- end
  return {}
end

function M.do_sdkcbp(cmd)
  show_array(find_cbp())
end

return M
