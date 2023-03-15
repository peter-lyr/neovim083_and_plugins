local s = vim.keymap.set

s({'n', 'v'}, '<leader>ee',  "<cmd>:EraseBadWhitespace<CR>", {silent = true})
s({'n', 'v'}, '<leader>eh',  "<cmd>:HideBadWhitespace<CR> ", {silent = true})
s({'n', 'v'}, '<leader>es',  "<cmd>:ShowBadWhitespace<CR> ", {silent = true})
