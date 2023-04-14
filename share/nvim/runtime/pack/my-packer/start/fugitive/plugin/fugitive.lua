local fugitive_exe = function(cmd, refresh)
  if not vim.g.loaded_config_fugitive then
    vim.g.loaded_config_fugitive = 1
    local sta, _ = pcall(c, 'packadd vim-fugitive')
    if not sta then
      print("no fugitive vim-fugitive")
      return
    end
    sta, do_fugitive = pcall(require, 'do_fugitive')
    if not sta then
      print('no do_fugitive')
      return
    end
  end
  if not do_fugitive then
    return
  end
  do_fugitive.cmd("Gitsigns " .. cmd, refresh)
end


local s = vim.keymap.set
local a = vim.api
local c = vim.cmd

a.nvim_create_user_command('Fugitive', function(params)
  local fargs = params['fargs']
  local arg = ''
  for i, v in ipairs(params['fargs']) do
    arg = arg .. ' ' .. v
  end
  c(arg)
end, { nargs = "*", })

s({'n', 'v'}, '<leader>gg',  ":Fugitive Git<CR>", {silent = true})
s({'n', 'v'}, '<leader>gA',  ":Fugitive Git add -A<CR>", {silent = true})
s({'n', 'v'}, '<leader>ga',  ":Fugitive Git add %<CR>", {silent = true})
