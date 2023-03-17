local sta, telescope = pcall(require, 'telescope')
if not sta then
  print('no telescope')
  return
end
local status2, actions = pcall(require, 'telescope.actions')
if not status2 then
  print('no telescope.actions')
  return
end
telescope.setup({
  defaults = {
    mappings = {
      i = {
        ['<a-m>'] = actions.close,
        ['<a-j>'] = actions.move_selection_next,
        ['<a-k>'] = actions.move_selection_previous,
        ['<a-;>'] = actions.send_to_qflist + actions.open_qflist,
        ['<c-j>'] = actions.select_horizontal,
        ['<c-l>'] = actions.select_vertical,
        ['<c-k>'] = actions.select_tab,
        ['<c-o>'] = actions.select_default,
      },
      n = {
        ['<a-m>'] = actions.close,
        ['<a-j>'] = actions.move_selection_next,
        ['<a-k>'] = actions.move_selection_previous,
        ['<a-;>'] = actions.send_to_qflist + actions.open_qflist,
        ['<c-j>'] = actions.select_horizontal,
        ['<c-l>'] = actions.select_vertical,
        ['<c-k>'] = actions.select_tab,
        ['<c-o>'] = actions.select_default,
      }
    },
    file_ignore_patterns = {
      '.git/',
      '.cache/',
      'build/',
      '%.asc',
      '%.hex',
      -- 'map.txt',
      -- '%.lst',
    },
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case',
      '--fixed-strings',
    },
    wrap_results = true,
  },
})


local sta, project_nvim = pcall(require, "project_nvim")
if not sta then
  print('no project_nvim')
  return
end
local sta, projects = pcall(telescope.load_extension, "projects")
if not sta then
  print('no projects')
  return
end
local f = vim.fn
local datapath = f['expand']("$VIMRUNTIME") .. "\\my-neovim-data"
if f['filereadable'](datapath) == 0 then
  os.execute('cd ' .. f['expand']("$VIMRUNTIME") .. ' && md my-neovim-data')
end
project_nvim.setup({
  manual_mode = false,
  datapath = datapath,
  patterns = {
    ".cache",
    "build",
    "compile_commands.json",
    "CMakeLists.txt",
    ".git",
    ".svn",
  }
})


local sta, vim_bookmarks = pcall(telescope.load_extension, "vim_bookmarks")
if not sta then
  print('no vim_bookmarks')
  return
end
