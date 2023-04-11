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

function system_cd_string(absfolder)
  local path = Path:new(absfolder)
  if not path:exists() then
    return ''
  end
  if path:is_file() then
    return string.sub(absfolder, 1, 1) .. ': && cd ' .. absfolder
  end
  return string.sub(absfolder, 1, 1) .. ': && cd ' .. path:parent()['filename']
end

function M.do_tortoisesvn(cmd, root, yes)
  local path = (root == 'root') and f['projectroot#get'](a['nvim_buf_get_name'](0)) or a['nvim_buf_get_name'](0)
  if yes == 1 or index_of({'y', 'Y'}, f['trim'](f['input']("Sure to update? [Y/n]: ", 'Y'))) then
    f['execute'](string.format("silent !%s && start tortoiseproc.exe /command:%s /path:\"%s\"", system_cd_string(path), cmd, path))
  end
end

return M
