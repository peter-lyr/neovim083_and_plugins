local s = vim.keymap.set

s({'n', 'v'}, '<leader>p', '<c-w>p', {silent = true})

s({'n', 'v'}, '<leader>w', '<cmd>:call BufferJump#Up()<cr>', {silent = true})
s({'n', 'v'}, '<leader>s', '<cmd>:call BufferJump#Down()<cr>', {silent = true})
s({'n', 'v'}, '<leader>a', '<cmd>:call BufferJump#Left()<cr>', {silent = true})
s({'n', 'v'}, '<leader>d', '<cmd>:call BufferJump#Right()<cr>', {silent = true})

s({'n', 'v'}, '<leader>o', '<cmd>:call BufferJump#MaxHeight()<cr>', {silent = true})
s({'n', 'v'}, '<leader>i', '<cmd>:call BufferJump#SameWidthHeight()<cr>', {silent = true})
s({'n', 'v'}, '<leader>u', '<cmd>:call BufferJump#MaxWidth()<cr>', {silent = true})

s({'n', 'v'}, '<leader><leader>o', '<cmd>:call BufferJump#Miximize(1)<cr>', {silent = true})
s({'n', 'v'}, '<leader><leader>i', '<cmd>:call BufferJump#Miximize(0)<cr>', {silent = true})

s({'n', 'v'}, '<leader><leader>w', '<cmd>:call BufferJump#WinFixHeight()<cr>', {silent = true})
s({'n', 'v'}, '<leader><leader>s', '<cmd>:call BufferJump#NoWinFixHeight()<cr>', {silent = true})
s({'n', 'v'}, '<leader><leader>a', '<cmd>:call BufferJump#WinFixWidth()<cr>', {silent = true})
s({'n', 'v'}, '<leader><leader>d', '<cmd>:call BufferJump#NoWinFixWidth()<cr>', {silent = true})
