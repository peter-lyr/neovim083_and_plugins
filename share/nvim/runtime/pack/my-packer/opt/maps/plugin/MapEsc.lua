local s = vim.keymap.set

s('t', '<esc>', '<c-\\><c-n>', {silent = true})
s('t', '<a-m>', '<c-\\><c-n>', {silent = true})
s({ 'c', 'i' }, '<a-m>', '<esc><esc>', {silent = true})
s('v', 'm', '<esc>', {silent = true})
s({ 'i', 'c', 't', 'n' }, 'df', '<esc><esc>', {silent = true})
s({ 'i', 'c', 't', 'n' }, 'Df', '<esc><esc>', {silent = true})
s({ 'i', 'c', 't', 'n' }, 'dF', '<esc><esc>', {silent = true})
s({ 'i', 'c', 't', 'n' }, 'DF', '<esc><esc>', {silent = true})
s({ 'i', 'c', 't', 'n' }, 'ddf', 'df', {silent = true})
s({ 'i', 'c', 't', 'n' }, 'ddF', 'dF', {silent = true})
s({ 'i', 'c', 't', 'n' }, 'DDF', 'DF', {silent = true})
s({ 'i', 'c', 't', 'n' }, 'DDf', 'Df', {silent = true})
