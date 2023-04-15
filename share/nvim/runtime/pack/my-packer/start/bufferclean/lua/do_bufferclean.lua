local M = {}

local a = vim.api
local f = vim.fn

function M.do_bufferclean()
  local cur_fname = a['nvim_buf_get_name'](0)
  local cur_fname = string.gsub(cur_fname, '\\', '/')
  local cur_wnr = f['bufwinnr'](f['bufnr']())
  local ids = {}
  for wnr=1, f['winnr']('$') do
    if wnr ~= cur_wnr then
      local bnr = f['winbufnr'](wnr)
      if f['getbufvar'](bnr, '&buftype') ~= 'nofile' then
        local fname = a['nvim_buf_get_name'](bnr)
        local fname = string.gsub(fname, '\\', '/')
        if cur_fname == fname then
          table.insert(ids, f['win_getid'](wnr))
        end
      end
    end
  end
  for k, v in ipairs(ids) do
    a['nvim_win_hide'](v)
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

function rep(path)
  local path, _ = string.gsub(path, '/', '\\')
  return path
end

function M.do_bufferclean_all()
  local cur_fname = rep(a['nvim_buf_get_name'](0))
  local cur_wnr = f['bufwinnr'](f['bufnr']())
  local ids = {}
  local nms = {}
  for wnr=1, f['winnr']('$') do
    local bnr = f['winbufnr'](wnr)
    if f['getbufvar'](bnr, '&buftype') ~= 'nofile' then
      local fname = rep(a['nvim_buf_get_name'](bnr))
      if wnr ~= cur_wnr then
        if index_of(nms, fname) or cur_fname == fname then
          table.insert(ids, f['win_getid'](wnr))
        end
      end
      if not index_of(nms, fname) then
        table.insert(nms, fname)
      end
    end
  end
  for k, v in ipairs(ids) do
    a['nvim_win_hide'](v)
  end
end

return M
