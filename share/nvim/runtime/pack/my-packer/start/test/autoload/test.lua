local f = vim.fn
local s = vim.keymap.set
local a = vim.api
local c = vim.cmd


-- for k, v in pairs(f['getbufvar'](f['winbufnr'](i), '&')) do
--   print(k, '--------->', v)
-- end
-- print('1111111111111111111111111111111111111111')
-- for k, v in pairs(f['getbufvar'](f['winbufnr'](i), '')) do
--   print(k, '--------->', v)
-- end
-- print('2222222222222222222222222222222222222222')


-- for i=1, f['winnr']('$') do
--   local bnr = f['winbufnr'](i)
--   local fname = a['nvim_buf_get_name'](bnr)
--   local fname = string.gsub(fname, '\\', '/')
-- ed
