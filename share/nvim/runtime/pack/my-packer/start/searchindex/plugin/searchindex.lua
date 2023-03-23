local g = vim.g
local a = vim.api
local c = vim.cmd

if not g.searchindex_loaded then
  g.searchindex_loaded = 1
  g.searchindex_cursormoved = a.nvim_create_autocmd({"CursorMoved"}, {
    callback = function()
      a.nvim_del_autocmd(g.searchindex_cursormoved)
      local sta, _ = pcall(c, 'packadd vim-searchindex')
      if not sta then
        print("no packadd vim-searchindex")
        return
      end
    end,
  })
end
