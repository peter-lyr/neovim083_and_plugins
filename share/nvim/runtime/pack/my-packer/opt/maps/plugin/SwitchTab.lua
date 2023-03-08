local s = vim.keymap.set

s({ 'n', 'v', }, '<leader>1', '1gt', {silent = true})
s({ 'n', 'v', }, '<leader>2', '2gt', {silent = true})
s({ 'n', 'v', }, '<leader>3', '3gt', {silent = true})
s({ 'n', 'v', }, '<leader>4', '4gt', {silent = true})
s({ 'n', 'v', }, '<leader>5', '5gt', {silent = true})
s({ 'n', 'v', }, '<leader>6', '6gt', {silent = true})
s({ 'n', 'v', }, '<leader>7', '7gt', {silent = true})
s({ 'n', 'v', }, '<leader>8', '8gt', {silent = true})
s({ 'n', 'v', }, '<leader>9', '9gt', {silent = true})
s({ 'n', 'v', }, '<leader>0', '<cmd>:tablast<cr>', {silent = true})
s({ 'n', 'v', }, '<leader><cr>', '<cmd>:call SwitchTab#SpaceCr()<cr>', {silent = true})

s({'n', 'v'}, '<cr>', '<cmd>:tabnext<cr>', {silent = true})
s({'n', 'v'}, '<s-cr>', '<cmd>:tabprevious<cr>', {silent = true})

s({ 'n', 'v', }, '<c-s-h>', '<cmd>:try <bar> tabmove - <bar> catch <bar> endtry<cr>', {silent = true})
s({ 'n', 'v', }, '<c-s-l>', '<cmd>:try <bar> tabmove + <bar> catch <bar> endtry<cr>', {silent = true})
s({ 'n', 'v', }, '<c-s-k>', 'gT', {silent = true})
s({ 'n', 'v', }, '<c-s-j>', 'gt', {silent = true})

local tab_leave = function()
  vim.g.lasttab = vim.fn['tabpagenr']()
end

vim.api.nvim_create_autocmd({"TabLeave"}, {
  callback = tab_leave,
})
