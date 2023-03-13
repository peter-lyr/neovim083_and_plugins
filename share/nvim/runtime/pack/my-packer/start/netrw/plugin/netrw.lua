

local netrw_exe = function(cmd)
  if not vim.g.loaded_config_netrw then
    vim.g.loaded_config_netrw = 1
    local sta, config_netrw = pcall(require, 'config_netrw')
    if not sta then
      print('no config_netrw')
      return
    end
  end
  local sta, toggle_netrw = pcall(require, 'toggle_netrw')
  if not sta then
    print('no toggle_netrw')
    return
  end
  if cmd == 'toggle_fix' then
    toggle_netrw.toggle('fix')
  elseif cmd == 'toggle_search_fname' then
    toggle_netrw.toggle('cur_fname')
  elseif cmd == 'toggle_search_cwd' then
    toggle_netrw.toggle('cwd')
  end
end


local s = vim.keymap.set
local g = vim.g


g.netrw_mousemaps = 0
-- g.netrw_liststyle = 3
g.netrw_sizestyle = "H"


s({'n', 'v'}, '<leader>l', function() netrw_exe("toggle_fix") end, {silent = true})
s({'n', 'v'}, '<leader>;', function() netrw_exe("toggle_search_fname") end, {silent = true})
s({'n', 'v'}, '<leader>\'', function() netrw_exe("toggle_search_cwd") end, {silent = true})
