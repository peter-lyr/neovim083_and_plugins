local s = vim.keymap.set

s({'n', 'v'}, 'ZZZZXXXX', ":!taskkill /f /im nvim.exe<cr>")
