local M = {}

local g = vim.g
local f = vim.fn
local c = vim.cmd
local o = vim.opt
local a = vim.api

M.split = 'left'
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

local is_winfixwidth = function()
  if o.winfixwidth:get() then
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
    if is_winfixwidth() then
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

local open_netrw = function()
  if o.modified:get() == false and (a['nvim_buf_get_name'](0) == '' or (o.ft:get() == '' and f['filereadable'](a['nvim_buf_get_name'](0)) == false)) then
    return
  end
  if M.split == 'up' then
    c'leftabove split'
  elseif M.split == 'right' then
    c'rightbelow vsplit'
  elseif M.split == 'down' then
    c'rightbelow split'
  elseif M.split == 'left' then
    c'leftabove vsplit'
  end
end

local is_hide_en = function()
  local cnt = 0
  for i=1, f['winnr']('$') do
    if f['getbufvar'](f['winbufnr'](i), '&buftype') ~= 'nofile' then
      cnt = cnt + 1
    end
    if cnt > 1 then
      return true
    end
  end
  return false
end

g.netrw_alt_fname = ''

function M.toggle(mode)
  if o.diff:get() then
    return
  end
  if o.ft:get() ~= 'netrw' then
    g.netrw_back_winid = f['win_getid']()
  end
  local fname = M.get_fname_tail()
  if o.ft:get() ~= 'netrw' then
    g.netrw_alt_fname = fname
  end
  new_unfix = nil
  local netrw_winids = M.get_netrw_winids()
  if netrw_winids then
    M.update_netrw_winids_fix(netrw_winids)
    if #M.netrw_winids_unfix > 0 then
      if is_hide_en() then
        a.nvim_win_hide(M.netrw_winids_unfix[1])
      else
        c'bd'
      end
    else
      if mode == 'cur_fname' or mode == 'cwd' then
        if not is_winfixwidth() then
          new_unfix = 1
        else
          c[[call feedkeys("\<space>l")]]
        end
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
              if f['win_gotoid'](g.netrw_back_winid) == 0 then
                print('23423j4j')
              end
            else
              local cur_winid = f['win_getid']()
              c'wincmd p'
              if cur_winid == f['win_getid']() then
                print('23423l23l32')
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
    local fullname = a['nvim_buf_get_name'](0)
    if mode == 'cur_fname' then
      local dname = M.get_dname()
      if fullname == '' or dname ~= '' then
        open_netrw()
        c(string.format('Explore %s', dname))
        if fname ~= '' then
          c(string.format([[call search(substitute("%s", '\.', '\\\.', 'g'))]], fname))
        end
      else
        local fname = string.gsub(fullname, "\\", '/')
        local path = Path:new(fname)
        local fname = path:_split()
        c(string.format([[ec "not exists: %s"]], fname[#fname]))
      end
    elseif mode == 'cwd' then
      open_netrw()
      c(string.format('Explore %s', f['getcwd']()))
    else
      open_netrw()
      c'Explore'
    end
    M.netrw_fix_set_width()
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
  res = math.max(res + 8, 30)
  a['nvim_win_set_width'](0, res)
end

function M.fix_unfix(mode)
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
  if is_winfixwidth() then
    M.netrw_fix_set_width()
    o.winfixwidth = false
    c('ec "netrw not fixed"')
  else
    o.winfixwidth = true
    c'wincmd H'
    M.netrw_fix_set_width()
    c('ec "netrw fixed"')
  end
end

return M
