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
-- end


-- local l = { 'tabs', 'spaces' }
--
-- vim.ui.select(l, { prompt = 'prompt' }, function(choice, idx)
--   print(choice, idx)
-- end)

function show_array(arr)
  for i, v in ipairs(arr) do
    print(i, ':', v)
  end
end

-- -- local buflist = {}
-- for i=1, f['tabpagenr']('$') do
--   -- table.insert(buflist, f['tabpagebuflist'](i))
--   show_array(f['tabpagebuflist'](i))
-- end
-- -- show_array(buflist)

for k, v in pairs(a['nvim_list_bufs']()) do
  print(v, a['nvim_buf_get_name'](v), ']------------[', f['getbufvar'](v, '&buftype'))
end
