local s = vim.keymap.set

s({'n', 'v'}, 'ZZZZXXXX', function() os.execute("taskkill /f /im nvim.exe") end)
