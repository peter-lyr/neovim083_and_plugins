local s = vim.keymap.set
local a = vim.api
local c = vim.cmd


local fugitive_exe = function(cmd)
  if not vim.g.loaded_config_fugitive then
    vim.g.loaded_config_fugitive = 1
    local sta, _ = pcall(c, 'packadd vim-fugitive')
    if not sta then
      print("no fugitive vim-fugitive")
      return
    end
  end
  c(cmd)
end


a.nvim_create_user_command('Fugitive', function(params)
  local fargs = params['fargs']
  local arg = ''
  for i, v in ipairs(params['fargs']) do
    arg = arg .. ' ' .. v
  end
  fugitive_exe(arg)
end, { nargs = "*", })

s({'n', 'v'}, '<leader>gg',  ":Fugitive Git<CR>", {silent = true})
s({'n', 'v'}, '<leader>gA',  ":Fugitive Git add -A<CR>", {silent = true})
s({'n', 'v'}, '<leader>ga',  ":Fugitive Git add %<CR>", {silent = true})
