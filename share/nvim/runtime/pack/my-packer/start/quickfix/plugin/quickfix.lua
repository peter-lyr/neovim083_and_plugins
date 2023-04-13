local s = vim.keymap.set
local c = vim.cmd

s('n', '<leader><leader>d', function() c('copen|wincmd J') end, { silent = true})
s('n', '<leader><leader>f', function() c('cclose') end, { silent = true})
