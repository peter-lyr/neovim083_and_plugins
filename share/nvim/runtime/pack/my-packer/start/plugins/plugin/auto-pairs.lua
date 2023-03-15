local sta, autopairs = pcall(require, "nvim-autopairs")
if not sta then
  return
end

autopairs.setup()
