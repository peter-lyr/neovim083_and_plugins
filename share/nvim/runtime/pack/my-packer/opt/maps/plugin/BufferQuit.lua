local s = vim.keymap.set

s({'n', 'v'}, '<bs>c', '<cmd>:try|hide|catch|endtry<cr>', {silent = true})
s({'n', 'v'}, '<a-bs>', '<cmd>:bw!<cr>', {silent = true})
s({'n', 'v'}, 'ZX', '<cmd>:qa!<cr>', {silent = true})
