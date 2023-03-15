local g = vim.g
local a = vim.api

g.autopairs_insertenter = a.nvim_create_autocmd({"InsertEnter"}, {
  callback = function()
    a.nvim_del_autocmd(g.autopairs_insertenter)
    local sta, autopairs = pcall(require, "nvim-autopairs")
    if not sta then
      print("no nvim-autopairs")
      return
    end
    autopairs.setup()
  end,
})
