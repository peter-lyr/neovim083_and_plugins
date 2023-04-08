local M = {}

local g = vim.g
local b = vim.b
local f = vim.fn
local c = vim.cmd
local o = vim.opt
local a = vim.api
local m = string.match
local s = vim.keymap.set

local is_terminal = function(bufname, terminal)
  if m(bufname, '^term://') then
    local ret = false
    local is_ipython = m(bufname, ':ipython$')
    local is_bash = m(bufname, ':bash$')
    local is_powershell = m(bufname, ':powershell$')
    local is_cmd = m(bufname, ':cmd$')
    if terminal == 'ipython' and is_ipython then
      return true, true
    elseif terminal == 'bash' and is_bash then
      return true, true
    elseif terminal == 'powershell' and is_powershell then
      return true, true
    elseif terminal == 'cmd' and is_cmd then
      return true, true
    else
      return true, false
    end
  end
  return false, false
end

local try_goto_terminal = function()
  for i = 1, f['winnr']('$') do
    local bufnr = f['winbufnr'](i)
    local buftype = f['getbufvar'](bufnr, '&buftype')
    if buftype == 'terminal' then
      f['win_gotoid'](f['win_getid'](i))
      return true
    end
  end
  return false
end

local get_terminal_bufnrs = function(terminal)
  local terminal_bufnrs = {}
  for k, v in pairs(f['getbufinfo']()) do
    local one, certain = is_terminal(v['name'], terminal)
    if certain then
      table.insert(terminal_bufnrs, v['bufnr'])
    end
  end
  if #terminal_bufnrs == 0 then
    return nil
  end
  return terminal_bufnrs
end

function index_of(arr, val)
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

local Path = require "plenary.path"

function M.get_dname(readablefile)
  if #readablefile == 0 then
    return ''
  end
  local fname = string.gsub(readablefile, "\\", '/')
  local path = Path:new(fname)
  if path:is_file() then
    return path:parent()['filename']
  end
  return ''
end

function M.toggle_terminal(terminal, chdir)
  if g.builtin_terminal_ok == 0 then
    c(string.format('silent !start %s', terminal))
    return
  end
  local fname = a['nvim_buf_get_name'](0)
  local bnr = f['bufnr']()
  local terminal_bufnrs = get_terminal_bufnrs(terminal)
  local one, certain = is_terminal(fname, terminal)
  if certain then
    if #chdir > 0 then
      if chdir == '.' then
        chdir = M.get_dname(g.bufleave_readablefile)
      elseif chdir == 'u' then
        chdir = '..'
      elseif chdir == '-' then
        chdir = '-'
      end
      local chdir = string.gsub(chdir, "\\", '/')
      a['nvim_chan_send'](b.terminal_job_id, string.format('cd %s', chdir))
      if terminal == 'ipython' then
        f['feedkeys']([[:call feedkeys("i\<cr>\<esc>")]])
        local t0 = os.clock()
        while os.clock() - t0 <= 0.02 do end
        c[[call feedkeys("\<cr>")]]
      else
        c[[call feedkeys("i\<cr>\<esc>")]]
      end
      return
    else
      if #terminal_bufnrs == 1 then
        if is_hide_en() then
          c'hide'
        end
        return
      end
    end
    bnr_idx = index_of(terminal_bufnrs, f['bufnr']())
    bnr_idx = bnr_idx + 1
    if bnr_idx > #terminal_bufnrs then
      if is_hide_en() then
        c'hide'
      end
      return
    else
      c(string.format("b%d", terminal_bufnrs[bnr_idx]))
    end
  else
    if terminal_bufnrs then
      if not try_goto_terminal() then
        if #fname > 0 or o.modified:get() == true then
          c'split'
        end
      end
      c(string.format("b%d", terminal_bufnrs[1]))
    else
      if not one then
        c'split'
      end
      c(string.format('te %s', terminal))
    end
    if #chdir > 0 then
      M.toggle_terminal(terminal, chdir)
    end
  end
end

return M
