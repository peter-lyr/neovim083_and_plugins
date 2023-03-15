local s = vim.keymap.set

s('n', 'c.', '<cmd>:try|cd %:h|ec getcwd()|catch|endtry<cr>')
s('n', 'cu', '<cmd>:try|cd ..|ec getcwd()|catch|endtry<cr>')
s('n', 'c-', '<cmd>:try|cd -|ec getcwd()|catch|endtry<cr>')
