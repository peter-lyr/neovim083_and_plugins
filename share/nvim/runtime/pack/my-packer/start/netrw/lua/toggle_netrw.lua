local M = {}

local f = vim.fn
local c = vim.cmd
local o = vim.opt
local a = vim.api

M.split = 'down'
M.step = 1

function M._show_array(arr)
  for i, v in ipairs(arr) do
    print(i, ':', v)
  end
end

-- Return the first index with the given value (or nil if not found).
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

function M.get_netrw_winids()
  local netrw_winids = {}
  for i = 1, f['winnr']('$') do
    local bufnr = f['winbufnr'](i)
    if f['getbufvar'](bufnr, '&filetype') == 'netrw' then
      table.insert(netrw_winids, f['win_getid'](i))
    end
  end
  if #netrw_winids > 0 then
    return netrw_winids
  end
  return nil
end

local is_winfix = function()
  if o.winfixheight:get() or o.winfixwidth:get() then
    return 1
  end
  return nil
end

M.netrw_winids_fix = {}
M.netrw_winids_unfix = {}

function M.update_netrw_winids_fix(netrw_winids)
  M.netrw_winids_fix = {}
  M.netrw_winids_unfix = {}
  local cur_winid = f['win_getid']()
  for _, v in ipairs(netrw_winids) do
    f['win_gotoid'](v)
    if is_winfix() then
      table.insert(M.netrw_winids_fix, v)
    else
      table.insert(M.netrw_winids_unfix, v)
    end
  end
  f['win_gotoid'](cur_winid)
end

local Path = require "plenary.path"

function M.get_dname()
  local fname = string.gsub(a['nvim_buf_get_name'](0), "\\", '/')
  local path = Path:new(fname)
  if path:is_file() then
    return path:parent()
  end
  return ''
end

function M.get_fname_tail()
  local fname = string.gsub(a['nvim_buf_get_name'](0), "\\", '/')
  local path = Path:new(fname)
  if path:is_file() then
    local fname = path:_split()
    return fname[#fname]
  end
  return ''
end

function M.toggle(mode)
  local fname = M.get_fname_tail()
  new_unfix = nil
  local netrw_winids = M.get_netrw_winids()
  if netrw_winids then
    M.update_netrw_winids_fix(netrw_winids)
    if #M.netrw_winids_unfix > 0 then
      if f['winnr']('$') > 1 then
        a.nvim_win_hide(M.netrw_winids_unfix[1])
      end
    else
      if mode == 'cur_fname' or mode == 'cwd' then
        new_unfix = 1
      else
        if #M.netrw_winids_fix > 0 then
          back_fix = nil
          local cur_winid = f['win_getid']()
          cur_winid_idx_fix = index_of(M.netrw_winids_fix, cur_winid)
          if cur_winid_idx_fix then
            if #M.netrw_winids_fix > 1 then
              cur_winid_idx_fix = cur_winid_idx_fix + 1
              if cur_winid_idx_fix > #M.netrw_winids_fix then
                back_fix = 1
              end
            else
              back_fix = 1
            end
          else
            cur_winid_idx_fix = 1
          end
          if back_fix then
            if o.winfixwidth:get() then
              a.nvim_win_set_width(0, 0)
            end
            if #M.netrw_winids_fix > 1 then
              local netrw_winids = {}
              for i = 1, f['winnr']('$') do
                local bufnr = f['winbufnr'](i)
                if f['getbufvar'](bufnr, '&filetype') ~= 'netrw' then
                  f['win_gotoid'](f['win_getid'](i))
                end
              end
            else
              local cur_winid = f['win_getid']()
              c'wincmd p'
              if cur_winid == f['win_getid']() then
                c'wincmd w'
              end
            end
          else
            for _, v in ipairs(M.netrw_winids_fix) do
              a.nvim_win_set_width(v, 0)
            end
            f['win_gotoid'](M.netrw_winids_fix[cur_winid_idx_fix])
            if o.winfixwidth:get() then
              if f['win_screenpos'](0)[1] > 2 then
                c'wincmd H'
              end
              M.netrw_fix_set_width()
              if fname ~= '' then
                f['search'](fname)
              end
            end
          end
        else
          new_unfix = 1
        end
      end
    end
  else
    new_unfix = 1
  end
  if new_unfix then
    if M.split == 'up' then
      c'leftabove split'
    elseif M.split == 'right' then
      c'rightbelow vsplit'
    elseif M.split == 'down' then
      c'rightbelow split'
    elseif M.split == 'left' then
      c'leftabove vsplit'
    end
    if mode == 'cur_fname' then
      c(string.format('Ntree %s', M.get_dname()))
      if fname ~= '' then
        f['search'](fname)
      end
    elseif mode == 'cwd' then
      c(string.format('Ntree %s', f['getcwd']()))
    else
      c'Ntree'
    end
  end
end

function M.netrw_fix_set_width()
  res = 0
  for i=1, f['line']('$') do
    local line = f['getline'](i)
    if string.sub(line, 1, 1) ~= '"' then
      local width = f['strwidth'](line)
      if width >= res then
        res = width
      end
    end
  end
  res = math.max(res + 7, 24)
  a['nvim_win_set_width'](0, res)
end

function M.fix_unfix(mode)
  local fname = M.get_fname_tail()
  local netrw_winids = M.get_netrw_winids()
  if not netrw_winids then
    M.toggle(mode)
  end
  local netrw_winids = M.get_netrw_winids()
  local cur_winid = f['win_getid']()
  cur_winid_idx = index_of(netrw_winids, cur_winid)
  if not cur_winid_idx then
    f['win_gotoid'](netrw_winids[1])
  end
  if is_winfix() then
    M.netrw_fix_set_width()
    o.winfixwidth = false
    o.winfixheight = false
    c('ec "netrw not fixed"')
  else
    o.winfixwidth = true
    c'wincmd H'
    M.netrw_fix_set_width()
    c('ec "netrw fixed"')
  end
end

return M
