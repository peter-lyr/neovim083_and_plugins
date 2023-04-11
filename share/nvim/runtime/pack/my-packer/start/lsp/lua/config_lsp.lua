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
    "pyright",
  }
})

local sta, util = pcall(require, 'lspconfig.util')
if not sta then
  print('no lspconfig.util')
  return
end

local sta, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
if not sta then
  print('no cmp_nvim_lsp')
  return
end

capabilities = cmp_nvim_lsp.default_capabilities()

lspconfig.clangd.setup({
  capabilities = capabilities,
  root_dir = function(fname)
    local root_files = {
      '.clangd',
      '.clang-tidy',
      '.clang-format',
      'compile_commands.json',
      'compile_flags.txt',
      'configure.ac',
      '.git',
      '.svn',
    }
    return util.root_pattern(unpack(root_files))(fname) or util.find_git_ancestor(fname)
  end,
})

lspconfig.pyright.setup({
  capabilities = capabilities,
  root_dir = function(fname)
    local root_files = {
      'pyproject.toml',
      'setup.py',
      'setup.cfg',
      'requirements.txt',
      'Pipfile',
      'pyrightconfig.json',
      '.git',
      '.svn',
    }
    return util.root_pattern(unpack(root_files))(fname) or util.find_git_ancestor(fname)
  end,
})
