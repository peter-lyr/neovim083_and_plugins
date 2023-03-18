local g = vim.g
local a = vim.api
local s = vim.keymap.set
-- local c = vim.cmd

if not g.aerial_loaded then
  g.aerial_loaded = 1
  g.aerial_cursormoved = a.nvim_create_autocmd({"CursorMoved"}, {
    callback = function()
      a.nvim_del_autocmd(g.aerial_cursormoved)
      -- local sta, _ = pcall(c, 'packadd aerial.nvim')
      -- if not sta then
      --   print("no aerial")
      --   return
      -- end
      local status, aerial = pcall(require, "aerial")
      if not status then
        return
      end
      aerial.setup{}
    end,
  })
end

s('n', '<leader>,', '<cmd>AerialToggle!<cr>')
