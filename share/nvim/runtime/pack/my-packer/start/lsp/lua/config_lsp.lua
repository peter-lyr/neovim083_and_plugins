local f = vim.fn

local sta, mason = pcall(require, "mason")
if not sta then
  print('no mason')
  return
end

local sta, mason_lspconfig = pcall(require, "mason-lspconfig")
if not sta then
  print('no mason-lspconfig')
  return
end

local sta, lspconfig = pcall(require, "lspconfig")
if not sta then
  print('no lspconfig')
  return
end

mason.setup({
  install_root_dir = f.expand("$VIMRUNTIME") .. "\\my-neovim-data\\mason",
})

mason_lspconfig.setup({
  ensure_installed = {
    "clangd",
  }
})

lspconfig.clangd.setup({
})
