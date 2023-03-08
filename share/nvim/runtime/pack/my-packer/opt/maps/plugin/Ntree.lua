local s = vim.keymap.set
local g = vim.g

s({'n', 'v'}, '<leader>;', '<cmd>:call Ntree#ToggleSearchFname()<cr>', {silent = true})
s({'n', 'v'}, '<leader>\'', '<cmd>:call Ntree#ToggleSearchDirnameFname()<cr>', {silent = true})
s({'n', 'v'}, '<leader><leader>;', '<cmd>:call Ntree#Fix(0)<cr>', {silent = true})
s({'n', 'v'}, '<leader><leader>\'', '<cmd>:call Ntree#Fix(1)<cr>', {silent = true})

local bufwin_enter = function()
  if vim.o.filetype == 'netrw' then
    s({'n', 'v'}, '>', '<cmd>:call Ntree#NextDir(1)<cr>', {silent = true, buffer = true})
    s({'n', 'v'}, '<', '<cmd>:call Ntree#NextDir(0)<cr>', {silent = true, buffer = true})
    s({'n', 'v'}, 'J', '<cmd>:call Ntree#UpdateList(1)<cr>', {silent = true, buffer = true})
    s({'n', 'v'}, 'K', '<cmd>:call Ntree#UpdateList(0)<cr>', {silent = true, buffer = true})
    s({'n', 'v'}, 'y', '<cmd>:call Ntree#CopyFname()<cr>', {silent = true, buffer = true})
    s({'n', 'v'}, 'gy', '<cmd>:call Ntree#CopyFullPath()<cr>', {silent = true, buffer = true})
  end
end

vim.api.nvim_create_autocmd({"CursorMoved"}, {
  callback = bufwin_enter,
})

g.netrw_mousemaps = 0
g.netrw_liststyle = 3
g.netrw_sizestyle = "H"
