local gitsigns_exe = function(cmd, refresh)
  if not vim.g.loaded_config_gitsigns then
    vim.g.loaded_config_gitsigns = 1
    local sta, config_gitsigns = pcall(require, 'config_gitsigns')
    if not sta then
      print('no config_gitsigns')
      return
    end
  end
  local sta, do_gitsigns = pcall(require, 'do_gitsigns')
  if not sta then
    print('no do_gitsigns')
    return
  end
  do_gitsigns.cmd(cmd, refresh)
end


local s = vim.keymap.set


s({'n', 'v'}, '<leader>gr', function() gitsigns_exe("Gitsigns reset_hunk", 1) end, {silent = true})
s({'n', 'v'}, '<leader>gR', function() gitsigns_exe("Gitsigns reset_buffer", 1) end, {silent = true})
s({'n', 'v'}, '<leader>gE', function() gitsigns_exe("Git reset HEAD", 1) end, {silent = true})
s({'n', 'v'}, '<leader>k', function() gitsigns_exe("Gitsigns prev_hunk", 0) end, {silent = true})
s({'n', 'v'}, '<leader>j', function() gitsigns_exe("Gitsigns next_hunk", 0) end, {silent = true})
s({'n', 'v'}, '<leader>gp', function() gitsigns_exe("Gitsigns preview_hunk", 0) end, {silent = true})
s({'n', 'v'}, '<leader>gx', function() gitsigns_exe("Gitsigns select_hunk", 0) end, {silent = true})
s({'n', 'v'}, '<leader>gd', function() gitsigns_exe("Gitsigns diffthis", 0) end, {silent = true})
s({'n', 'v'}, '<leader>gD', function() gitsigns_exe("Gitsigns diffthis HEAD~1", 0) end, {silent = true})
s({'n', 'v'}, '<leader>gtd', function() gitsigns_exe("Gitsigns toggle_deleted", 0) end, {silent = true})
s({'n', 'v'}, '<leader>gtb', function() gitsigns_exe("Gitsigns toggle_current_line_blame", 0) end, {silent = true})
