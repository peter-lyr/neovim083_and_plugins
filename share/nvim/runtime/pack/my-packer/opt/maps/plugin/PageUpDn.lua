local s = vim.keymap.set

s({'n', 'v'}, '<c-s>', '5<c-e>', {silent = true})
s({'n', 'v'}, '<c-a>', '5<c-y>', {silent = true})
s({'n', 'v'}, '<c-d>', '<c-u>', {silent = true})
s({'n', 'v'}, '<c-f>', '<c-d>', {silent = true})
s({'n', 'v'}, '<c-u>', '<c-b>', {silent = true})
s({'n', 'v'}, '<c-b>', '<c-f>', {silent = true})
