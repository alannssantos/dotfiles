"     _    _
"    / \  | | __ _ _ __  _ __      Alann Santos
"   / _ \ | |/ _` | '_ \| '_ \     https://github.com/alannssantos
"  / ___ \| | (_| | | | | | | |
" /_/   \_\_|\__,_|_| |_|_| |_|

" {{{ ----------------------------- Plugins Begin -----------------------------
"
" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  "autocmd VimEnter * PlugInstall
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/plugged')

	" ==== Themes
	Plug 'morhetz/gruvbox'                " Gruvbox Theme
	Plug 'ryanoasis/vim-devicons'
	Plug 'vim-airline/vim-airline'        " Airline
	Plug 'vim-airline/vim-airline-themes'	" Airline Themes

	" ==== Syntax
	Plug 'sheerun/vim-polyglot'
	Plug 'preservim/nerdcommenter'
	Plug 'ntpeters/vim-better-whitespace'
	Plug 'neoclide/coc.nvim', {'branch': 'release'}

	" ==== Utility
	Plug 'junegunn/fzf'
	Plug 'junegunn/fzf.vim'
	Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & npm install'  }

" All of your Plugins must be added before the following line
call plug#end()            " required

" Automatically install missing plugins on startup
autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | q
  \| endif

" }}} ----------------------------- Plugins End -----------------------------
" {{{ --------------------------- Plug-config Begin ---------------------------
" {{{ --------------------------- Coc-config Begin  ---------------------------

" Coc Explorer
nnoremap <space><Tab> :CocCommand explorer<CR>

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Set Prettier
command! -nargs=0 Prettier :CocCommand prettier.formatFile

" coc config
let g:coc_global_extensions = [
  \ 'coc-sh',
  \ 'coc-json',
  \ 'coc-pairs',
  \ 'coc-eslint',
  \ 'coc-python',
  \ 'coc-texlab',
  \ 'coc-flutter',
  \ 'coc-explorer',
  \ 'coc-prettier',
  \ 'coc-snippets',
  \ 'coc-tsserver',
  \ ]
" }}} --------------------------- Coc-config End  ---------------------------
" {{{ -------------------------- Airline-config Begin -------------------------
" vim-devicons
let g:DevIconsEnableFoldersOpenClose = 1

let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols = {}
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['html'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['js'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['json'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['jsx'] = 'ﰆ'
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['md'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['vim'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['yaml'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['yml'] = ''

let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols = {}
let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols['.*vimrc.*'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols['.gitignore'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols['package.json'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols['package.lock.json'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols['node_modules'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols['webpack\.'] = 'ﰩ'

let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 0
let g:airline_theme='angr'
" }}} -------------------------- Airline-config End -------------------------
" }}} --------------------------- Plug-config End -----------------------------
" {{{ ----------------------------- Settings Begin -----------------------------
" Leader key
let mapleader="\<space>"

set hidden
set number
set confirm
set hlsearch
set nobackup
set wildmenu
set path+=**
set incsearch
set cmdheight=2
set smartindent
set laststatus=2
set shortmess+=c
set nowritebackup
set encoding=UTF-8
set updatetime=300
set foldmethod=marker
set clipboard=unnamedplus

" Theme
colorscheme gruvbox
hi Normal ctermbg=none
" Maps
map <Tab> :bn<CR>
map <leader>q :bw<CR>
map <leader>f :FZF -e<CR>
map <leader>p :call Preview()<CR>
map <leader>c :call Compiler()<CR><CR>
map <leader>s :!clear && shellcheck -x %<CR>
map <leader>t :!tmux split-window -v -p 20<CR>
map <leader>nl :%s/^/\=printf('%03d', line('.'))<CR>

" Functions
" Preview Function
function! Preview()
	if &filetype ==# 'tex'
		execute ":LLPStartPreview"
	elseif &filetype ==# 'markdown'
		execute ":MarkdownPreview"
	else
		echom "This file doesn’t have preview."
	endif
endfunction
" Complile Function
function! Compiler()
	if &filetype ==# 'tex'
		execute ":w! \| !pdflatex %"
	else
		echom "This file doesn’t have compiler."
	endif
endfunction

au! BufWritePost $MYVIMRC source %
" }}} ----------------------------- Settings End -----------------------------
