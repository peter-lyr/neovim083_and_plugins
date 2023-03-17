local s = vim.keymap.set

s('v', 'm', '<esc>')

s({ 'i', 'c', }, 'lq', '<esc><esc>')
s({ 'i', 'c', }, 'Lq', '<esc><esc>')
s({ 'i', 'c', }, 'lQ', '<esc><esc>')
s({ 'i', 'c', }, 'LQ', '<esc><esc>')
s('t', 'lq', '<c-\\><c-n>')
s('t', 'Lq', '<c-\\><c-n>')
s('t', 'lQ', '<c-\\><c-n>')
s('t', 'LQ', '<c-\\><c-n>')

s({ 'i', 'c' }, '<a-m>', '<esc><esc>')
s('t', '<esc>', '<c-\\><c-n>')
s('t', '<a-m>', '<c-\\><c-n>')
