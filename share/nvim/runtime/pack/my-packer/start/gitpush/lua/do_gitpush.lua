local M = {}

local g = vim.g
local f = vim.fn
local a = vim.api
local c = vim.cmd

local Path = require "plenary.path"
local p6 = Path:new(g.gitpush_lua)

g.gitpush_dir = p6:parent():parent()['filename']
local p6 = Path:new(g.gitpush_dir)

M.add_commit = p6:joinpath('autoload', 'add_commit.bat')['filename']
M.add_commit_push = p6:joinpath('autoload', 'add_commit_push.bat')['filename']
M.commit_push = p6:joinpath('autoload', 'commit_push.bat')['filename']
M.git_init = p6:joinpath('autoload', 'git_init.bat')['filename']
M.just_commit = p6:joinpath('autoload', 'just_commit.bat')['filename']
M.just_push = p6:joinpath('autoload', 'just_push.bat')['filename']

local _show_array = function (arr)
  for i, v in ipairs(arr) do
    print(i, ':', v)
  end
end

local get_fname_tail = function(fname)
  local fname = string.gsub(fname, "\\", '/')
  local sta, p5 = pcall(require, "plenary.path")
  if not sta then
    print('do_gitpush no plenary.path')
    return ''
  end
  local p5 = p5:new(fname)
  if p5:is_file() then
    local fname = p5:_split()
    return fname[#fname]
  elseif p5:is_dir() then
    local fname = p5:_split()
    if #fname[#fname] > 0 then
      return fname[#fname]
    else
      return fname[#fname-1]
    end
  end
  return ''
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

function M.do_gitpush(cmd)
  if cmd == "add_commit" then
    cc = M.add_commit
  elseif cmd == "add_commit_push" then
    cc = M.add_commit_push
  elseif cmd == "commit_push" then
    cc = M.commit_push
  elseif cmd == "git_init" then
    cc = M.git_init
  elseif cmd == "just_commit" then
    cc = M.just_commit
  elseif cmd == "just_push" then
    cc = M.just_push
  end
  if cmd == "git_init" then
    local fname = a['nvim_buf_get_name'](0)
    local p1 = Path:new(fname)
    if not p1:is_file() then
      c'ec "not file"'
      return
    end
    if not g.loaded_config_telescope then
      local sta, exe_telescope = pcall(require, 'exe_telescope')
      if not sta then
        print("no exe_telescope")
        return
      end
      exe_telescope.exe_telescope('')
    end
    local d = {}
    for i=1, 24 do
      p1 = p1:parent()
      name = p1['filename']
      name = string.gsub(name, '\\', '/')
      table.insert(d, name)
      if not string.match(name, '/') then
        break
      end
    end
    vim.ui.select(d, { prompt = 'git init' }, function(choice, idx)
      if not choice then
        return
      end
      local dpath = choice
      local remote_dname = get_fname_tail(dpath)
      if remote_dname == '' then
        return
      end
      local remote_dname = '.git-' .. remote_dname
      f['system'](string.format('cd %s && start cmd /c "%s %s"', dpath, cc, remote_dname))
      local fname = dpath .. '/.gitignore'
      p3 = Path.new(fname)
      if p3:is_file() then
        local lines = f['readfile'](fname)
        if not index_of(lines, remote_dname) then
          f['writefile']({remote_dname}, fname, "a")
        end
      else
        f['writefile']({remote_dname}, fname, "a")
      end
    end)
  else
    f['system'](string.format('cd %s && start cmd /c "%s"', Path:new(a['nvim_buf_get_name'](0)):parent()['filename'], cc))
  end
end

return M
