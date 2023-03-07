local s = vim.keymap.set

s('i', 'df', '<esc>', {silent = true})
s('i', 'Df', '<esc>', {silent = true})
s('i', 'dF', '<esc>', {silent = true})
s('i', 'DF', '<esc>', {silent = true})
s('t', 'df', '<c-\\><c-n>', {silent = true})
s('t', 'Df', '<c-\\><c-n>', {silent = true})
s('t', 'dF', '<c-\\><c-n>', {silent = true})
s('t', 'DF', '<c-\\><c-n>', {silent = true})
s('t', '<esc>', '<c-\\><c-n>', {silent = true})
s('t', '<a-m>', '<c-\\><c-n>', {silent = true})
s('c', '<a-m>', '<esc><esc>', {silent = true})
s('v', 'm', '<esc>', {silent = true})
