" Leader key
let mapleader="\<space>"

set number
set confirm
set hlsearch
set path+=**
set wildmenu
set incsearch
set smartindent
set laststatus=2
set termguicolors
set cursorline
set foldmethod=marker
set clipboard=unnamedplus
set spell spelllang=pt

au! BufWritePost $MYVIMRC source %
