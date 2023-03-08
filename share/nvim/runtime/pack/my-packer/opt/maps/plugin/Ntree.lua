local s = vim.keymap.set

s({'n', 'v'}, '<leader>;', '<cmd>:call Ntree#ToggleSearchFname()<cr>', {silent = true})
s({'n', 'v'}, '<leader>\'', '<cmd>:call Ntree#ToggleSearchDirnameFname()<cr>', {silent = true})


local bufwin_enter = function()
  if vim.o.filetype == 'netrw' then
    s({'n', 'v'}, '>', '<cmd>:call Ntree#NextDir(1)<cr>', {silent = true, buffer = true})
    s({'n', 'v'}, '<', '<cmd>:call Ntree#NextDir(0)<cr>', {silent = true, buffer = true})
    s({'n', 'v'}, 'J', '<cmd>:call Ntree#UpdateList(1)<cr>', {silent = true, buffer = true})
    s({'n', 'v'}, 'K', '<cmd>:call Ntree#UpdateList(0)<cr>', {silent = true, buffer = true})
  end
end

vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
  callback = bufwin_enter,
})
