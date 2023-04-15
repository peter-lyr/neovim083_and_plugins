local o = vim.opt
local g = vim.g
local a = vim.api
local c = vim.cmd
local s = vim.keymap.set

local do_quickfix = nil
local cnt = 0

local function init()
  if not g.loaded_do_quickfix then
    g.loaded_do_quickfix = 1
    do_quickfix = nil
    sta, do_quickfix = pcall(require, 'do_quickfix')
    if not sta then
      print('no do_quickfix')
      return
    end
  end
  if cnt < 8 then
    cnt = cnt + 1
    print(string.format([[cnt: 0x%x(%d)]], cnt, cnt))
    c([[
      hi BqfPreviewBorder guifg=#50a14f ctermfg=71
      hi link BqfPreviewRange Search
    ]])
  end
end

local quickfix_exe = function()
  init()
  if not do_quickfix then
    return
  end
  do_quickfix.toggle()
end

if not g.quickfix_loaded then
  g.quickfix_loaded = 1
  g.quickfix_cursormoved = a.nvim_create_autocmd({"BufEnter"}, {
    callback = function()
      if o.ft:get() == 'qf' then
        a.nvim_del_autocmd(g.quickfix_cursormoved)
      end
      init()
    end,
  })
end

a.nvim_create_user_command('QuickFix', function(params)
  quickfix_exe()
end, { nargs = "*", })

s({ 'n', 'v' }, '<leader><leader>d', ':QuickFix toggle<cr>', { silent = true })
