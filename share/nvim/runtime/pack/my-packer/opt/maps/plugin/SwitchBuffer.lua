local s = vim.keymap.set

s({'n', 'v'}, '<leader>w', '<c-w>k', {silent = true})
s({'n', 'v'}, '<leader>s', '<c-w>j', {silent = true})
s({'n', 'v'}, '<leader>a', '<c-w>h', {silent = true})
s({'n', 'v'}, '<leader>d', '<c-w>l', {silent = true})
