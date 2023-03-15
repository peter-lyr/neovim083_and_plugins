local M = {}

local c = vim.cmd

function M.cmd(cmd, refresh)
  c(cmd)
  if refresh == 1 then
    c'e!'
  end
end

return M
