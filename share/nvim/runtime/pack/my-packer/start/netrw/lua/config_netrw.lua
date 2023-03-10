local sta, netrw = pcall(require, 'netrw')
if not sta then
  print('no netrw')
  return
end

netrw.setup{
  use_devicons = true,
  mappings = {
    ['p'] = function(payload)
      -- - dir: the current netrw directory (vim.b.netrw_curdir)
      -- - node: the name of the file or directory under the cursor
      -- - link: the referenced file if the node under the cursor is a symlink
      -- - extension: the file extension if the node under the cursor is a file
      -- - type: the type of node under the cursor (0 = dir, 1 = file, 2 = symlink)
      print(vim.inspect(payload))
    end,
  },
}
