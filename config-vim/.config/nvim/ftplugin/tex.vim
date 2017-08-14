setlocal shiftwidth=2 softtabstop=2 expandtab smarttab
"setlocal formatoptions+=w

imap <C-p> <C-O>gqip

"{{{  VimCompletesMe
let b:vcm_tab_complete='omni'
"}}}


"{{{ Deoplete
if !exists('g:deoplete#omni#input_patterns')
let g:deoplete#omni#input_patterns = {}
endif
let g:deoplete#omni#input_patterns.tex = '\\(?:'
\ .  '\w*cite\w*(?:\s*\[[^]]*\]){0,2}\s*{[^}]*'
\ . '|\w*ref(?:\s*\{[^}]*|range\s*\{[^,}]*(?:}{)?)'
\ . '|hyperref\s*\[[^]]*'
\ . '|includegraphics\*?(?:\s*\[[^]]*\]){0,2}\s*\{[^}]*'
\ . '|(?:include(?:only)?|input)\s*\{[^}]*'
\ . '|\w*(gls|Gls|GLS)(pl)?\w*(\s*\[[^]]*\]){0,2}\s*\{[^}]*'
\ . '|includepdf(\s*\[[^]]*\])?\s*\{[^}]*'
\ . '|includestandalone(\s*\[[^]]*\])?\s*\{[^}]*'
\ .')'
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
let g:vimtex_fold_manual=0
"let g:vimtex_motion_enabled=0
"let g:vimtex_motion_matchparen=0
"let g:vimtex_indent_enabled=0

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
