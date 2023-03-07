local s = vim.keymap.set

s('n', '<leader>f.', '<cmd>:if (&ft == "vim" || &ft == "lua") | source %:p | endif<cr>', {silent = true})
