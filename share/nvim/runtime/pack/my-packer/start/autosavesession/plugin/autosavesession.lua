local g = vim.g
local a = vim.api
local f = vim.fn
local c = vim.cmd
local s = vim.keymap.set

local session_exe = function(cmd, mode)
  if not vim.g.loaded_config_session then
    vim.g.loaded_config_session = 1
    local sta, _ = pcall(c, 'packadd vim-session')
    if not sta then
      print('no vim-session')
      return
    end
  end
  if mode == 'cmd' then
    c(cmd)
  else
    c(string.format([[ call feedkeys(":%s") ]], cmd))
  end
end

a.nvim_create_user_command('Session', function(params)
  local fargs = params['fargs']
  local arg1 = ''
  local arg2 = ''
  for i, v in ipairs(params['fargs']) do
    if i < #fargs then
      arg1 = arg1 .. ' ' .. v
    else
      arg2 = v
    end
  end
  session_exe(arg1, arg2)
end, { nargs = "*", })

s({'n', 'v'}, '\\ss', ":Session SaveSession! default cmd<cr>", {silent = true})
s({'n', 'v'}, '\\st', ":Session SaveTabSession! default cmd<cr>", {silent = true})
s({'n', 'v'}, '\\sS', ":Session OpenSession! default cmd<cr>", {silent = true})
s({'n', 'v'}, '\\sT', ":Session OpenTabSession! default cmd<cr>", {silent = true})
s({'n', 'v'}, '\\Ss', ":Session SaveSession! feedkeys<cr>", {silent = true})
s({'n', 'v'}, '\\St', ":Session SaveTabSession! feedkeys<cr>", {silent = true})
s({'n', 'v'}, '\\SS', ":Session OpenSession! feedkeys<cr>", {silent = true})
s({'n', 'v'}, '\\ST', ":Session OpenTabSession! feedkeys<cr>", {silent = true})

g.auto_save = 1
g.auto_save_silent = 1
g.auto_save_events = {'InsertLeave', 'TextChanged', 'TextChangedI', 'CursorHold', 'CursorHoldI', 'CompleteDone'}
g.session_autoload = 'no'
g.session_autosave = 'yes'
