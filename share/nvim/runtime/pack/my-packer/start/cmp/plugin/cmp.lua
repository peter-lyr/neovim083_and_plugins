local g = vim.g
local a = vim.api
local c = vim.cmd

if not g.cmp_loaded then
  g.cmp_loaded = 1
  g.cmp_cursormoved = a.nvim_create_autocmd({"CursorMoved"}, {
    callback = function()
      a.nvim_del_autocmd(g.cmp_cursormoved)
      local sta, _ = pcall(c, 'packadd ultisnips')
      if not sta then
        print("no packadd ultisnips")
      end
      local sta, _ = pcall(c, 'packadd nvim-cmp')
      if not sta then
        print("no packadd nvim-cmp")
      end
      local sta, _ = pcall(c, 'packadd cmp-cmdline')
      if not sta then
        print("no packadd cmp-cmdline")
      end
      local sta, _ = pcall(c, 'packadd cmp-buffer')
      if not sta then
        print("no packadd cmp-buffer")
      end
      local sta, _ = pcall(c, 'packadd cmp-nvim-lsp')
      if not sta then
        print("no packadd cmp-nvim-lsp")
      end
      local sta, _ = pcall(c, 'packadd cmp-nvim-ultisnips')
      if not sta then
        print("no packadd cmp-nvim-ultisnips")
      end
      local sta, _ = pcall(c, 'packadd cmp-path')
      if not sta then
        print("no packadd cmp-path")
      end
      local sta, _ = pcall(require, 'config_cmp')
      if not sta then
        print("no config_cmp")
        return
      end
    end,
  })
end
