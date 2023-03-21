local c = vim.cmd
local g = vim.g

local M = {}

function M.exe_telescope(cmd)
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
  end
  if cmd == '' then
    return
  end
  c(string.format([[
  try
    Telescope %s
  catch
    echomsg "no %s"
  endtry]], cmd, cmd))
end

return M
