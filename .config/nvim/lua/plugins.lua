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
  use 'Th3Whit3Wolf/one-nvim'
  use 'norcalli/nvim-colorizer.lua'
  use 'kyazdani42/nvim-web-devicons'
  -- Endentação.
  use { 'vimwiki/vimwiki',
    config = vim.cmd([[let g:vimwiki_key_mappings = { 'all_maps': 0, }]])
  }
  use 'windwp/nvim-autopairs'
  use 'terrortylor/nvim-comment'
  -- Gerenciamento de Arquivo.
  use 'lambdalisue/suda.vim'
  use 'kyazdani42/nvim-tree.lua'
  use { 'ibhagwan/fzf-lua',
    requires = {'vijaymarupudi/nvim-fzf'}
  }
  -- Mapeamento de Teclas.
  use 'folke/which-key.nvim'
  -- Auto-complete & LSP Conf
  use 'neovim/nvim-lspconfig'
  use {'hrsh7th/nvim-compe',
    requires = {'hrsh7th/vim-vsnip'}
  }
end)
