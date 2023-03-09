local s = vim.keymap.set
local g = vim.g

s({'n', 'v'}, '<leader>;', '<cmd>:call Ntree#ToggleSearchFname()<cr>', {silent = true})
s({'n', 'v'}, '<leader>\'', '<cmd>:call Ntree#ToggleSearchDirnameFname()<cr>', {silent = true})
s({'n', 'v'}, '<leader><leader>;', '<cmd>:call Ntree#Fix(0)<cr>', {silent = true})
s({'n', 'v'}, '<leader><leader>\'', '<cmd>:call Ntree#Fix(1)<cr>', {silent = true})
s({'n', 'v'}, '<leader><leader><leader>;', '<cmd>:call Ntree#Fix(2)<cr>', {silent = true})
s({'n', 'v'}, '<leader><leader><leader>\'', '<cmd>:call Ntree#SplitChangeDirection()<cr>', {silent = true})

g.netrw_mousemaps = 0
g.netrw_liststyle = 3
g.netrw_sizestyle = "H"
