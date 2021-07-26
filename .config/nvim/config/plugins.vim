" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  "autocmd VimEnter * PlugInstall
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/plugged')

	" Tema e Status Bar.
	Plug 'morhetz/gruvbox'
	Plug 'ryanoasis/vim-devicons'
	Plug 'vim-airline/vim-airline'
	Plug 'kyazdani42/nvim-web-devicons'
	Plug 'vim-airline/vim-airline-themes'

	" Sintaxes.
	Plug 'vimwiki/vimwiki'
	Plug 'ap/vim-css-color'
	Plug 'latex-lsp/texlab'
	Plug 'hrsh7th/nvim-compe'
	Plug 'jiangmiao/auto-pairs'
	Plug 'neovim/nvim-lspconfig'
	Plug 'preservim/nerdcommenter'
	Plug 'liuchengxu/vim-which-key'
	Plug 'ntpeters/vim-better-whitespace'

	" Gerenciar arquivos.
	Plug 'junegunn/fzf'
	Plug 'junegunn/fzf.vim'
	Plug 'kyazdani42/nvim-tree.lua'

	" Preview de arquivos.
	Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & npm install'  }

call plug#end()

" Automatically install missing plugins on startup
autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | q
  \| endif
