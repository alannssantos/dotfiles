" Inciar NvimTree quando for passado um diretório como argumento.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') |
    \ execute 'cd '.argv()[0] | execute 'NvimTreeOpen'

nnoremap <leader><Tab> :NvimTreeToggle<CR>
nnoremap <leader>r :NvimTreeRefresh<CR>
nnoremap <leader>n :NvimTreeFindFile<CR>

let g:nvim_tree_auto_close = 1
