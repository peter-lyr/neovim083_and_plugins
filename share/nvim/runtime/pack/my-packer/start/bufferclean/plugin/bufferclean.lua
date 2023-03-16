local s = vim.keymap.set

local bufferclean_exe = function()
  local sta, do_bufferclean = pcall(require, 'do_bufferclean')
  if not sta then
    print('no do_bufferclean')
    return
  end
  do_bufferclean.do_bufferclean()
end

s({'n', 'v'}, '<leader>hh', bufferclean_exe, {silent = true})
