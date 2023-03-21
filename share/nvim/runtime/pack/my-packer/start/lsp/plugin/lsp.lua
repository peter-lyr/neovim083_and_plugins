local g = vim.g
local a = vim.api
local c = vim.cmd

if not g.lsp_loaded then
  g.lsp_loaded = 1
  g.lsp_cursormoved = a.nvim_create_autocmd({"CursorMoved"}, {
    callback = function()
      a.nvim_del_autocmd(g.lsp_cursormoved)
      local sta, _ = pcall(c, 'packadd nvim-lspconfig')
      if not sta then
        print("no packadd nvim-lspconfig")
        return
      end
      local sta, _ = pcall(require, 'config_lsp')
      if not sta then
        print("no config_lsp")
        return
      end
    end,
  })
end
