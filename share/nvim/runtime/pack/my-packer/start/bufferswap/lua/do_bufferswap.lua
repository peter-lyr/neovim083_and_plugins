local M = {}

local f = vim.fn
local c = vim.cmd
local o = vim.opt
local a = vim.api

local Path = require "plenary.path"

function show_array(arr)
  for i, v in ipairs(arr) do
    print(i, ':', v)
  end
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

function M.do_bufferswap(cmd)
  fname = a['nvim_buf_get_name'](0)
  fname = string.gsub(fname, '\\', '/')
  if o.ft:get() == 'vim' then
    fnames = f['split'](fname, '/')
    if fnames[#fnames-1] == 'autoload' then
      fnames[#fnames-1] = 'plugin'
    elseif fnames[#fnames-1] == 'plugin' then
      fnames[#fnames-1] = 'autoload'
    else
      print('no autoload/ or plugin/')
      return
    end
    fname = f['join'](fnames, '/')
    local path = Path:new(fname)
    if path:exists() then
      c('e ' .. fname)
    else
      print('no exists ' .. fname)
    end
  elseif o.ft:get() == 'c' or o.ft:get() == 'cpp' then
    fnames = f['split'](fname, '\\.')
    if fnames[#fnames] == 'c' then
      fnames[#fnames] = 'h'
    else
      fnames[#fnames] = 'c'
    end
    fname = f['join'](fnames, '.')
    local path = Path:new(fname)
    if path:exists() then
      c('e ' .. fname)
    else
      print('no exists ' .. fname)
    end
  end
end

return M
