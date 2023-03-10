local en = 0
if en then
else
local fn = vim.fn

local ensure_packer = function()
  local install_path = fn.expand('$VIMRUNTIME') .. '\\pack\\packer\\start\\packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    print('git clone packer.nvim...')
    fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
    print('clone dnoe!')
    vim.cmd('packadd packer.nvim')
    return true
  end
  return false
end
local packer_bootstrap = ensure_packer()

local sta, packer = pcall(require, 'packer')
if not sta then
  return
end

packer.init({
  package_root = fn.expand('$VIMRUNTIME') .. '\\pack',
  compile_path = fn.expand('$VIMRUNTIME') .. '\\plugin'
})

local plugins = function(use)

  use('907th/vim-auto-save')
  use('xolox/vim-misc')
  use('xolox/vim-session')

  use('rafi/awesome-vim-colorschemes')
  use('EdenEast/nightfox.nvim')
  use('folke/tokyonight.nvim')

  use({ 'nvim-telescope/telescope.nvim', branch = '0.1.x' })

  use("dstein64/vim-startuptime")

  use("nvim-tree/nvim-tree.lua")

  use("preservim/nerdcommenter")

  use("jghauser/mkdir.nvim")

  use("windwp/nvim-autopairs")

  use("bitc/vim-bad-whitespace")

  use("lewis6991/gitsigns.nvim")
  use("tpope/vim-fugitive")
  use("sindrets/diffview.nvim")

  use("kyazdani42/nvim-web-devicons")

end

return packer.startup(function(use)
  use('wbthomason/packer.nvim')
  use('nvim-lua/plenary.nvim')

  plugins(use)

  if packer_bootstrap then
    print('packer sync...')
    require('packer').sync()
    print('sync done!')
  end
end)
end
