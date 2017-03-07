"inoremap <c-a> <ESC>:Unite abook<CR>
inoremap <C-a> <ESC>"zyiw:exe "Unite abook -input=".@z.""<CR>

let g:qcc_query_command = 'notmuch-addrlookup'
let g:qcc_format_abbr = '${0}' "first column
let g:qcc_format_menu = '' "second column
let g:qcc_format_word = '${0}' "output
let g:qcc_multiline=1
let g:qcc_multiline_pattern='^.*'
" You might consider using `omnifunc` if you have a completion
" system plugin like neocomplcache
setlocal omnifunc=QueryCommandComplete

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VimCompletesMe
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let b:vcm_tab_complete='omni'
