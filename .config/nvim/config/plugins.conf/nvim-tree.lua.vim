" Inciar NvimTree quando for passado um diretório como argumento.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') |
    \ execute 'cd '.argv()[0] | execute 'NvimTreeOpen'

let g:nvim_tree_show_icons = {
    \ 'git': 0,
    \ 'folders': 1,
    \ 'files': 1,
    \ 'folder_arrows': 1,
    \ }

highlight NvimTreeSymlink guifg=#66cccc
highlight NvimTreeExecFile guifg=#99cc99
highlight NvimTreeImageFile guifg=#ffcc66
highlight NvimTreeFolderIcon guifg=#6699cc gui=bold
highlight NvimTreeFolderName guifg=#6699cc gui=bold
highlight NvimTreeRootFolder guifg=#99cc99 gui=bold
highlight NvimTreeSpecialFile guifg=#66cccc
highlight NvimTreeIndentMarker guifg=#99cc99
highlight NvimTreeEmptyFolderName guifg=#66cccc
highlight NvimTreeOpenedFolderName guifg=#6699cc gui=bold

let g:nvim_tree_auto_close = 1
