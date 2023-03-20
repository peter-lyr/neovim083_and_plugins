local o = vim.opt

local tab_width = function()
  if o.filetype:get() == 'c' or o.filetype:get() == 'cpp' then
    o.tabstop = 4
    o.softtabstop = 4
    o.shiftwidth = 4
  else
    o.tabstop = 2
    o.softtabstop = 2
    o.shiftwidth = 2
  end
end

vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
  -- pattern = {"*.c", "*.h"},
  callback = tab_width,
})
