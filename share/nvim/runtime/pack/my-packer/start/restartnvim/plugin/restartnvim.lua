local s = vim.keymap.set

s({'n', 'v'}, 'ZZXX', ":!taskkill /f /im nvim.exe<cr>")
