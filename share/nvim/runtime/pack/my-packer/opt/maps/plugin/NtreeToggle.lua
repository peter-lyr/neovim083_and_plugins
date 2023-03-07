local s = vim.keymap.set

s({'n', 'v'}, '<leader>;', '<cmd>:call NtreeToggle#Toggle()<cr>', {silent = true})
s({'n', 'v'}, '<leader>\'', '<cmd>:call NtreeToggle#ToggleSearchFname()<cr>', {silent = true})
s({'n', 'v'}, '<leader>"', '<cmd>:call NtreeToggle#ToggleSearchDirnameFname()<cr>', {silent = true})
