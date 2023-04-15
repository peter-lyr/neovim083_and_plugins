local s = vim.keymap.set
local a = vim.api
local g = vim.g

local bufferclean_exe = function(cmd)
  if not g.loaded_do_bufferclean then
    g.loaded_do_bufferclean = 1
    sta, do_bufferclean = pcall(require, 'do_bufferclean')
    if not sta then
      print('no do_bufferclean')
      return
    end
  end
  if not do_bufferclean then
    return
  end
  if cmd == 'do_bufferclean' then
    do_bufferclean.do_bufferclean()
  else
    do_bufferclean.do_bufferclean_all()
  end
end

a.nvim_create_user_command('BufferClean', function(params)
  bufferclean_exe(unpack(params['fargs']))
end, { nargs = "*", })

s({'n', 'v'}, '<leader>hh', ':BufferClean do_bufferclean<cr>', {silent = true})
s({'n', 'v'}, '<leader><leader>hh', ':BufferClean do_bufferclean_all<cr>', {silent = true})
