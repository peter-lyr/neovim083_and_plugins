local status, telescope = pcall(require, 'telescope')
if not status then
  return
end
local status2, actions = pcall(require, 'telescope.actions')
if not status2 then
  return
end
local s = vim.keymap.set
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
s({'n', 'v'}, '<leader>fa', '<esc>:Telescope builtin<cr>', {silent = true})
s({'n', 'v'}, '<leader>fo', '<esc>:Telescope oldfiles<cr>', {silent = true})
s({'n', 'v'}, '<leader>fh', '<esc>:Telescope help_tags<cr>', {silent = true})
s({'n', 'v'}, '<leader>fl', '<esc>:Telescope colorscheme<cr>', {silent = true})
s({'n', 'v'}, '<leader>fc', '<esc>:Telescope command_history<cr>', {silent = true})
s({'n', 'v'}, '<leader>fg', '<esc>:Telescope commands<cr>', {silent = true})
s({'n', 'v'}, '<leader>gf', '<esc>:Telescope git_files<cr>', {silent = true})
s({'n', 'v'}, '<leader>gc', '<esc>:Telescope git_commits<cr>', {silent = true})
s({'n', 'v'}, '<leader>gb', '<esc>:Telescope git_bcommits<cr>', {silent = true})
s({'n', 'v'}, '<leader>gh', '<esc>:Telescope git_branches<cr>', {silent = true})
s({'n', 'v'}, '<leader>gj', '<esc>:Telescope git_status<cr>', {silent = true})
s({'n', 'v'}, '<a-o>', '<esc>:Telescope live_grep<cr>', {silent = true})
s({'n', 'v'}, '<a-i>', '<esc>:Telescope grep_string<cr>', {silent = true})
s({'n', 'v'}, '<a-k>', '<esc>:Telescope find_files<cr>', {silent = true})
s({'n', 'v'}, '<a-b>', '<esc>:Telescope buffers<cr>', {silent = true})
s({'n', 'v'}, '<a-q>', '<esc>:Telescope quickfix<cr>', {silent = true})
s({'n', 'v'}, '<a-Q>', '<esc>:Telescope quickfixhistory<cr>', {silent = true})


local status, project_nvim = pcall(require, "project_nvim")
if not status then
  return
end
local status, projects = pcall(telescope.load_extension, "projects")
if not status then
  return
end
project_nvim.setup({
  manual_mode = true,
  datapath = vim.fn.expand("$VIMRUNTIME") .. "\\my-nvim-data",
  patterns = {
    ".cache",
    "build",
    "compile_commands.json",
    "CMakeLists.txt",
    ".git",
    ".svn",
  }
})
s({'n', 'v'}, '<a-s-k>', '<esc>:Telescope projects<cr>', {silent = true})


local status, vim_bookmarks = pcall(telescope.load_extension, "vim_bookmarks")
if not status then
  return
end
s({'n', 'v'}, '<a-m>', '<esc>:Telescope vim_bookmarks current_file<cr>', {silent = true})
s({'n', 'v'}, '<a-M>', '<esc>:Telescope vim_bookmarks all<cr>', {silent = true})
