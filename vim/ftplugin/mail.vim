inoremap <c-a> <ESC>:Unite abook<CR>

" Standard setup for mutt
let g:qcc_query_command = 'abook --mutt-query'
" You might consider using `omnifunc` if you have a completion
" system plugin like neocomplcache
setlocal omnifunc=QueryCommandComplete

