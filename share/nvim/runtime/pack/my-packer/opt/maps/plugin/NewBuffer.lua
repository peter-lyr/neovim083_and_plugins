local s = vim.keymap.set

s({'n', 'v'}, '<leader>ba', '<c-w>s', {silent = true})
s({'n', 'v'}, '<leader>bb', '<cmd>:new<cr>', {silent = true})
s({'n', 'v'}, '<leader>bc', '<c-w>v', {silent = true})
s({'n', 'v'}, '<leader>bd', '<cmd>:vnew<cr>', {silent = true})
s({'n', 'v'}, '<leader>be', '<c-w>s<c-w>t', {silent = true})
s({'n', 'v'}, '<leader>bf', '<cmd>:tabnew<cr>', {silent = true})
