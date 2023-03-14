local g = vim.g
local s = vim.keymap.set

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
