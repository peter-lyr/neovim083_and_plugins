local g = vim.g
local a = vim.api
local c = vim.cmd

if not g.colorscheme_loaded then
  g.colorscheme_loaded = 1
  g.colorscheme_cursormoved = a.nvim_create_autocmd({"CursorMoved"}, {
    callback = function()
      a.nvim_del_autocmd(g.colorscheme_cursormoved)
      local sta, _ = pcall(c, 'colorscheme sierra')
      if not sta then
        print("no colorscheme sierra")
        return
      end
    end,
  })
end
