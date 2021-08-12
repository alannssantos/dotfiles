" Função Preview
function! Preview()
	if &filetype ==# 'tex'
		execute ":LLPStartPreview"
	elseif &filetype ==# 'markdown'
		execute ":MarkdownPreview"
	else
		echom "This file doesn’t have preview."
	endif
endfunction

" Função Compilar
function! Compiler()
	if &filetype ==# 'tex'
		execute ":w! \| !pdflatex %"
	else
		echom "This file doesn’t have compiler."
	endif
endfunction

augroup Run_File
	autocmd!

	" Executar ShellScript
	autocmd FileType bash,sh nnoremap <buffer> <leader>r
		\ :sp<CR> :term bash %<CR> :startinsert<CR>
	" Executar Python
	autocmd FileType python nnoremap <buffer> <leader>r
		\ :sp<CR> :term python3 %<CR> :startinsert<CR>
augroup END
