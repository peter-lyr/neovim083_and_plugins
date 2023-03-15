local g = vim.g
local a = vim.api
local c = vim.cmd
local s = vim.keymap.set

if not g.startuptime_loaded then
  g.startuptime_loaded = 1
  g.startuptime_cursormoved = a.nvim_create_autocmd({"CursorMoved"}, {
    callback = function()
      a.nvim_del_autocmd(g.startuptime_cursormoved)
      local sta, _ = pcall(c, 'packadd vim-startuptime')
      if not sta then
        print("no vim-startuptime")
        return
      end
    end,
  })
end

g.auto_save = 1
g.auto_save_silent = 1
g.auto_save_events = {'InsertLeave', 'TextChanged', 'TextChangedI', 'CursorHold', 'CursorHoldI', 'CompleteDone'}
g.session_autoload = 'no'
g.session_autosave = 'yes'
