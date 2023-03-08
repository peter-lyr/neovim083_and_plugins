local s = vim.keymap.set

s({'n', 'v'}, '<a-y>', '"+y', {silent = true})
s({'n', 'v'}, '<a-p>', '"+p', {silent = true})
s({'n', 'v'}, '<a-s-p>', '"+P', {silent = true})

s({ 'c', 'i' }, '<a-w>', '<c-r>=g:word<cr>', {silent = true})
s({ 'c', 'i' }, '<a-v>', '<c-r>"', {silent = true})
s({ 't',     }, '<a-v>', '<c-\\><c-n>pi', {silent = true})
s({ 'c', 'i' }, '<a-=>', '<c-r>+', {silent = true})
s({ 't',     }, '<a-=>', '<c-\\><c-n>"+pi', {silent = true})
s({ 'n', 'v' }, '<a-z>', '"zy', {silent = true})
s({ 'c', 'i' }, '<a-z>', '<c-r>z', {silent = true})
s({ 't',     }, '<a-z>', '<c-\\><c-n>"zpi', {silent = true})

local buf_leave = function()
  vim.g.word = vim.fn['expand']('<cword>')
end

vim.api.nvim_create_autocmd({"BufLeave"}, {
  callback = buf_leave,
})
