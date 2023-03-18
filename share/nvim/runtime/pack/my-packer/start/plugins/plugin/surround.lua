local g = vim.g
local s = vim.keymap.set
local a = vim.api
local c = vim.cmd

if not g.surround_loaded then
  g.surround_loaded = 1
  g.surround_cursormoved = a.nvim_create_autocmd({"CursorMoved"}, {
    callback = function()
      a.nvim_del_autocmd(g.surround_cursormoved)
      local sta, _ = pcall(c, 'packadd vim-surround')
      if not sta then
        print("no vim-surround")
        return
      end
    end,
  })
end
