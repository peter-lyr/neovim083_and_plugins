local g = vim.g
local s = vim.keymap.set
local a = vim.api
local c = vim.cmd

if not g.commenter_loaded then
  g.commenter_loaded = 1
  g.commenter_cursormoved = a.nvim_create_autocmd({"CursorMoved"}, {
    callback = function()
      a.nvim_del_autocmd(g.commenter_cursormoved)
      local sta, _ = pcall(c, 'packadd nerdcommenter')
      if not sta then
        print("no commenter")
        return
      end
    end,
  })
end

g.NERDSpaceDelims = 1
g.NERDDefaultAlign = "left"
g.NERDCommentEmptyLines = 1
g.NERDTrimTrailingWhitespace = 1
g.NERDToggleCheckAllLines = 1

g.NERDAltDelims_c = 1

s({'n', 'v'}, '<leader>cp', "vip:call nerdcommenter#Comment('x', 'toggle')<CR>", {silent = true})
s({'n', 'v'}, '<leader>c}', "V}k:call nerdcommenter#Comment('x', 'toggle')<CR>", {silent = true})
s({'n', 'v'}, '<leader>c{', "V{j:call nerdcommenter#Comment('x', 'toggle')<CR>", {silent = true})
s({'n', 'v'}, '<leader>cG',  "VG:call nerdcommenter#Comment('x', 'toggle')<CR>", {silent = true})
