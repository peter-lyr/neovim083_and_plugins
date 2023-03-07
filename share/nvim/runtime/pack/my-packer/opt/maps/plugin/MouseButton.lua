local s = vim.keymap.set

s({ 'n', 'v', 'i' }, '<rightmouse>', '<leftmouse>', {silent = true})
s({ 'n', 'v', 'i' }, '<rightrelease>', '<nop>', {silent = true})
s({ 'n', 'v', 'i' }, '<middlemouse>', '<nop>', {silent = true})
