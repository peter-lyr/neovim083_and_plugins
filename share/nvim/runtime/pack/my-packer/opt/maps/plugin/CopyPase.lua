local s = vim.keymap.set

s({'n', 'v'}, '<a-y>', '"+y')
s({'n', 'v'}, '<a-p>', '"+p')
s({'n', 'v'}, '<a-s-p>', '"+P')

s({ 'c', 'i' }, '<a-w>', '<c-r>=g:word<cr>')
s({ 'c', 'i' }, '<a-v>', '<c-r>"')
s({ 't',     }, '<a-v>', '<c-\\><c-n>pi')
s({ 'c', 'i' }, '<a-=>', '<c-r>+')
s({ 't',     }, '<a-=>', '<c-\\><c-n>"+pi')
s({ 'n', 'v' }, '<a-z>', '"zy')
s({ 'c', 'i' }, '<a-z>', '<c-r>z')
s({ 't',     }, '<a-z>', '<c-\\><c-n>"zpi')

local buf_leave = function()
  vim.g.word = vim.fn['expand']('<cword>')
end

vim.api.nvim_create_autocmd({"BufLeave"}, {
  callback = buf_leave,
})
