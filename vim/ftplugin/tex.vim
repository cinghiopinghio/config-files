setlocal shiftwidth=2 softtabstop=2 expandtab smarttab
"setlocal formatoptions+=w
"imap <buffer> [[ \begin{
"imap <buffer> ]] <Plug>LatexCloseCurEnv
nmap <buffer> <F5> <Plug>LatexChangeEnv
vmap <buffer> <F7> <Plug>LatexWrapSelection
vmap <buffer> <S-F7> <Plug>LatexEnvWrapSelection

imap <C-p> <C-O>gqip

" Don't screw up folds when inserting text that might affect them, until
" leaving insert mode. Foldmethod is local to the window. Protect against
" screwing up folding when switching between windows.
autocmd InsertEnter * if !exists('w:last_fdm') | let w:last_fdm=&l:foldmethod | setlocal foldmethod=manual | endif
autocmd InsertLeave,WinLeave * if exists('w:last_fdm') | let &l:foldmethod=w:last_fdm | unlet w:last_fdm | endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VOom
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"nnoremap <leader>y :VoomToggle latex<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Latex Box Plugin
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:LatexBox_output_type="pdf"
let g:LatexBox_show_warnings=2
let g:LatexBox_latexmk_options = "-pdfps"
let g:LatexBox_viewer = 'zathura'
let g:LatexBox_fold_preamble=1 
let g:LatexBox_fold_envs=1 
let g:LatexBox_latexmk_async=0
let g:LatexBox_latexmk_preview_continuously=1

nnoremap <localleader>lp :call PdflatexToggle()<cr>

function! PdflatexToggle()
    if g:LatexBox_latexmk_options == "-pdfps"
        let g:LatexBox_latexmk_options=""
        echo 'use pdflatex'
    else
        let g:LatexBox_latexmk_options="-pdfps"
        echo 'use latex/ps2pdf'
    endif
endfunction


"let g:Tex_CompileRule_dvi = 'latex -interaction=nonstopmode $*'
"let g:Tex_CompileRule_ps  = 'ps2pdf $*'
"let g:Tex_CompileRule_pdf = 'dvipdf $*.dvi'
"let g:Tex_DefaultTargetFormat='pdf'
"let g:Tex_FormatDependency_pdf = 'dvi,pdf'
"let g:Tex_UseMakefile=0
"let g:Tex_ViewRuleComplete_pdf='zathura $*.pdf 2>>/dev/null &'
"let g:Tex_FoldedEnvironments=',frame'



"" Set the warning messages to ignore.
"let g:Tex_IgnoredWarnings ='
"\"Underfull\n".
"\"Overfull\n".
"\"Float too large\n".
"\"specifier changed to\n".
"\"You have requested\n".
"\"Missing number, treated as zero.\n".
"\"There were undefined references\n".
"\"Citation %.%# undefined\n".
"\"Reference %.%# undefined\n".
"\"LaTeX Font Warning:"'
"" This number N says that latex-suite should ignore the first N of the above.
"let g:Tex_IgnoreLevel = 10
