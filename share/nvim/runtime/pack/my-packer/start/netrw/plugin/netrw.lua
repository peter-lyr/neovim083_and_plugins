local a = vim.api
local f = vim.fn
local g = vim.g
local o = vim.opt
local s = vim.keymap.set

local sta

g.netrw_lua = f['expand']('<sfile>')

local netrw_exe = function(cmd)
  if not g.loaded_config_netrw then
    g.loaded_config_netrw = 1
    local config_netrw
    sta, config_netrw = pcall(require, 'config_netrw')
    if not sta then
      print(config_netrw)
      return
    end
    sta, Toggle_netrw = pcall(require, 'toggle_netrw')
    if not sta then
      print(Toggle_netrw)
      return
    end
  end
  if not Toggle_netrw then
    return
  end
  g.netrw_leader_flag = 1
  if cmd == 'fix_unfix' then
    Toggle_netrw.fix_unfix('cwd')
  elseif cmd == 'toggle_fix' then
    Toggle_netrw.toggle('fix')
  elseif cmd == 'toggle_search_fname' then
    Toggle_netrw.toggle('cur_fname')
  elseif cmd == 'toggle_search_cwd' then
    Toggle_netrw.toggle('cwd')
  elseif cmd == 'toggle_search_sel' then
    Toggle_netrw.toggle('sel')
  end
  g.netrw_leader_flag = 0
end

g.netrw_mousemaps = 0
g.netrw_sizestyle = "H"
g.netrw_preview = 1
g.netrw_alto = 0
g.netrw_winsize = 120
g.netrw_list_hide = ""
g.netrw_dirhistmax = 0
g.netrw_hide = 0
g.netrw_dynamic_maxfilenamelen = 1
g.netrw_timefmt = "%Y-%m-%d %H:%M:%S %a"
g.netrw_liststyle = 1
g.netrw_sort_by = 'exten'

a.nvim_create_user_command('Netrw', function(params)
  netrw_exe(unpack(params['fargs']))
end, { nargs = "*", })

s({ 'n', 'v' }, '<leader>l', ":Netrw toggle_fix<cr>", { silent = true })
s({ 'n', 'v' }, '<leader><leader>l', ":Netrw fix_unfix<cr>", { silent = true })
s({ 'n', 'v' }, '<leader>;', ":Netrw toggle_search_fname<cr>", { silent = true })
s({ 'n', 'v' }, '<leader><leader>;', ":Netrw toggle_search_cwd<cr>", { silent = true })
s({ 'n', 'v' }, '<leader>\'', ":Netrw toggle_search_sel<cr>", { silent = true })

local bufenter_netrw = function()
  if o.ft:get() == 'netrw' then
    if g.netrw_leader_flag == 0 then
      if o.winfixwidth:get() then
        if not g.bufferenter_do_netrw then
          g.bufferenter_do_netrw = 1
          sta, Toggle_netrw = pcall(require, 'toggle_netrw')
          if not sta then
            print(Toggle_netrw)
            return
          end
        end
        if not Toggle_netrw then
          return
        end
        Toggle_netrw.netrw_fix_set_width()
      end
    end
  end
end

a.nvim_create_autocmd({ "BufEnter" }, {
  callback = bufenter_netrw,
})
