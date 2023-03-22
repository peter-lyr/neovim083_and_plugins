local g = vim.g
local a = vim.api
local c = vim.cmd

if not g.scrollbar_loaded then
  g.scrollbar_loaded = 1
  g.scrollbar_cursormoved = a.nvim_create_autocmd({"CursorMoved"}, {
    callback = function()
      a.nvim_del_autocmd(g.scrollbar_cursormoved)
      local sta, _ = pcall(c, 'packadd nvim-scrollview')
      if not sta then
        print("no packadd nvim-scrollview")
        return
      end
      local sta, scrollview = pcall(require, 'scrollview')
      if not sta then
        print("no config_scrollbar")
        return
      end
      scrollview.setup()
    end,
  })
end
