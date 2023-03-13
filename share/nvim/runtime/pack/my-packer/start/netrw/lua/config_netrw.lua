local sta, netrw = pcall(require, 'netrw')
if not sta then
  print('no netrw')
  return
end

local f = vim.fn
local c = vim.cmd
local o = vim.opt

local test = function(payload)
  -- - dir: the current netrw directory (vim.b.netrw_curdir)
  -- - node: the name of the file or directory under the cursor
  -- - link: the referenced file if the node under the cursor is a symlink
  -- - extension: the file extension if the node under the cursor is a file
  -- - type: the type of node under the cursor (0 = dir, 1 = file, 2 = symlink)
  print(vim.inspect(payload))
end

-- local list_style = function()
--   f['netrw#Call']("NetrwListStyle", 1)
-- end

local is_up_dir = function()
  if string.sub(f['getline'](f['line']('.')), 1, 3) == '../' then
    return 1
  end
  return nil
end

local is_cur_dir = function(payload)
  if f['line']('.') > 1 and string.sub(f['getline'](f['line']('.')-1), 1, 3) == '../' then
    return 1
  end
  return nil
end

local get_fname = function(payload)
  if payload['type'] == 1 then
    return f['netrw#Call']("NetrwBrowseChgDir", 1, f['netrw#Call']("NetrwGetWord"), 1)
  end
  return ''
end

local preview = function(payload)
  if not payload or vim.b.netrw_liststyle == 2 then
    return nil
  end
  if o.ft:get() ~= 'netrw' then
    return nil
  end
  if is_cur_dir() then
    return nil
  end
  local fname = get_fname(payload)
  if payload['type'] == 1 then
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

local is_winfix = function(payload)
  if o.winfixheight:get() or o.winfixwidth:get() then
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
    if is_winfix() then
      if f['winnr']('$') == 1 then
        c[[ wincmd n ]]
      else
        local cur_winid = f['win_getid']()
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

netrw.setup{
  use_devicons = true,
  mappings = {
    ['(f1)'] = function(payload) test(payload) end,
    ['(tab)'] = function(payload) preview(payload) end,
    ['(leftmouse)'] = function(payload) preview(payload) end,
    ['(s-tab)'] = function(payload) preview_go(payload) end,
    ['q'] = function(payload) updir() end,
    ['do'] = function(payload) open(payload, 'here') end,
    ['dk'] = function(payload) open(payload, 'up') end,
    ['dj'] = function(payload) open(payload, 'down') end,
    ['dh'] = function(payload) open(payload, 'left') end,
    ['dl'] = function(payload) open(payload, 'right') end,
    ['di'] = function(payload) open(payload, 'tab') end,
  },
}
