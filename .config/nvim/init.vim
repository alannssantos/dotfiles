"     _    _
"    / \  | | __ _ _ __  _ __      Alann Santos
"   / _ \ | |/ _` | '_ \| '_ \     https://github.com/alannssantos
"  / ___ \| | (_| | | | | | | |
" /_/   \_\_|\__,_|_| |_|_| |_|

let mapleader=" "

set title
set hidden
set nospell
set number
set confirm
set hlsearch
set wildmenu
set expandtab
set incsearch
set path=+=**
set splitbelow
set splitright
set smartindent
set spelllang=pt
set laststatus=2
set shiftwidth=2
set showtabline=2
set softtabstop=2
set foldmethod=marker
set clipboard=unnamedplus
set guifont=Fira\ Code:h11

" mapping
nnoremap <Tab> :tabn<CR>
nnoremap <leader>e :Texplore<CR>
nnoremap <leader>o :setlocal spell! spelllang=pt<CR>

" netrw: config
let g:netrw_altv=1
let g:netrw_winsize=25
let g:netrw_liststyle=3
let g:netrw_browse_split=3
