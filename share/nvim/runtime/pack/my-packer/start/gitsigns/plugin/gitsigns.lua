local gitsigns_exe = function(cmd, refresh)
  if not vim.g.loaded_config_gitsigns then
    vim.g.loaded_config_gitsigns = 1
    sta, _ = pcall(require, 'config_gitsigns')
    if not sta then
      print('no config_gitsigns')
      return
    end
    sta, do_gitsigns = pcall(require, 'do_gitsigns')
    if not sta then
      print('no do_gitsigns')
      return
    end
  end
  if not do_gitsigns then
    return
  end
  do_gitsigns.cmd("Gitsigns " .. cmd, refresh)
end


local s = vim.keymap.set
local a = vim.api

a.nvim_create_user_command('GSigns', function(params)
  local fargs = params['fargs']
  local arg1 = ''
  local arg2 = ''
  for i, v in ipairs(params['fargs']) do
    if i < #fargs then
      arg1 = arg1 .. ' ' .. v
    else
      arg2 = v
    end
  end
  gitsigns_exe(arg1, arg2)
end, { nargs = "*", })

s({ 'n', 'v' }, '<leader>gr', ":GSigns reset_hunk 1<cr>", { silent = true })
s({ 'n', 'v' }, '<leader>gR', ":GSigns reset_buffer 1<cr>", { silent = true })
s({ 'n', 'v' }, '<leader>k', ":GSigns prev_hunk 0<cr>", { silent = true })
s({ 'n', 'v' }, '<leader>j', ":GSigns next_hunk 0<cr>", { silent = true })
s({ 'n', 'v' }, '<leader>gp', ":GSigns preview_hunk 0<cr>", { silent = true })
s({ 'n', 'v' }, '<leader>gx', ":GSigns select_hunk 0<cr>", { silent = true })
s({ 'n', 'v' }, '<leader>gd', ":GSigns diffthis 0<cr>", { silent = true })
s({ 'n', 'v' }, '<leader>gD', ":GSigns diffthis HEAD~1 0<cr>", { silent = true })
s({ 'n', 'v' }, '<leader>gtd', ":GSigns toggle_deleted 0<cr>", { silent = true })
s({ 'n', 'v' }, '<leader>gtb', ":GSigns toggle_current_line_blame 0<cr>", { silent = true })
