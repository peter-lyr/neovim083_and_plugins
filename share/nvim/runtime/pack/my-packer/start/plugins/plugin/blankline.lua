local g = vim.g
local a = vim.api
local c = vim.cmd

if not g.indent_blankline_loaded then
  g.indent_blankline_loaded = 1
  g.indent_blankline_cursormoved = a.nvim_create_autocmd({"CursorMoved"}, {
    callback = function()
      a.nvim_del_autocmd(g.indent_blankline_cursormoved)
      local sta, _ = pcall(c, 'packadd indent-blankline.nvim')
      if not sta then
        print("no indent_blankline")
        return
      end
      local sta, indent_blankline = pcall(require, 'indent_blankline')
      if not sta then
        print("no indent_blankline")
        return
      end
      indent_blankline.setup {
        -- show_current_context = true,
        -- show_current_context_start = true,
      }
    end,
  })
end
