"inoremap <c-a> <ESC>:Unite abook<CR>
inoremap <C-a> <ESC>"zyiw:exe "Unite abook -input=".@z.""<CR>

" Standard setup for mutt
let g:qcc_query_command = 'abook --mutt-query'
let g:qcc_format_menu = '<${0}>'
" You might consider using `omnifunc` if you have a completion
" system plugin like neocomplcache
setlocal omnifunc=QueryCommandComplete

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VimCompletesMe
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let b:vcm_tab_complete='omni'
