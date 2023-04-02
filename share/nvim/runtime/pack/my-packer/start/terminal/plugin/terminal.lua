local s = vim.keymap.set
local a = vim.api
local f = vim.fn
local g = vim.g


g.builtin_terminal_ok = 1


local terminal_exe = function(cmd, chdir)
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
  toggle_terminal.toggle_terminal(cmd, chdir)
end


s('n', '\\q', function() terminal_exe('cmd', '') end, { silent = true})
s('n', '\\w', function() terminal_exe('ipython', '') end, { silent = true})
s('n', '\\e', function() terminal_exe('bash', '') end, { silent = true})
s('n', '\\r', function() terminal_exe('powershell', '') end, { silent = true})


s('n', '\\\\q', function() terminal_exe('cmd', f['getcwd']()) end, { silent = true})
s('n', '\\\\w', function() terminal_exe('ipython', f['getcwd']()) end, { silent = true})
s('n', '\\\\e', function() terminal_exe('bash', f['getcwd']()) end, { silent = true})
s('n', '\\\\r', function() terminal_exe('powershell', f['getcwd']()) end, { silent = true})


s('n', '\\<bs>q', function() terminal_exe('cmd', '.') end, { silent = true})
s('n', '\\<bs>w', function() terminal_exe('ipython', '.') end, { silent = true})
s('n', '\\<bs>e', function() terminal_exe('bash', '.') end, { silent = true})
s('n', '\\<bs>r', function() terminal_exe('powershell', '.') end, { silent = true})


s('n', '\\[q', function() terminal_exe('cmd', 'u') end, { silent = true})
s('n', '\\[w', function() terminal_exe('ipython', 'u') end, { silent = true})
s('n', '\\[e', function() terminal_exe('bash', 'u') end, { silent = true})
s('n', '\\[r', function() terminal_exe('powershell', 'u') end, { silent = true})


s('n', '\\]q', function() terminal_exe('cmd', '-') end, { silent = true})
s('n', '\\]w', function() terminal_exe('ipython', '-') end, { silent = true})
s('n', '\\]e', function() terminal_exe('bash', '-') end, { silent = true})
s('n', '\\]r', function() terminal_exe('powershell', '-') end, { silent = true})


function file_exists(name)
  local f = io.open(name, "r")
  if f ~= nil then
    io.close(f)
    return true
  else
    return false
  end
end

if not g.bufleave_readablefile_autocmd then
  g.bufleave_readablefile = f['getcwd']()
  g.bufleave_readablefile_autocmd = a.nvim_create_autocmd({"BufLeave"}, {
    callback = function()
      local fname = a['nvim_buf_get_name'](0)
      if file_exists(fname) then
        g.bufleave_readablefile = fname
      end
    end,
  })
end
