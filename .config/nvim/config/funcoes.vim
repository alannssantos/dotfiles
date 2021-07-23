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
