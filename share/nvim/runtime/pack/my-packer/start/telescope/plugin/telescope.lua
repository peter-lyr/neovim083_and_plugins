local s = vim.keymap.set
local c = vim.cmd
local g = vim.g


local telescope_exe = function(cmd)
  if not vim.g.loaded_config_telescope then
    g.loaded_config_telescope = 1
    local sta, _ = pcall(c, 'packadd telescope.nvim')
    if not sta then
      print('no config_telescope')
      return
    end
    local sta, config_telescope = pcall(require, 'config_telescope')
    if not sta then
      print('no config_telescope')
      return
    end
  end
  c(string.format([[
  try
    Telescope %s
  catch
    echomsg "no %s"
  endtry]], cmd, cmd))
end


s({'n', 'v'}, '<leader>fa', function() telescope_exe("builtin") end, {silent = true})
s({'n', 'v'}, '<leader>fo', function() telescope_exe("oldfiles") end, {silent = true})
s({'n', 'v'}, '<leader>fh', function() telescope_exe("help_tags") end, {silent = true})
s({'n', 'v'}, '<leader>fl', function() telescope_exe("colorscheme") end, {silent = true})
s({'n', 'v'}, '<leader>fc', function() telescope_exe("command_history") end, {silent = true})
s({'n', 'v'}, '<leader>fg', function() telescope_exe("commands") end, {silent = true})
s({'n', 'v'}, '<leader>gf', function() telescope_exe("git_files") end, {silent = true})
s({'n', 'v'}, '<leader>gc', function() telescope_exe("git_commits") end, {silent = true})
s({'n', 'v'}, '<leader>gb', function() telescope_exe("git_bcommits") end, {silent = true})
s({'n', 'v'}, '<leader>gh', function() telescope_exe("git_branches") end, {silent = true})
s({'n', 'v'}, '<leader>gj', function() telescope_exe("git_status") end, {silent = true})
s({'n', 'v'}, '<a-o>', function() telescope_exe("live_grep") end, {silent = true})
s({'n', 'v'}, '<a-i>', function() telescope_exe("grep_string") end, {silent = true})
s({'n', 'v'}, '<a-k>', function() telescope_exe("find_files") end, {silent = true})
s({'n', 'v'}, '<a-b>', function() telescope_exe("buffers") end, {silent = true})
s({'n', 'v'}, '<a-q>', function() telescope_exe("quickfix") end, {silent = true})
s({'n', 'v'}, '<a-Q>', function() telescope_exe("quickfixhistory") end, {silent = true})


s({'n', 'v'}, '<a-s-k>', function() telescope_exe("projects") end, {silent = true})


s({'n', 'v'}, '<a-m>', function() telescope_exe("vim_bookmarks current_file") end, {silent = true})
s({'n', 'v'}, '<a-M>', function() telescope_exe("vim_bookmarks all") end, {silent = true})
