local g = vim.g
local c = vim.cmd
local a = vim.api
local s = vim.keymap.set


g.diffview_lua = vim.fn['expand']('<sfile>')


local diffview_exe = function(cmd)
  if not vim.g.loaded_config_diffview then
    vim.g.loaded_config_diffview = 1
    local sta, _ = pcall(c, 'packadd diffview.nvim')
    if not sta then
      print('no diffview.nvim')
      return
    end
    sta, do_diffview = pcall(require, 'do_diffview')
    if not sta then
      print('no do_diffview')
      return
    end
  end
  if not do_diffview then
    return
  end
  if cmd == 'filehistory' then
    do_diffview.filehistory()
  elseif cmd == 'open' then
    do_diffview.open()
  elseif cmd == 'quit' then
    do_diffview.quit()
  end
end

a.nvim_create_user_command('Diffview', function(params)
  diffview_exe(unpack(params['fargs']))
end, { nargs = "*", })

s({'n', 'v'}, '<leader>gi', ':Diffview filehistory<cr>', {silent = true})
s({'n', 'v'}, '<leader>go', ':Diffview open<cr>', {silent = true})
s({'n', 'v'}, '<leader>gq', ':Diffview quit<cr>', {silent = true})
