local s = vim.keymap.set
local c = vim.cmd
local g = vim.g


local sdkcbp_exe = function(cmd)
  if not g.loaded_do_sdkcbp then
    g.loaded_do_sdkcbp = 1
    sta, do_sdkcbp = pcall(require, 'do_sdkcbp')
    if not sta then
      print('no do_sdkcbp')
      do_sdkcbp = nil
      return
    end
  end
  if not do_sdkcbp then
    print('no do_sdkcbp again')
    return
  end
  do_sdkcbp.do_sdkcbp(cmd)
end

local opt = {silent = true}

s({'n', 'v'}, '<c-F9>', function() sdkcbp_exe('') end, opt)
