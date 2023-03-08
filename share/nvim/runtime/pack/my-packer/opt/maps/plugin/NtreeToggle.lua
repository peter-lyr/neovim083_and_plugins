local s = vim.keymap.set

s({'n', 'v'}, '<leader>;', '<cmd>:call NtreeToggle#ToggleSearchFname()<cr>', {silent = true})
s({'n', 'v'}, '<leader>\'', '<cmd>:call NtreeToggle#ToggleSearchDirnameFname()<cr>', {silent = true})


local bufwin_enter = function()
  if vim.o.filetype == 'netrw' then
    s({'n', 'v'}, '>', '<cmd>:call NtreeToggle#NextDir(1)<cr>', {silent = true, buffer = true})
    s({'n', 'v'}, '<', '<cmd>:call NtreeToggle#NextDir(0)<cr>', {silent = true, buffer = true})
    s({'n', 'v'}, 'J', '<cmd>:call NtreeToggle#UpdateList(1)<cr>', {silent = true, buffer = true})
    s({'n', 'v'}, 'K', '<cmd>:call NtreeToggle#UpdateList(0)<cr>', {silent = true, buffer = true})
  end
end

vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
  callback = bufwin_enter,
})
