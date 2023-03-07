local s = vim.keymap.set

s({'n', 'v'}, '<bs>c', '<cmd>:close<cr>', {silent = true})
s({'n', 'v'}, '<a-bs>', '<cmd>:bw!<cr>', {silent = true})
