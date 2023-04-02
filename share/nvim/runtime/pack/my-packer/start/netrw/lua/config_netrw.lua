local sta, netrw = pcall(require, 'netrw')
if not sta then
  print('no netrw')
  return
end

local g = vim.g
local f = vim.fn
local c = vim.cmd
local o = vim.opt
local a = vim.api

local get_dname = function(payload)
  f['netrw#Call']("NetrwBrowseChgDir", 1, f['netrw#Call']("NetrwGetWord"), 1)
  if payload['type'] == 0 then
    local res = f['netrw#Call']("NetrwBrowseChgDir", 1, f['netrw#Call']("NetrwGetWord"), 1)
    if #res > 0 then
      return string.gsub(res, "/", "\\")
    end
  end
  return ''
end

local get_fname = function(payload)
  f['netrw#Call']("NetrwBrowseChgDir", 1, f['netrw#Call']("NetrwGetWord"), 1)
  if payload['type'] == 1 then
    local res = f['netrw#Call']("NetrwBrowseChgDir", 1, f['netrw#Call']("NetrwGetWord"), 1)
    if #res > 0 then
      return string.gsub(res, "/", "\\")
    end
  end
  return ''
end

local Path = require("plenary.path")

local get_fname_tail = function(fname)
  local fname = string.gsub(fname, "/", "\\")
  local path = Path:new(fname)
  if path:is_file() then
    local fname = path:_split()
    return fname[#fname]
  elseif path:is_dir() then
    local fname = path:_split()
    if #fname[#fname] > 0 then
      return fname[#fname]
    else
      return fname[#fname-1]
    end
  end
  return ''
end

local get_dtarget = function(payload)
  local dname = get_dname(payload)
  if #dname > 0 then
    local dname = string.gsub(dname, "/", "\\")
    return dname
  end
  local fname = get_fname(payload)
  local fname = string.gsub(fname, "/", "\\")
  local path = Path:new(fname)
  if path:is_file() then
    local fname = path:parent()['filename']
    local fname = string.gsub(fname, "/", "\\")
    return fname .. '\\'
  end
  return ''
end

local test = function(payload)
  -- - dir: the current netrw directory (vim.b.netrw_curdir)
  -- - node: the name of the file or directory under the cursor
  -- - link: the referenced file if the node under the cursor is a symlink
  -- - extension: the file extension if the node under the cursor is a file
  -- - type: the type of node under the cursor (0 = dir, 1 = file, 2 = symlink)
  -- print(vim.inspect(payload))
  print('fname:', get_fname(payload))
  print('dname:', get_dname(payload))
  print('dtarg:', get_dtarget(payload))
end

-- local list_style = function()
--   f['netrw#Call']("NetrwListStyle", 1)
-- end

local preview = function(payload)
  if not payload or vim.b.netrw_liststyle == 2 then
    return nil
  end
  if o.ft:get() ~= 'netrw' then
    return nil
  end
  if payload['type'] == 1 then
    local fname = get_fname(payload)
    if f['filereadable'](fname) then
      f['netrw#Call']("NetrwPreview", fname)
      return 1
    end
  else
    c[[ call feedkeys("\<cr>") ]]
  end
  return nil
end

local preview_go = function(payload)
  if preview(payload) then
    c[[ wincmd p ]]
  end
end

local is_winfixwidth = function(payload)
  if o.winfixwidth:get() then
    return 1
  end
  return nil
end

local get_win_cnt_no_scratch = function()
  local wnrs = {}
  for i = 1, f['winnr']('$') do
    if f['getbufvar'](f['winbufnr'](i), '&buftype') ~= 'nofile' then
      table.insert(wnrs, i)
    end
  end
  if #wnrs == 0 then
    return nil
  end
  return wnrs
end

local is_hide_en = function()
  local cnt = 0
  for i=1, f['winnr']('$') do
    if f['getbufvar'](f['winbufnr'](i), '&buftype') ~= 'nofile' then
      cnt = cnt + 1
    end
    if cnt > 1 then
      return true
    end
  end
  return false
end

local toggle_netrw = require('toggle_netrw')

local open = function(payload, direction)
  if payload['type'] == 0 then
    c[[ call feedkeys("\<cr>") ]]
    return
  end
  local fname = get_fname(payload)
  if direction == 'tab' then
    c[[ tabnew ]]
  else
    if is_winfixwidth() then
      local cur_winid = f['win_getid']()
      local wnrs = get_win_cnt_no_scratch()
      if not wnrs then
        print('2--23-23-23-423-4')
        return
      end
      if #wnrs == 1 then
        c[[ wincmd v ]]
        c(string.format("e %s", fname))
        return
      else
        if f['win_gotoid'](g.netrw_back_winid) == 0 then
          print('23423J4J')
        end
      end
      a.nvim_win_set_width(cur_winid, 0)
    end
    if o.ft:get() == 'netrw' then
      if is_hide_en() then
        c'hide'
      end
      if f['win_gotoid'](g.netrw_back_winid) == 0 then
        print('99999j4j')
      end
    end
    if direction == 'up' then
      c[[ leftabove new ]]
    elseif direction == 'down' then
      c[[ new ]]
    elseif direction == 'left' then
      c[[ leftabove vnew ]]
    elseif direction == 'right' then
      c[[ vnew ]]
    end
  end
  c(string.format("e %s", fname))
end

local updir = function()
  c[[ call feedkeys("-") ]]
end

local copy_fname = function(payload)
  if payload['type'] == 0 then
    local dname = get_fname_tail(get_dname(payload))
    c(string.format([[let @+ = "%s"]], dname))
    print(dname)
  else
    local fname = get_fname_tail(get_fname(payload))
    c(string.format([[let @+ = "%s"]], fname))
    print(fname)
  end
end

local copy_fname_full = function(payload)
  if payload['type'] == 0 then
    local dname = get_dname(payload)
    c(string.format([[let @+ = '%s']], dname))
    print(dname)
  else
    local fname = get_fname(payload)
    c(string.format([[let @+ = '%s']], fname))
    print(fname)
  end
end

local toggle_dir = function(payload)
  if not payload or vim.b.netrw_liststyle == 2 then
    return nil
  end
  if o.ft:get() ~= 'netrw' then
    return nil
  end
  if payload['type'] == 0 then
    c[[ call feedkeys("\<cr>") ]]
  end
end

local preview_file = function(payload)
  if not payload or vim.b.netrw_liststyle == 2 then
    return nil
  end
  if o.ft:get() ~= 'netrw' then
    return nil
  end
  local fname = get_fname(payload)
  if payload['type'] == 1 then
    if f['filereadable'](fname) then
      f['netrw#Call']("NetrwPreview", fname)
      return 1
    end
  end
end

local chg_dir = function(payload)
  c(string.format("cd %s", get_dtarget(payload)))
  print(f['getcwd']())
end

local explorer = function(payload)
  f['system'](string.format("cd %s && start .", get_dtarget(payload)))
end

local system_start = function(payload)
  if payload['type'] == 1 then
    f['system'](string.format([[start /b /min cmd /c "%s"]], get_fname(payload)))
  else
    f['system'](string.format("start %s", get_dname(payload)))
  end
end

local hide = function(payload)
  f['netrw#Call']("NetrwHide", 1)
end

local go_dir = function(payload)
  c(string.format("Ntree %s", get_dtarget(payload)))
end

local unfold_all = function(payload, start)
  if vim.w.netrw_liststyle ~= 3 then
    return
  end
  local lnr0 = (start == 0 or start == 3) and 0 or f['line']('.')
  local lnr00 =  f['line']('.')
  local lnr = lnr0 - 1
  local only_one = start == 2 and true or false
  local only_one_go = false
  local all = start == 3 and true or false
  local _, space_cnt0 = string.find(f['getline'](lnr + 1), '(%s+)')
  local cnt = 0
  while 1 do
    if lnr == f['line']('$') then
      break
    end
    lnr = lnr + 1
    local line = f['getline'](lnr)
    if string.sub(line, 1, 1) == '"' or string.sub(line, 1, 2) == './' then
      goto continue
    end
    if string.sub(line, 1, 3) == '../' then
      lnr = lnr + 1
      goto continue
    end
    if string.sub(line, #line, #line) == '/' then
      local unfold = false
      if lnr == f['line']('$') then
        local _, space_cnt = string.find(line, '(%s+)')
        if only_one and space_cnt <= space_cnt0 then
          if only_one_go then
            c(string.format([[norm %dgg]], lnr00))
            return
          end
          only_one_go = true
        end
        unfold = true
      end
      if unfold == false then
        local has_space, _ = string.find(line, '(%s+)')
        if has_space and has_space > 1 then
          goto continue
        else
          local _, space_cnt = string.find(line, '(%s+)')
          if only_one and space_cnt <= space_cnt0 then
            if only_one_go then
              c(string.format([[norm %dgg]], lnr00))
              return
            end
            only_one_go = true
          end
          local line_down = f['getline'](lnr + 1)
          local _, space_cnt_down = string.find(line_down, '(%s+)')
          if space_cnt >= space_cnt_down then
            unfold = true
          end
        end
      end
      if unfold then
        c(string.format('norm %dgg', lnr))
        local res = get_dname({ type = 0})
        if #res > 0 then
          res =string.gsub(res, '\\', '/')
        end
        f['netrw#LocalBrowseCheck'](res)
        if not all then
          cnt = cnt + 1
          if cnt > 10 then
            c[[ec 'unfold 10']]
            c(string.format([[norm %dgg]], lnr00))
            return
          end
        end
      end
    end
    ::continue::
  end
  c(string.format([[norm %dgg]], lnr00))
end

local fold_all = function(payload)
  if vim.w.netrw_liststyle ~= 3 then
    return
  end
  local lnr = 0
  while 1 do
    if lnr == f['line']('$') then
      break
    end
    lnr = lnr + 1
    local line = f['getline'](lnr)
    if string.sub(line, 1, 1) == '"' or string.sub(line, 1, 2) == './' then
      goto continue
    end
    if string.sub(line, 1, 3) == '../' then
      lnr = lnr + 1
      goto continue
    end
    if string.sub(line, #line, #line) == '/' then
      if lnr == f['line']('$') then
        return
      end
      local has_space, _ = string.find(line, '(%s+)')
      if has_space > 1 then
        goto continue
      else
        local _, space_cnt = string.find(line, '(%s+)')
        if space_cnt == 2 then
          local line_down = f['getline'](lnr + 1)
          local _, space_cnt_down = string.find(line_down, '(%s+)')
          if space_cnt_down == 4 then
            c(string.format('norm %dgg', lnr))
            f['netrw#LocalBrowseCheck'](f['netrw#Call']("NetrwBrowseChgDir", 1, f['netrw#Call']("NetrwGetWord"), 1))
          end
        end
      end
    end
    ::continue::
  end
end

local go_parent = function(payload)
  if vim.w.netrw_liststyle ~= 3 then
    return
  end
  local lnr0 = f['line']('.')
  local line0 = f['getline'](lnr0)
  local has_space, _ = string.find(line0, '(%s+)')
  if has_space > 1 then
    return
  end
  local _, space_cnt0 = string.find(line0, '(%s+)')
  for i=lnr0-1, 1, -1 do
    local line = f['getline'](i)
    local _, space_cnt = string.find(line, '(%s+)')
    if space_cnt and space_cnt < space_cnt0 then
      c(string.format([[norm %dgg]], i))
      return
    end
  end
end

local go_sibling = function(payload, dir)
  if vim.w.netrw_liststyle ~= 3 then
    return
  end
  local lnr0 = f['line']('.')
  local line0 = f['getline'](lnr0)
  local has_space, _ = string.find(line0, '(%s+)')
  if has_space > 1 then
    return
  end
  local _, space_cnt0 = string.find(line0, '(%s+)')
  if dir == 'up' then
    for i=lnr0-1, 1, -1 do
      local line = f['getline'](i)
      local _, space_cnt = string.find(line, '(%s+)')
      if not space_cnt then
        return
      end
      if space_cnt == space_cnt0 then
        c(string.format([[norm %dgg]], i))
        return
      end
    end
  else
    for i=lnr0+1, f['line']('$') do
      local line = f['getline'](i)
      local _, space_cnt = string.find(line, '(%s+)')
      if not space_cnt then
        return
      end
      if space_cnt == space_cnt0 then
        c(string.format([[norm %dgg]], i))
        return
      end
    end
  end
end

local search_fname = function(payload, dir)
  c(string.format([[call search("%s", "%s")]], g.netrw_alt_fname, dir == 'up' and 'b' or ''))
end

g.netrw_sel_list = {}
g.netrw_sel_list_bak = {}

local sel_toggle_cur = function(payload)
  local name = get_fname(payload)
  if name == '' then
    name = get_dname(payload)
  end
  local appendIfNotExists = function(t, s)
    local index_of = function(arr, val)
      if not arr then
        return nil
      end
      for i, v in ipairs(arr) do
        if v == val then
          return i
        end
      end
      return nil
    end
    local idx = index_of(t, s)
    local cwd = f['getcwd']()
    if not idx then
      table.insert(t, s)
      c(string.format([[ec 'attach: %s']], string.sub(s, #cwd+2, #s)))
    else
      table.remove(t, idx)
      s = string.gsub(s, f['getcwd'](), '')
      c(string.format([[ec 'detach: %s']], string.sub(s, #cwd+2, #s)))
    end
    return t
  end
  g.netrw_sel_list = appendIfNotExists(g.netrw_sel_list, name)
  c'norm j'
end

local sel_toggle_all = function(payload)
  if not g.netrw_sel_list or #g.netrw_sel_list == 0 then
    g.netrw_sel_list = g.netrw_sel_list_bak
    local show_array = function(arr)
      for i, v in ipairs(arr) do
        c(string.format([[ec '%d : %s']], i, v))
      end
    end
    show_array(g.netrw_sel_list)
  else
    c(string.format('ec "empty %d"', #g.netrw_sel_list))
    g.netrw_sel_list_bak = g.netrw_sel_list
    g.netrw_sel_list = {}
  end
end

local empty_sel_list = function(payload)
  g.netrw_sel_list = {}
  g.netrw_sel_list_bak = {}
end

local delete_sel_list = function(payload)
  local res = f['input']("Confirm deletion " .. #g.netrw_sel_list .. " [N/y] " ,"y")
  local index_of = function(arr, val)
    if not arr then
      return nil
    end
    for i, v in ipairs(arr) do
      if v == val then
        return i
      end
    end
    return nil
  end
  if index_of({'y', 'Y', 'yes', 'Yes', 'YES'}, res) then
    for i, v in ipairs(g.netrw_sel_list) do
      if Path:new(v):is_dir() then
        f['system'](string.format('rd /s /q "%s"', v))
      else
        f['system'](string.format('del "%s"', v))
      end
    end
    empty_sel_list()
  else
    c"echomsg 'canceled'"
  end
end

local move_sel_list = function(payload)
  local target = get_dtarget(payload)
  local res = f['input'](target .. "\nConfirm movment " .. #g.netrw_sel_list .. " [N/y] " ,"y")
  local index_of = function(arr, val)
    if not arr then
      return nil
    end
    for i, v in ipairs(arr) do
      if v == val then
        return i
      end
    end
    return nil
  end
  if index_of({'y', 'Y', 'yes', 'Yes', 'YES'}, res) then
    for i, v in ipairs(g.netrw_sel_list) do
      if Path:new(v):is_dir() then
        f['system'](string.format('move "%s" "%s"', string.sub(v, 1, #v-1), target))
      else
        f['system'](string.format('move "%s" "%s"', v, target))
      end
    end
    empty_sel_list()
  else
    c"echomsg 'canceled'"
  end
end

local copy_sel_list = function(payload)
  local target = get_dtarget(payload)
  local res = f['input'](target .. "\nConfirm copy " .. #g.netrw_sel_list .. " [N/y] " ,"y")
  local index_of = function(arr, val)
    if not arr then
      return nil
    end
    for i, v in ipairs(arr) do
      if v == val then
        return i
      end
    end
    return nil
  end
  if index_of({'y', 'Y', 'yes', 'Yes', 'YES'}, res) then
    for i, v in ipairs(g.netrw_sel_list) do
      if Path:new(v):is_dir() then
        local tname = get_fname_tail(v)
        f['system'](string.format('xcopy "%s" "%s%s\\" /s /e /f', string.sub(v, 1, #v-1), target, tname))
      else
        f['system'](string.format('copy "%s" "%s"', v, target))
      end
    end
    empty_sel_list()
  else
    c"echomsg 'canceled'"
  end
end

netrw.setup{
  use_devicons = true,
  mappings = {
    ['(f1)'] = function(payload) test(payload) end,
    ['(tab)'] = function(payload) preview(payload) end,
    ['(leftmouse)'] = function(payload) toggle_dir(payload) end,
    ['(2-leftmouse)'] = function(payload) preview_file(payload) end,
    ['(s-tab)'] = function(payload) preview_go(payload) end,
    ['q'] = function(payload) updir() end,
    ['o'] = function(payload) open(payload, 'here') end,
    ['do'] = function(payload) open(payload, 'here') end,
    ['dk'] = function(payload) open(payload, 'up') end,
    ['dj'] = function(payload) open(payload, 'down') end,
    ['dh'] = function(payload) open(payload, 'left') end,
    ['dl'] = function(payload) open(payload, 'right') end,
    ['di'] = function(payload) open(payload, 'tab') end,
    ['y'] = function(payload) copy_fname(payload) end,
    ['gy'] = function(payload) copy_fname_full(payload) end,
    ['cd'] = function(payload) chg_dir(payload) end,
    ['X'] = function(payload) explorer(payload) end,
    ['x'] = function(payload) system_start(payload) end,
    ['A'] = function(payload) hide(payload) end,
    ['a'] = function(payload) open(payload, 'here') end,
    ['O'] = function(payload) go_dir(payload) end,
    ['pf'] = function(payload) unfold_all(payload, 0) end,
    ['pr'] = function(payload) unfold_all(payload, 3) end,
    ['pe'] = function(payload) unfold_all(payload, 1) end,
    ['pd'] = function(payload) unfold_all(payload, 2) end,
    ['pw'] = function(payload) fold_all(payload) end,
    ['U'] = function(payload) go_parent(payload) end,
    ['K'] = function(payload) go_sibling(payload, 'up') end,
    ['J'] = function(payload) go_sibling(payload, 'down') end,
    ['dp'] = function(payload) search_fname(payload, 'up') end,
    ['dn'] = function(payload) search_fname(payload, 'down') end,
    ['\''] = function(payload) sel_toggle_cur(payload) end,
    ['"'] = function(payload) sel_toggle_all(payload) end,
    ['dE'] = function(payload) empty_sel_list(payload) end,
    ['dD'] = function(payload) delete_sel_list(payload) end,
    ['dM'] = function(payload) move_sel_list(payload) end,
    ['dC'] = function(payload) copy_sel_list(payload) end,
  },
}
