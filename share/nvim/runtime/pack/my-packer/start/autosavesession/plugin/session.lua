local c = vim.cmd
local s = vim.keymap.set
local f = vim.fn

local session_exe = function(cmd, mode)
  if not vim.g.loaded_config_session then
    vim.g.loaded_config_session = 1
    local sta, _ = pcall(c, 'packadd vim-session')
    if not sta then
      print('no vim-session')
      return
    end
  end
  if mode == 0 then
    c(cmd)
  else
    c(string.format([[ call feedkeys(":%s") ]], cmd))
  end
end


s({'n', 'v'}, '\\ss', function() session_exe("SaveSession! default", 0) end, {silent = true})
s({'n', 'v'}, '\\st', function() session_exe("SaveTabSession! default", 0) end, {silent = true})
s({'n', 'v'}, '\\sS', function() session_exe("OpenSession! default", 0) end, {silent = true})
s({'n', 'v'}, '\\sT', function() session_exe("OpenTabSession! default", 0) end, {silent = true})
s({'n', 'v'}, '\\Ss', function() session_exe("SaveSession! ", 1) end, {silent = true})
s({'n', 'v'}, '\\St', function() session_exe("SaveTabSession! ", 1) end, {silent = true})
s({'n', 'v'}, '\\SS', function() session_exe("OpenSession! ", 1) end, {silent = true})
s({'n', 'v'}, '\\ST', function() session_exe("OpenTabSession! ", 1) end, {silent = true})
