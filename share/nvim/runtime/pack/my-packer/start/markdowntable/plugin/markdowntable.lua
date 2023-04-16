local g = vim.g
local f = vim.fn
local a = vim.api
local c = vim.cmd
local s = vim.keymap.set

g.markdowntable_lua = f['expand']('<sfile>')

local markdowntable = function(params)
  if not g.markdowntable_loaded then
    g.markdowntable_loaded = 1
    a.nvim_del_autocmd(g.markdowntable_cursormoved)
    sta, do_markdowntable = pcall(require, 'do_markdowntable')
    if not sta then
      print("no do_markdowntable")
      return
    end
  end
  if not do_markdowntable then
    return
  end
  do_markdowntable.run(params)
end

if not g.markdowntable_startup then
  g.markdowntable_startup = 1
  g.markdowntable_cursormoved = a.nvim_create_autocmd({"CursorMoved"}, {
    callback = function()
      a.nvim_del_autocmd(g.markdowntable_cursormoved)
      markdowntable()
    end,
  })
end

a.nvim_create_user_command('MarkdowntablE', function(params)
  markdowntable(params['fargs'])
end, { nargs = "*", })

local opt = {silent = true}

s({'n', 'v'}, '<leader><leader>ta', ':MarkdowntablE align<cr>', opt)
