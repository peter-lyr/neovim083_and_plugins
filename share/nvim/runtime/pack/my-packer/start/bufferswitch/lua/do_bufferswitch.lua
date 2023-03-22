local M = {}

local f = vim.fn
local c = vim.cmd
local a = vim.api
local o = vim.opt

local get_untitled_bufnrs = function()
  local untitled_bufnrs = {}
  for k, v in pairs(a['nvim_list_bufs']()) do
    if a['nvim_buf_get_name'](v) == '' and f['getbufvar'](v, '&buftype') ~= 'nofile' then
      table.insert(untitled_bufnrs, v)
    end
  end
  if #untitled_bufnrs == 0 then
    return nil
  end
  return untitled_bufnrs
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

function M.do_bufferswitch(cmd)
  local fname = a['nvim_buf_get_name'](0)
  local bnr = f['bufnr']()
  local untitled_bufnrs = get_untitled_bufnrs()
  if not untitled_bufnrs then
    c'ec "no untitled(exclude scratch)"'
    return
  end
  local fname = a['nvim_buf_get_name'](0)
  local bnr_idx = 1
  if #fname == 0 then
    bnr_idx = index_of(untitled_bufnrs, bnr)
    bnr_idx = bnr_idx + 1
    if bnr_idx > #untitled_bufnrs then
      if f['winnr']('$') > 1 then
        c'hide'
        return
      else
        bnr_idx = 1
      end
    end
  else
    for i=1, f['winnr']('$') do
      local fname = a['nvim_buf_get_name'](f['winbufnr'](i))
      if #fname == 0 then
        f['win_gotoid'](f['win_getid'](i))
        return
      end
    end
    c'split'
  end
  c(string.format('b%d', untitled_bufnrs[bnr_idx]))
end

return M
