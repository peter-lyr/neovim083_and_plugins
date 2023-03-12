local sta, netrw = pcall(require, 'netrw')
if not sta then
  print('no netrw')
  return
end

local test = function(payload)
  -- - dir: the current netrw directory (vim.b.netrw_curdir)
  -- - node: the name of the file or directory under the cursor
  -- - link: the referenced file if the node under the cursor is a symlink
  -- - extension: the file extension if the node under the cursor is a file
  -- - type: the type of node under the cursor (0 = dir, 1 = file, 2 = symlink)
  print(vim.inspect(payload))
end

local f = vim.fn
local c = vim.cmd
local o = vim.opt

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

local preview = function(payload)
  if not payload or vim.b.netrw_liststyle == 2 then
    return nil
  end
  if is_up_dir() or is_cur_dir() then
    return nil
  end
  if payload['type'] == 1 then
    f['netrw#Call']("NetrwPreview", f['netrw#Call']("NetrwBrowseChgDir", 1, f['netrw#Call']("NetrwGetWord"), 1))
    return 1
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

local open = function(payload, direction)
  if payload['type'] == 0 then
    c[[ call feedkeys("\<cr>") ]]
    return
  end
  if direction == 'tab' then
    c[[ tabnew ]]
  else
    if is_winfix() then
      if f['winnr']('$') == 1 then
        c[[ wincmd n ]]
      else
        local cur_winid = f['win_getid'](f['winnr']())
        c[[ wincmd p ]]
        if cur_winid == f['win_getid'](f['winnr']()) then
          c[[ wincmd n ]]
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
  c(string.format("e %s/%s", payload['dir'], payload['node']))
end

netrw.setup{
  use_devicons = true,
  mappings = {
    ['(f9)'] = function(payload) test(payload) end,
    ['(tab)'] = function(payload) preview(payload) end,
    ['(s-tab)'] = function(payload) preview_go(payload) end,
    ['do'] = function(payload) open(payload, 'here') end,
    ['dk'] = function(payload) open(payload, 'up') end,
    ['dj'] = function(payload) open(payload, 'down') end,
    ['dh'] = function(payload) open(payload, 'left') end,
    ['dl'] = function(payload) open(payload, 'right') end,
    ['di'] = function(payload) open(payload, 'tab') end,
  },
}
