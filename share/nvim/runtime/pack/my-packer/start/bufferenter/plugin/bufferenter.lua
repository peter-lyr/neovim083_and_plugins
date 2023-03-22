local g = vim.g
local a = vim.api
local o = vim.opt
local s = vim.keymap.set

local bufenter = function()
  if o.ft:get() == 'lua' then
    s({'n', 'v'}, 'K', '<nop>', {buffer = true})
  end
end

a.nvim_create_autocmd({"BufEnter"}, {
  callback = bufenter,
})
