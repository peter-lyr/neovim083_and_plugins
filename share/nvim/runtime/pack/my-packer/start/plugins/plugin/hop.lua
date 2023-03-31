local g = vim.g
local a = vim.api
local c = vim.cmd

if not g.hop_loaded then
  g.hop_loaded = 1
  g.hop_cursormoved = a.nvim_create_autocmd({"CursorMoved"}, {
    callback = function()
      a.nvim_del_autocmd(g.hop_cursormoved)
      local sta, _ = pcall(c, 'packadd hop.nvim')
      if not sta then
        print("no hop")
        return
      end
      local status, hop = pcall(require, "hop")
      if not status then
        return
      end
      hop.setup{}
    end,
  })
end

vim.keymap.set({'n', 'v'}, "gi", "<esc><cmd>:HopChar1MW<CR>")
vim.keymap.set({'n', 'v'}, "go", "<esc><cmd>:HopChar2MW<CR>")
