local nvimtree_exe = function(cmd)
  if not vim.g.loaded_config_nvimtree then
    vim.g.loaded_config_nvimtree = 1
    local sta, config_nvimtree = pcall(require, 'config_nvimtree')
    if not sta then
      print('no config_nvimtree')
      return
    end
  end
  local sta, toggle_nvimtree = pcall(require, 'toggle_nvimtree')
  if not sta then
    print('no toggle_nvimtree')
    return
  end
  if cmd == 'toggle_search_fname' then
    toggle_nvimtree.toggle('cur_fname')
  elseif cmd == 'toggle_search_cwd' then
    toggle_nvimtree.toggle('cwd')
  end
end

local s = vim.keymap.set

s({'n', 'v'}, '<leader><leader>;', function() nvimtree_exe("toggle_search_fname") end, {silent = true})
s({'n', 'v'}, '<leader><leader>\'', function() nvimtree_exe("toggle_search_cwd") end, {silent = true})
