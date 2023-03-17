local s = vim.keymap.set


local bufferswitch_exe = function(cmd)
  local sta, do_bufferswitch = pcall(require, 'do_bufferswitch')
  if not sta then
    print('no do_bufferswitch')
    return
  end
  do_bufferswitch.do_bufferswitch(cmd)
end


s('n', '\\a', function() bufferswitch_exe('') end, { silent = true})
