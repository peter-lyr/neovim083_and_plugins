local g = vim.g
local a = vim.api
local c = vim.cmd

g.whichkey_lua = vim.fn['expand']('<sfile>')

if not g.whichkey_loaded then
  g.whichkey_loaded = 1
  g.whichkey_cursormoved = a.nvim_create_autocmd({"CursorMoved"}, {
    callback = function()
      a.nvim_del_autocmd(g.whichkey_cursormoved)
      local sta, whichkey = pcall(require, "which-key")
      if not sta then
        print("no which-key")
        return
      end
      whichkey.setup({})
    end,
  })
end
