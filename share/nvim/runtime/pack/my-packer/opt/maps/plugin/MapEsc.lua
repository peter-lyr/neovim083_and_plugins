local s = vim.keymap.set

s('t', '<esc>', '<c-\\><c-n>', {silent = true})
s('t', '<a-m>', '<c-\\><c-n>', {silent = true})
s({ 'c', 'i' }, '<a-m>', '<esc><esc>', {silent = true})
s('v', 'm', '<esc>', {silent = true})
s({ 'i', 'c', 't', }, 'df', '<esc><esc>', {silent = true})
s({ 'i', 'c', 't', }, 'Df', '<esc><esc>', {silent = true})
s({ 'i', 'c', 't', }, 'dF', '<esc><esc>', {silent = true})
s({ 'i', 'c', 't', }, 'DF', '<esc><esc>', {silent = true})
s({ 'i', 'c', 't', }, 'ddff', 'df', {silent = true})
s({ 'i', 'c', 't', }, 'ddFF', 'dF', {silent = true})
s({ 'i', 'c', 't', }, 'DDFF', 'DF', {silent = true})
s({ 'i', 'c', 't', }, 'DDff', 'Df', {silent = true})
