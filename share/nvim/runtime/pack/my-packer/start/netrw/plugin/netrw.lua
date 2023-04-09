local g = vim.g
local w = vim.w
local f = vim.fn
local a = vim.api
local c = vim.cmd
local o = vim.opt
local s = vim.keymap.set

g.netrw_lua = vim.fn['expand']('<sfile>')

local netrw_exe = function(cmd)
  if not vim.g.loaded_config_netrw then
    vim.g.loaded_config_netrw = 1
    local sta, _ = pcall(require, 'config_netrw')
    if not sta then
      print('no config_netrw')
      return
    end
    sta, toggle_netrw = pcall(require, 'toggle_netrw')
    if not sta then
      print('no toggle_netrw')
      return
    end
  end
  if not toggle_netrw then
    return
  end
  g.netrw_leader_flag = 1
  if cmd == 'fix_unfix' then
    toggle_netrw.fix_unfix('cwd')
  elseif cmd == 'toggle_fix' then
    toggle_netrw.toggle('fix')
  elseif cmd == 'toggle_search_fname' then
    toggle_netrw.toggle('cur_fname')
  elseif cmd == 'toggle_search_cwd' then
    toggle_netrw.toggle('cwd')
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

s({'n', 'v'}, '<leader>l', function() netrw_exe("toggle_fix") end, {silent = true})
s({'n', 'v'}, '<leader><leader>l', function() netrw_exe("fix_unfix") end, {silent = true})
s({'n', 'v'}, '<leader>;', function() netrw_exe("toggle_search_fname") end, {silent = true})
s({'n', 'v'}, '<leader>\'', function() netrw_exe("toggle_search_cwd") end, {silent = true})

local bufenter_netrw = function()
  if o.ft:get() == 'netrw' then
    if g.netrw_leader_flag == 0 then
      if o.winfixwidth:get() then
        if not g.bufferenter_do_netrw then
          g.bufferenter_do_netrw = 1
          local sta, toggle_netrw = pcall(require, 'toggle_netrw')
          if not sta then
            print('no toggle_netrw')
            return
          end
        end
        if not toggle_netrw then
          return
        end
        toggle_netrw.netrw_fix_set_width()
      end
    end
  end
end

a.nvim_create_autocmd({"BufEnter"}, {
  callback = bufenter_netrw,
})

local ignore_list = {
  '.git/',
  '.svn/',
}

a.nvim_create_autocmd({"CursorMoved"}, {
  callback = function()
    if o.ft:get() == 'netrw' then
      netrw_list_hide = table.concat(ignore_list, ',')
      netrw_list_hide2 = string.gsub(string.gsub(f['system']('cd ' .. f['netrw#Call']('NetrwGetCurdir', 1) .. ' && git config --local core.quotepath false & git ls-files --other --ignored --exclude-standard --directory'), '\n', ','), ',$', '')
      if #netrw_list_hide2 > 0 then
        netrw_list_hide = netrw_list_hide .. ',' .. netrw_list_hide2
      end
      if netrw_list_hide ~= g.netrw_list_hide then
        g.netrw_list_hide = netrw_list_hide
        if w.netrw_liststyle < 2 and g.netrw_hide == 1 then
          c([[call feedkeys("..")]])
        end
      end
    end
  end,
})
