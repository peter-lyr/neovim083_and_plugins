local s = vim.keymap.set
local c = vim.cmd

s('n', '\\\\d', function() c('copen|wincmd J') end, { silent = true})
s('n', '\\\\f', function() c('cclose') end, { silent = true})
