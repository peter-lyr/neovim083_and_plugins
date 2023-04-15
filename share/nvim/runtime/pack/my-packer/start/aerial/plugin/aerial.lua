local g = vim.g
local a = vim.api
local s = vim.keymap.set

if not g.aerial_loaded then
  g.aerial_loaded = 1
  g.aerial_cursormoved = a.nvim_create_autocmd({ "CursorMoved" }, {
    callback = function()
      a.nvim_del_autocmd(g.aerial_cursormoved)
      local sta, _ = pcall(require, "config_aerial")
      if not sta then
        print("no config_aerial")
      end
    end,
  })
end

s({ 'n', 'v' }, '<leader>,', '<cmd>:AerialToggle float<cr>')
s({ 'n', 'v' }, '<leader><', '<cmd>:AerialCloseAll<cr>')
s({ 'n', 'v' }, ']a', '<cmd>:AerialNext<cr>')
s({ 'n', 'v' }, '[a', '<cmd>:AerialPrev<cr>')
