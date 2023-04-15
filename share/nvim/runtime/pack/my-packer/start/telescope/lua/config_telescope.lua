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
vim.cmd'autocmd User TelescopePreviewerLoaded setlocal number'
telescope.setup({
  defaults = {
    layout_strategy = 'horizontal',
    layout_config = {
      height = 0.99,
      width = 0.99,
    },
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
        ['ql'] = actions.close,
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
      '.svn',
      '.vs',
      '.git',
      '.cache',
      'obj',
      'build',
      '%.js',
      '%.asc',
      '%.hex',
      'CMakeLists.txt',
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


local sta, _ = pcall(telescope.load_extension, "projects")
if not sta then
  print('no projects')
end


local sta, _ = pcall(telescope.load_extension, "vim_bookmarks")
if not sta then
  print('no vim_bookmarks')
end


local sta, _ = pcall(telescope.load_extension, "ui-select")
if not sta then
  print('no ui-select')
end
