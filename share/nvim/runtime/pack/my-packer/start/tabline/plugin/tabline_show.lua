local g = vim.g
local o = vim.opt
local c = vim.cmd
local a = vim.api
local f = vim.fn

local get_fname_tail = function(fname)
  local fname = string.gsub(fname, "\\", '/')
  local sta, path = pcall(require, "plenary.path")
  if not sta then
    print('tabline_show no plenary.path')
    return ''
  end
  local path = path:new(fname)
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

g.set_tabline = a.nvim_create_autocmd({"TabEnter"}, {
  callback = function()
    a.nvim_del_autocmd(g.set_tabline)
    c([[set tabline=%!tabline#tabline()]])
  end,
})

a.nvim_create_autocmd({"WinLeave"}, {
  callback = function()
    local timer = vim.loop.new_timer()
    timer:start(100, 750, vim.schedule_wrap(function()
      timer:close()
      local title = get_fname_tail(f['getcwd']())
      if #title > 0 then
        o.titlestring = title
      end
    end))
  end,
})
