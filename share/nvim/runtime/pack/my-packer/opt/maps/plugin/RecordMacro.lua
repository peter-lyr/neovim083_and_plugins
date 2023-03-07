local s = vim.keymap.set

s({'n', 'v'}, 'q', '<nop>', {silent = true})
s({'n', 'v'}, 'Q', 'q', {silent = true})
