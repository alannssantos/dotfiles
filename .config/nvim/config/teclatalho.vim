map <Tab> :bn<CR>
map <leader>q :bw<CR>
map <leader>f :FZF -e<CR>
map <leader>p :call Preview()<CR>
map <leader>c :call Compiler()<CR><CR>
map <leader>s :!clear && shellcheck -x %<CR>
map <leader>t :!tmux split-window -v -p 20<CR>
map <leader>nl :%s/^/\=printf('%03d', line('.'))<CR>
