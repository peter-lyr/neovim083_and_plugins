local s = vim.keymap.set
local a = vim.api
local g = vim.g

local bufferclean_exe = function()
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
  do_bufferclean.do_bufferclean()
end

a.nvim_create_user_command('BufferClean', function(params)
  bufferclean_exe()
end, { nargs = "*", })

s({'n', 'v'}, '<leader>hh', ':BufferClean<cr>', {silent = true})
