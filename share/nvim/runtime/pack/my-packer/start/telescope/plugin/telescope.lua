local s = vim.keymap.set
local c = vim.cmd
local g = vim.g


local telescope_exe = function(cmd)
  if not g.loaded_config_telescope then
    g.loaded_config_telescope = 1
    local sta, _ = pcall(c, 'packadd vim-bookmarks')
    if not sta then
      print("no vim-bookmarks")
    else
      g.bookmark_save_per_working_dir = 1
      g.bookmark_auto_save = 1
    end
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
    require('telescope.builtin').find_files()
    c[[ call feedkeys("\<esc>") ]]
  end
  c(string.format([[
  try
    Telescope %s
  catch
    echomsg "no %s"
  endtry]], cmd, cmd))
end


s({'n', 'v'}, '<a-/>', function() telescope_exe("search_history") end, {silent = true})
s({'n', 'v'}, '<a-c>', function() telescope_exe("command_history") end, {silent = true})
s({'n', 'v'}, '<a-C>', function() telescope_exe("commands") end, {silent = true})

s({'n', 'v'}, '<a-o>', function() telescope_exe("oldfiles") end, {silent = true})
s({'n', 'v'}, '<a-k>', function() telescope_exe("find_files") end, {silent = true})
s({'n', 'v'}, '<a-j>', function() telescope_exe("buffers") end, {silent = true})

s({'n', 'v'}, '<a-;>k', function() telescope_exe("git_files") end, {silent = true})
s({'n', 'v'}, '<a-;>i', function() telescope_exe("git_commits") end, {silent = true})
s({'n', 'v'}, '<a-;>o', function() telescope_exe("git_bcommits") end, {silent = true})
s({'n', 'v'}, '<a-;>h', function() telescope_exe("git_branches") end, {silent = true})
s({'n', 'v'}, '<a-;>j', function() telescope_exe("git_status") end, {silent = true})

s({'n', 'v'}, '<a-l>', function() telescope_exe("live_grep") end, {silent = true})
s({'n', 'v'}, '<a-i>', function() telescope_exe("grep_string") end, {silent = true})

s({'n', 'v'}, '<a-q>', function() telescope_exe("quickfix") end, {silent = true})
s({'n', 'v'}, '<a-Q>', function() telescope_exe("quickfixhistory") end, {silent = true})

s({'n', 'v'}, '<a-\'>a', function() telescope_exe("builtin") end, {silent = true})
s({'n', 'v'}, '<a-\'>b', function() telescope_exe("lsp_document_symbols") end, {silent = true})
s({'n', 'v'}, '<a-\'>c', function() telescope_exe("colorscheme") end, {silent = true})
s({'n', 'v'}, '<a-\'>d', function() telescope_exe("diagnostics") end, {silent = true})
s({'n', 'v'}, '<a-\'>f', function() telescope_exe("filetypes") end, {silent = true})
s({'n', 'v'}, '<a-\'>h', function() telescope_exe("help_tags") end, {silent = true})
s({'n', 'v'}, '<a-\'>j', function() telescope_exe("jumplist") end, {silent = true})
s({'n', 'v'}, '<a-\'>m', function() telescope_exe("keymaps") end, {silent = true})
s({'n', 'v'}, '<a-\'>o', function() telescope_exe("vim_options") end, {silent = true})
s({'n', 'v'}, '<a-\'>p', function() telescope_exe("planets") end, {silent = true})
s({'n', 'v'}, '<a-\'>r', function() telescope_exe("lsp_references") end, {silent = true})
s({'n', 'v'}, '<a-\'>z', function() telescope_exe("current_buffer_fuzzy_find") end, {silent = true})

s({'n', 'v'}, '<a-s-k>', function() telescope_exe("projects") end, {silent = true})


s({'n', 'v'}, '<a-m>', function() telescope_exe("vim_bookmarks current_file") end, {silent = true})
s({'n', 'v'}, '<a-M>', function() telescope_exe("vim_bookmarks all") end, {silent = true})
