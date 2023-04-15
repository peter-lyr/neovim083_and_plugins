local g = vim.g
local a = vim.api
local c = vim.cmd
local f = vim.fn

if not g.project_loaded then
  g.project_loaded = 1
  g.project_cursormoved = a.nvim_create_autocmd({"CursorMoved"}, {
    callback = function()
      a.nvim_del_autocmd(g.project_cursormoved)
      local sta, project_nvim = pcall(require, "project_nvim")
      if not sta then
        print('no project_nvim')
        return
      end
      local datapath = f['expand']("$VIMRUNTIME") .. "\\my-neovim-data"
      if f['filereadable'](datapath) == 0 then
        os.execute('cd ' .. f['expand']("$VIMRUNTIME") .. ' && md my-neovim-data')
      end
      project_nvim.setup({
        manual_mode = false,
        datapath = datapath,
        detection_methods = { "pattern", "lsp" },
        patterns = {
          ".cache",
          "build",
          "compile_commands.json",
          "CMakeLists.txt",
          ".git",
          ".svn",
        }
      })
    end,
  })
end
