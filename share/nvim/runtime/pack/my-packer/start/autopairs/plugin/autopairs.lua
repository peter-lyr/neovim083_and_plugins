local g = vim.g
local a = vim.api

if not g.autopairs_loaded then
  g.autopairs_loaded = 1
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
end
