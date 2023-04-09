local g = vim.g
local a = vim.api
local c = vim.cmd

g.ultisnips_lua = vim.fn['expand']('<sfile>')

if not g.ultisnips_loaded then
  g.ultisnips_loaded = 1
  g.ultisnips_cursormoved = a.nvim_create_autocmd({"CursorMoved"}, {
    callback = function()
      a.nvim_del_autocmd(g.ultisnips_cursormoved)
      local sta, _ = pcall(require, 'do_ultisnips')
      if not sta then
        print("no do_ultisnips")
        return
      end
    end,
  })
end

g.UltiSnipsJumpForwardTrigger = "<a-.>"
g.UltiSnipsJumpBackwardTrigger = "<a-,>"
