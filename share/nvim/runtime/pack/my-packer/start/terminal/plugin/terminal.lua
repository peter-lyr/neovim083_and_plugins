local s = vim.keymap.set
local g = vim.g


local terminal_exe = function(cmd)
  if not g.loaded_toggle_terminal then
    g.loaded_toggle_terminal = 1
    sta, toggle_terminal = pcall(require, 'toggle_terminal')
    if not sta then
      print('no toggle_terminal')
      return
    end
  end
  if not toggle_terminal then
    return
  end
  toggle_terminal.toggle_terminal(cmd)
end


s('n', '\\q', function() terminal_exe('') end, { silent = true})
s('n', '\\w', function() terminal_exe('ipython') end, { silent = true})
s('n', '\\e', function() terminal_exe('bash') end, { silent = true})
s('n', '\\r', function() terminal_exe('powershell') end, { silent = true})
