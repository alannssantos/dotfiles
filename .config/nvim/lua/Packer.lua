local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  vim.cmd 'packadd packer.nvim'
end

return require('packer').startup(function()
  -- Packer Auto Gerenciamento.
  use 'wbthomason/packer.nvim'
  -- Tema.
  use 'sainnhe/everforest'
  use 'ellisonleao/glow.nvim'
  use 'norcalli/nvim-colorizer.lua'
  -- Endentação.
  use 'windwp/nvim-autopairs'
  use 'terrortylor/nvim-comment'
  -- Gerenciamento de Arquivo.
  use { 'ibhagwan/fzf-lua',
    requires = {'vijaymarupudi/nvim-fzf'}
  }
  -- Mapeamento de Teclas.
  use 'folke/which-key.nvim'
  -- Auto-complete & LSP Conf
  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-path'
  use 'L3MON4D3/LuaSnip'
  use 'f3fora/cmp-spell'
  use 'octaltree/cmp-look'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'saadparwaiz1/cmp_luasnip'
  use 'williamboman/nvim-lsp-installer'
end)
