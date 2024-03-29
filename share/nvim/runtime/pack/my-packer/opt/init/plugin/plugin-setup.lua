-- if 1 then
--   return
-- end

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
  use({'xolox/vim-session', opt = true})

  use('rafi/awesome-vim-colorschemes')
  use('EdenEast/nightfox.nvim')
  use('folke/tokyonight.nvim')

  -- use({ 'nvim-telescope/telescope.nvim', branch = '0.1.x', opt = true }) -- 不再更新官方修改

  use({"dstein64/vim-startuptime", opt = true})

  use("nvim-tree/nvim-tree.lua")

  use({"preservim/nerdcommenter", opt = true})

  use("jghauser/mkdir.nvim")

  use("windwp/nvim-autopairs")

  use({"bitc/vim-bad-whitespace", opt = true})

  use("lewis6991/gitsigns.nvim")
  use({"tpope/vim-fugitive", opt = true})
  use({"sindrets/diffview.nvim", opt = true})

  use("nvim-tree/nvim-web-devicons")

  -- use("ahmedkhalf/project.nvim") -- 不再更新官方修改
  use("dbakker/vim-projectroot")

  use({"lukas-reineke/indent-blankline.nvim", opt = true})

  use({"tpope/vim-surround", opt = true})

  use({"phaazon/hop.nvim", branch = 'v2', opt = true})

  use("stevearc/aerial.nvim")

  use({"nvim-treesitter/nvim-treesitter", run = ":TSUpdate", opt = true})
  use({"p00f/nvim-ts-rainbow", opt = true})
  use({"nvim-treesitter/nvim-treesitter-context", opt = true})

  use({"MattesGroeger/vim-bookmarks", opt = true})
  use("tom-anders/telescope-vim-bookmarks.nvim")

	use("nvim-telescope/telescope-ui-select.nvim")

  use({"neovim/nvim-lspconfig", opt = true})
  use("williamboman/mason.nvim")
  use("williamboman/mason-lspconfig.nvim")

  use('skywind3000/asyncrun.vim')

  use({"dstein64/nvim-scrollview", opt = true})

  use({'google/vim-searchindex', opt = true})

  use("CRAG666/code_runner.nvim")

  use({"iamcco/markdown-preview.nvim", run = function() vim.fn["mkdp#util#install"]() end })

  use({'hrsh7th/nvim-cmp', opt = true})
  -- use({'hrsh7th/cmp-nvim-lsp', opt = true}) -- 不再更新官方修改
  -- use({'hrsh7th/cmp-buffer', opt = true}) -- 不再更新官方修改
  -- use({'hrsh7th/cmp-path', opt = true}) -- 不再更新官方修改
  -- use({'hrsh7th/cmp-cmdline', opt = true}) -- 不再更新官方修改
  -- use({"SirVer/ultisnips", opt = true}) -- 不再更新官方修改
  -- use({"quangnguyen30192/cmp-nvim-ultisnips", opt = true}) -- 不再更新官方修改

  use("folke/which-key.nvim")

  use({"kevinhwang91/nvim-bqf", opt = true})

  use("azabiong/vim-highlighter")

  use("honza/vim-snippets")

end

return packer.startup(function(use)
  use('wbthomason/packer.nvim')
  -- use('nvim-lua/plenary.nvim') -- 不再更新官方修改
  -- use('prichrd/netrw.nvim') -- 不再更新官方修改

  plugins(use)

  if packer_bootstrap then
    print('packer sync...')
    require('packer').sync()
    print('sync done!')
  end
end)
