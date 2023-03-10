local sta, netrw = pcall(require, 'netrw')
if not sta then
  print('no netrw')
  return
end

local f = vim.fn
local c = vim.cmd
local o = vim.opt
local a = vim.api

local get_dname = function(payload)
  f['netrw#Call']("NetrwBrowseChgDir", 1, f['netrw#Call']("NetrwGetWord"), 1)
  if payload['type'] == 0 then
    return f['netrw#Call']("NetrwBrowseChgDir", 1, f['netrw#Call']("NetrwGetWord"), 1)
  end
  return ''
end

local get_fname = function(payload)
  f['netrw#Call']("NetrwBrowseChgDir", 1, f['netrw#Call']("NetrwGetWord"), 1)
  if payload['type'] == 1 then
    return f['netrw#Call']("NetrwBrowseChgDir", 1, f['netrw#Call']("NetrwGetWord"), 1)
  end
  return ''
end

local Path = require "plenary.path"

local get_fname_tail = function(fname)
  local fname = string.gsub(fname, "\\", '/')
  local path = Path:new(fname)
  if path:is_file() then
    local fname = path:_split()
    return fname[#fname]
  elseif path:is_dir() then
    local fname = path:_split()
    if #fname[#fname] > 0 then
      return fname[#fname]
    else
      return fname[#fname-1]
    end
  end
  return ''
end

local get_dtarget = function(payload)
  local dname = get_dname(payload)
  if #dname > 0 then
    local dname = string.gsub(dname, '\\', '/')
    return dname
  end
  local fname = get_fname(payload)
  local fname = string.gsub(fname, '\\', '/')
  local path = Path:new(fname)
  if path:is_file() then
    local fname = path:parent()['filename']
    local fname = string.gsub(fname, '\\', '/')
    return fname .. '/'
  end
  return ''
end

local test = function(payload)
  -- - dir: the current netrw directory (vim.b.netrw_curdir)
  -- - node: the name of the file or directory under the cursor
  -- - link: the referenced file if the node under the cursor is a symlink
  -- - extension: the file extension if the node under the cursor is a file
  -- - type: the type of node under the cursor (0 = dir, 1 = file, 2 = symlink)
  -- print(vim.inspect(payload))
  print('fname:', get_fname(payload))
  print('dname:', get_dname(payload))
  print('dtarg:', get_dtarget(payload))
end

-- local list_style = function()
--   f['netrw#Call']("NetrwListStyle", 1)
-- end

local preview = function(payload)
  if not payload or vim.b.netrw_liststyle == 2 then
    return nil
  end
  if o.ft:get() ~= 'netrw' then
    return nil
  end
  if payload['type'] == 1 then
    local fname = get_fname(payload)
    if f['filereadable'](fname) then
      f['netrw#Call']("NetrwPreview", fname)
      return 1
    end
  else
    c[[ call feedkeys("\<cr>") ]]
  end
  return nil
end

local preview_go = function(payload)
  if preview(payload) then
    c[[ wincmd p ]]
  end
end

local is_winfixwidth = function(payload)
  if o.winfixwidth:get() then
    return 1
  end
  return nil
end

local toggle_netrw = require('toggle_netrw')

local open = function(payload, direction)
  if payload['type'] == 0 then
    c[[ call feedkeys("\<cr>") ]]
    return
  end
  local fname = get_fname(payload)
  if direction == 'tab' then
    c[[ tabnew ]]
  else
    if is_winfixwidth() then
      local cur_winid = f['win_getid']()
      if f['winnr']('$') == 1 then
        c[[ wincmd n ]]
      else
        c[[ wincmd p ]]
        local netrw_winids = toggle_netrw.get_netrw_winids()
        toggle_netrw.update_netrw_winids_fix(netrw_winids)
        cur_winid_idx_fix = index_of(toggle_netrw.netrw_winids_fix, cur_winid)
        if cur_winid_idx_fix then
          for i = 1, f['winnr']('$') do
            cur_winid_idx_fix = index_of(toggle_netrw.netrw_winids_fix, f['win_getid'](i))
            if not cur_winid_idx_fix then
              f['win_gotoid'](f['win_getid'](i))
              break
            end
          end
        end
      end
      a.nvim_win_set_width(cur_winid, 0)
    end
    if direction == 'up' then
      c[[ leftabove new ]]
    elseif direction == 'down' then
      c[[ new ]]
    elseif direction == 'left' then
      c[[ leftabove vnew ]]
    elseif direction == 'right' then
      c[[ vnew ]]
    end
  end
  c(string.format("e %s", fname))
end

local updir = function()
  c[[ call feedkeys("-") ]]
end

local copy_fname = function(payload)
  if payload['type'] == 0 then
    local dname = get_fname_tail(get_dname(payload))
    c(string.format([[let @+ = "%s"]], dname))
    print(dname)
  else
    local fname = get_fname_tail(get_fname(payload))
    c(string.format([[let @+ = "%s"]], fname))
    print(fname)
  end
end

local copy_fname_full = function(payload)
  if payload['type'] == 0 then
    local dname = get_dname(payload)
    c(string.format([[let @+ = "%s"]], dname))
    print(dname)
  else
    local fname = get_fname(payload)
    c(string.format([[let @+ = "%s"]], fname))
    print(fname)
  end
end

local toggle_dir = function(payload)
  if not payload or vim.b.netrw_liststyle == 2 then
    return nil
  end
  if o.ft:get() ~= 'netrw' then
    return nil
  end
  if payload['type'] == 0 then
    c[[ call feedkeys("\<cr>") ]]
  end
end

local preview_file = function(payload)
  if not payload or vim.b.netrw_liststyle == 2 then
    return nil
  end
  if o.ft:get() ~= 'netrw' then
    return nil
  end
  local fname = get_fname(payload)
  if payload['type'] == 1 then
    if f['filereadable'](fname) then
      f['netrw#Call']("NetrwPreview", fname)
      return 1
    end
  end
end

local chg_dir = function(payload)
  c(string.format("cd %s", get_dtarget(payload)))
  print(f['getcwd']())
end

local explorer = function(payload)
  f['system'](string.format("cd %s && start .", get_dtarget(payload)))
end

local system_start = function(payload)
  if payload['type'] == 1 then
    f['system'](string.format([[start /b /min cmd /c "%s"]], get_fname(payload)))
  else
    f['system'](string.format("start %s", get_dname(payload)))
  end
end

netrw.setup{
  use_devicons = true,
  mappings = {
    ['(f1)'] = function(payload) test(payload) end,
    ['(tab)'] = function(payload) preview(payload) end,
    ['(leftmouse)'] = function(payload) toggle_dir(payload) end,
    ['(2-leftmouse)'] = function(payload) preview_file(payload) end,
    ['(s-tab)'] = function(payload) preview_go(payload) end,
    ['q'] = function(payload) updir() end,
    ['o'] = function(payload) open(payload, 'here') end,
    ['do'] = function(payload) open(payload, 'here') end,
    ['dk'] = function(payload) open(payload, 'up') end,
    ['dj'] = function(payload) open(payload, 'down') end,
    ['dh'] = function(payload) open(payload, 'left') end,
    ['dl'] = function(payload) open(payload, 'right') end,
    ['di'] = function(payload) open(payload, 'tab') end,
    ['y'] = function(payload) copy_fname(payload) end,
    ['gy'] = function(payload) copy_fname_full(payload) end,
    ['cd'] = function(payload) chg_dir(payload) end,
    ['X'] = function(payload) explorer(payload) end,
    ['x'] = function(payload) system_start(payload) end,
  },
}
