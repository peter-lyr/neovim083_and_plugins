local g = vim.g
local a = vim.api
local c = vim.cmd

if not g.cmp_loaded then
  g.cmp_loaded = 1
  g.cmp_cursormoved = a.nvim_create_autocmd({"CursorMoved"}, {
    callback = function()
      a.nvim_del_autocmd(g.cmp_cursormoved)
      local sta, _ = pcall(require, 'config_cmp')
      if not sta then
        print("no packadd vim-cmp")
        return
      end
    end,
  })
end
