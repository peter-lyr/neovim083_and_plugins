local f = vim.fn
local s = vim.keymap.set

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
    "lua_ls",
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

lspconfig.lua_ls.setup({
  capabilities = capabilities,
  root_dir = function(fname)
    local root_files = {
      -- '.luarc.json',
      -- '.luarc.jsonc',
      -- '.luacheckrc',
      -- '.stylua.toml',
      -- 'stylua.toml',
      -- 'selene.toml',
      -- 'selene.yml',
      '.git',
      '.svn',
    }
    return util.root_pattern(unpack(root_files))(fname) or util.find_git_ancestor(fname)
  end,
})


local a = vim.api
local c = vim.cmd
local b = vim.lsp.buf
local d = vim.diagnostic


s('n', '[f', d.open_float)
s('n', ']f', d.setloclist)
s('n', '[d', d.goto_prev)
s('n', ']d', d.goto_next)


s('n', '<leader>fS', function() c('LspStart') end)
s('n', '<leader>fE', function() c('LspRestart') end)
s('n', '<leader>fD', function() c([[call feedkeys(":LspStop ")]]) end)
s('n', '<leader>fF', function() c('LspInfo') end)


vim.api.nvim_create_autocmd('LspAttach', {
  group = a.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
    local opts = { buffer = ev.buf }
    s('n', 'K', b.definition, opts)
    s('n', '<leader>fd', b.declaration, opts)
    s('n', '<leader>fh', b.hover, opts)
    s('n', '<leader>fi', b.implementation, opts)
    s('n', '<leader>fs', b.signature_help, opts)
    s('n', '<leader>fe', b.references, opts)
    s('n', '<leader><leader>fd', b.type_definition, opts)
    s('n', '<leader>fn', b.rename, opts)
    s('n', '<leader>ff', function() b.format { async = true } end, opts)
    s({ 'n', 'v' }, '<leader>fc', b.code_action, opts)
  end,
})
