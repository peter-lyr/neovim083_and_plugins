local s = vim.keymap.set

s('n', 'c.', '<cmd>:try|cd %:h|catch|endtry<cr>', {silent = true}, {silent = true})
s('n', 'cu', '<cmd>:try|cd ..|catch|endtry<cr>', {silent = true}, {silent = true})
s('n', 'c-', '<cmd>:try|cd -|catch|endtry<cr>', {silent = true}, {silent = true})
