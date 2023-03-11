local M = {}

local f = vim.fn
local c = vim.cmd

M.split = 'up'
M.step = 1

function M._show_array(arr)
  for i, v in ipairs(arr) do
    print(i, ':', v)
  end
end

-- Return the first index with the given value (or nil if not found).
function index_of(arr, val)
  for i, v in ipairs(arr) do
    if v == val then
      return i
    end
  end
  return nil
end

function M.get_netrw_winids()
  local netrw_winids = {}
  for i = 1, f['winnr']('$') do
    local bufnr = f['winbufnr'](i)
    if f['getbufvar'](bufnr, '&filetype') == 'netrw' then
      table.insert(netrw_winids, f['win_getid'](f['bufwinnr'](bufnr)))
    end
  end
  if #netrw_winids > 0 then
    return netrw_winids
  end
  return nil
end

function M.toggle_only()
  local netrw_winids = M.get_netrw_winids()
  if netrw_winids then
    local cur_winid = f['win_getid'](f['winnr']())
    local cur_winid_idx = index_of(netrw_winids, cur_winid)
    if cur_winid_idx then
    else
    end
    -- M._show_array(netrw_winids)
  else
    if M.split == 'up' then
      c'leftabove split'
    elseif M.split == 'right' then
      c'rightbelow vsplit'
    elseif M.split == 'down' then
      c'rightbelow split'
    elseif M.split == 'left' then
      c'leftabove vsplit'
    end
    c'Ntree'
  end
end

function M.toggle_search_fname()
end

function M.toggle_search_cwd()
end

return M
