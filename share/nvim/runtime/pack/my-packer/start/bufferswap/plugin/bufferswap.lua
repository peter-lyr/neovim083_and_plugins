local s = vim.keymap.set
local a = vim.api
local g = vim.g

local bufferswap_exe = function(cmd)
  if not g.loaded_do_bufferswap then
    g.loaded_do_bufferswap = 1
    sta, do_bufferswap = pcall(require, 'do_bufferswap')
    if not sta then
      print('no do_bufferswap')
      return
    end
  end
  if not do_bufferswap then
    return
  end
  do_bufferswap.do_bufferswap(cmd)
end

a.nvim_create_user_command('BufferSwap', function(params)
  bufferswap_exe()
end, { nargs = "*", })

s('n', '<leader>qq', ':BufferSwap<cr>', { silent = true })
