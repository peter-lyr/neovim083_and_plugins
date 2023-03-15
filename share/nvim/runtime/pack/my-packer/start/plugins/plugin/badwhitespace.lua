local g = vim.g
local a = vim.api
local c = vim.cmd
local s = vim.keymap.set

if not g.badwhitespace_loaded then
  g.badwhitespace_loaded = 1
  g.badwhitespace_cursormoved = a.nvim_create_autocmd({"CursorMoved"}, {
    callback = function()
      a.nvim_del_autocmd(g.badwhitespace_cursormoved)
      local sta, _ = pcall(c, 'packadd vim-bad-whitespace')
      if not sta then
        print("no badwhitespace sierra")
        return
      end
    end,
  })
end

s({'n', 'v'}, '<leader>ee',  "<cmd>:EraseBadWhitespace<CR>", {silent = true})
s({'n', 'v'}, '<leader>eh',  "<cmd>:HideBadWhitespace<CR> ", {silent = true})
s({'n', 'v'}, '<leader>es',  "<cmd>:ShowBadWhitespace<CR> ", {silent = true})
