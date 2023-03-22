local M = {}

local f = vim.fn
local c = vim.cmd
local o = vim.opt
local a = vim.api

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
  if o.ft:get() == 'vim' then
    fname = string.gsub(fname, '\\', '/')
    fnames = f['split'](fname, '/')
    if fnames[#fnames-1] == 'autoload' then
      fnames[#fnames-1] = 'plugin'
    else
      fnames[#fnames-1] = 'autoload'
    end
    fname = f['join'](fnames, '/')
    c('e ' .. fname)
  end
end

return M
