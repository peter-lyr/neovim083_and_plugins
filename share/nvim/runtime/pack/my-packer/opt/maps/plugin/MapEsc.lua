local s = vim.keymap.set

s('t', '<esc>', '<c-\\><c-n>', {silent = true})
s('t', '<a-m>', '<c-\\><c-n>', {silent = true})
s({ 'c', 'i' }, '<a-m>', '<esc><esc>', {silent = true})
s('v', 'm', '<esc>', {silent = true})
