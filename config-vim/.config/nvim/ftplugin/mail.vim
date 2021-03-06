" do not wrap on mail headers
autocmd CursorMoved,CursorMovedI <buffer> if IsSpecialLine() | setlocal textwidth=0 | else | setlocal textwidth=80 | endif

inoremap <expr> <c-x><c-a> fzf#vim#complete(fzf#wrap({
            \ 'source': 'notmuch address "*"',
            \ 'options': '--multi --reverse --tiebreak=index --ansi --prompt "Addresses> "',
            \ 'reducer': { lines -> join(lines, ', ') }},
            \ ))

function CleanQuotes(depth)
    " delete matching lines and place them to the black hole register '_'
    execute 'global/^>\{' . a:depth . '}/delete_'
endfunction

command! CleanQuotes call CleanQuotes(1)

function IsSpecialLine()
    return getline('.') =~ '^\(to:\|cc:\|ccn:\|subject\).*'
endfunction

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
