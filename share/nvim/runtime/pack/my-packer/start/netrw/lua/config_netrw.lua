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

local list_style = function(payload)
  f['netrw#Call']("NetrwListStyle", 1)
end

netrw.setup{
  use_devicons = true,
  mappings = {
    -- ['(cr)'] = function(payload) test(payload) end,
    ['(2-LeftMouse)'] = function(payload) list_style(payload) end,
  },
}
