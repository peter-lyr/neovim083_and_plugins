local g = vim.g
local a = vim.api
local c = vim.cmd
local s = vim.keymap.set

local quickfix_exe = function()
  if not g.loaded_do_quickfix then
    g.loaded_do_quickfix = 1
    do_quickfix = nil
    sta, do_quickfix = pcall(require, 'do_quickfix')
    if not sta then
      print('no do_quickfix')
      return
    end
    sta, nvim_bqf = pcall(c, 'packadd nvim-bqf')
    if not sta then
      print('no nvim-bqf')
      return
    end
    local sta, bqf = pcall(require, "bqf")
    if sta then
      bqf.setup({
        auto_resize_height = true,
        preview = {
          win_height = 28,
          win_vheight = 28,
          wrap = true,
        },
      })
    end
  end
  c([[
hi BqfPreviewBorder guifg=#50a14f ctermfg=71
hi link BqfPreviewRange Search
]])
  if not do_quickfix then
    return
  end
  do_quickfix.toggle()
end

a.nvim_create_user_command('QuickFix', function(params)
  quickfix_exe()
end, { nargs = "*", })

s({ 'n', 'v' }, '<leader><leader>d', ':QuickFix toggle<cr>', { silent = true })
