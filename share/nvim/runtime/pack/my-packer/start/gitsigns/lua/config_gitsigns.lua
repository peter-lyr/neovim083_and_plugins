local sta, gitsigns = pcall(require, "gitsigns")
if not sta then
  return
end

gitsigns.setup({
  current_line_blame = true,
  current_line_blame_opts = {
    delay = 120,
  },
})
