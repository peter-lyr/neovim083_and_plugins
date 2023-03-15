local g = vim.g
local s = vim.keymap.set
local a = vim.api
local c = vim.cmd

if not g.fugitive_loaded then
  g.fugitive_loaded = 1
  g.fugitive_cursormoved = a.nvim_create_autocmd({"CursorMoved"}, {
    callback = function()
      a.nvim_del_autocmd(g.fugitive_cursormoved)
      local sta, _ = pcall(c, 'packadd vim-fugitive')
      if not sta then
        print("no fugitive vim-fugitive")
        return
      end
    end,
  })
end

s({'n', 'v'}, '<leader>gg',  "<cmd>:G <CR>", {silent = true})
s({'n', 'v'}, '<leader>gA',  "<cmd>:Git add -A<CR>", {silent = true})
s({'n', 'v'}, '<leader>ga',  "<cmd>:Git add %<CR>", {silent = true})
