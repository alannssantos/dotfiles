map <Tab> :bn<CR>
map <leader>q :bw<CR>
map <leader>o :set spell!<CR>
map <leader>n :%!nl -n rz -w3<CR>
map <leader>p :call Preview()<CR>
map <leader>c :call Compiler()<CR><CR>
map <leader>s :!clear && shellcheck -x %<CR>
map <leader>t :!tmux split-window -v -p 20<CR>
