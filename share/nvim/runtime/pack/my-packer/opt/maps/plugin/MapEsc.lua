local s = vim.keymap.set

s('v', 'm', '<esc>')

s({ 'i', 'c', }, 'df', '<esc><esc>')
s({ 'i', 'c', }, 'Df', '<esc><esc>')
s({ 'i', 'c', }, 'dF', '<esc><esc>')
s({ 'i', 'c', }, 'DF', '<esc><esc>')
s({ 'i', 'c', }, 'ddff', 'df')
s({ 'i', 'c', }, 'ddFF', 'dF')
s({ 'i', 'c', }, 'DDFF', 'DF')
s({ 'i', 'c', }, 'DDff', 'Df')
s('t', 'df', '<c-\\><c-n>')
s('t', 'Df', '<c-\\><c-n>')
s('t', 'dF', '<c-\\><c-n>')
s('t', 'DF', '<c-\\><c-n>')
s('t', 'ddff', 'df')
s('t', 'ddFF', 'dF')
s('t', 'DDFF', 'DF')
s('t', 'DDff', 'Df')

s({ 'i', 'c' }, '<a-m>', '<esc><esc>')
s('t', '<esc>', '<c-\\><c-n>')
s('t', '<a-m>', '<c-\\><c-n>')
