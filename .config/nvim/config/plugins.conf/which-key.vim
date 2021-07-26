" Map leader to which_key
nnoremap <silent> <leader> :silent WhichKey '<Space>'<CR>
vnoremap <silent> <leader> :silent <c-u> :silent WhichKeyVisual '<Space>'<CR>

" Create map to add keys to
let g:which_key_map =  {}
" Define a separator
let g:which_key_sep = '→'
" set timeoutlen=100


" Not a fan of floating windows for this
let g:which_key_use_floating_win = 0

" Change the colors if you want
highlight default link WhichKey          Operator
highlight default link WhichKeySeperator DiffAdded
highlight default link WhichKeyGroup     Identifier
highlight default link WhichKeyDesc      Function

" Hide status line
autocmd! FileType which_key
autocmd  FileType which_key set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 noshowmode ruler

" Single mappings
let g:which_key_map['/'] = [ '<Plug>NERDCommenterToggle'	, 'Comentar' ]
let g:which_key_map['e'] = [ ':NvimTreeToggle'			, 'Explorer' ]
let g:which_key_map['s'] = [ ':!clear && shellcheck -x %'	, 'ShellCheck' ]
let g:which_key_map['q'] = [ ':bw'				, 'Fechar Guia' ]
let g:which_key_map['f'] = [ ':Files'				, 'Fuzzy Finder' ]
let g:which_key_map['t'] = [ ':!tmux split-window -v -p 20'	, 'Tmux Terminal' ]
let g:which_key_map['p'] = [ ':!call Preview()'			, 'Preview de Arquivo' ]
let g:which_key_map['n'] = [ ':%!nl -n rz -w3'			, 'Numerador de Linhas' ]
let g:which_key_map['o'] = [ ':set spell!'			, 'Corretor Ortográfico' ]
let g:which_key_map['c'] = [ ':!call Compiler()'		, 'Compilador de Arquivo' ]

call which_key#register('<Space>', "g:which_key_map")
