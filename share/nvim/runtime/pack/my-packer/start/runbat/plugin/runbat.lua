local g = vim.g
local f = vim.fn
local a = vim.api
local c = vim.cmd
local s = vim.keymap.set

g.runbat_lua = f['expand']('<sfile>')

local runbat = function(params)
  if not g.runbat_loaded then
    g.runbat_loaded = 1
    a.nvim_del_autocmd(g.runbat_cursormoved)
    sta, do_runbat = pcall(require, 'do_runbat')
    if not sta then
      print("no do_runbat")
      return
    end
  end
  if not do_runbat then
    return
  end
  do_runbat.run(params)
end

if not g.runbat_startup then
  g.runbat_startup = 1
  g.runbat_cursormoved = a.nvim_create_autocmd({"CursorMoved"}, {
    callback = function()
      a.nvim_del_autocmd(g.runbat_cursormoved)
      runbat()
    end,
  })
end

a.nvim_create_user_command('RunbaT', function(params)
  runbat(params['fargs'])
end, { nargs = "*", })

local opt = {silent = true}

s({'n', 'v'}, '<leader><leader>rb', ':RunbaT sel<cr>', opt)
s({'n', 'v'}, '<leader><leader>rpo', ':RunbaT proxy_on<cr>', opt)
s({'n', 'v'}, '<leader><leader>rpf', ':RunbaT proxy_off<cr>', opt)
s({'n', 'v'}, '<leader><leader>rpa', ':RunbaT path<cr>', opt)
