local s = vim.keymap.set
local a = vim.api
local g = vim.g


local bufferswitch_exe = function(cmd)
  if not g.loaded_do_bufferswitch then
    g.loaded_do_bufferswitch = 1
    sta, do_bufferswitch = pcall(require, 'do_bufferswitch')
    if not sta then
      print('no do_bufferswitch')
      return
    end
  end
  if not do_bufferswitch then
    return
  end
  do_bufferswitch.do_bufferswitch(cmd)
end

a.nvim_create_user_command('BufferSwitch', function(params)
  bufferswitch_exe(unpack(params['fargs']))
end, { nargs = "*", })

s('n', '\\\\a', ':BufferSwitch<cr>', { silent = true })
