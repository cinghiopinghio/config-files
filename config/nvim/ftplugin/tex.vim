setlocal shiftwidth=2 softtabstop=2 expandtab smarttab
"setlocal formatoptions+=w

imap <C-p> <C-O>gqip

"{{{  VimCompletesMe
let b:vcm_tab_complete='omni'
"}}}

"{{{ auto-pairs
let b:AutoPairs={'(':')','[':']','{':'}',"'":"'",'"':'"','$':'$'}
"}}}

"{{{ delimitMate
let b:delimitMate_matchpairs = "(:),[:],{:},<:>"
let b:delimitMate_quotes = "\" ' $"
"}}}

"{{{ VIMTEX

let g:vimtex_view_method='zathura'
let g:vimtex_fold_enabled=1
nnoremap <localleader>lp :call PdflatexToggle()<cr>

let g:vimtex_latexmk_options = "-pdfps"
function! PdflatexToggle()
    if g:vimtex_latexmk_options == "-pdfps"
        let g:vimtex_latexmk_options="-pdf"
        echo 'use pdflatex'
    elseif g:vimtex_latexmk_options == "-pdf"
        let g:vimtex_latexmk_options="-lualatex"
        echo 'use lualatex'
    else
        let g:vimtex_latexmk_options="-pdfps"
        echo 'use latex/ps2pdf'
    endif
endfunction
"}}}
