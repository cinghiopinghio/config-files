setlocal shiftwidth=2 softtabstop=2 expandtab smarttab
set wrap linebreak nolist textwidth=0 wrapmargin=0

imap <C-p> <C-O>gqip

"{{{ Deoplete
if exists('g:deoplete#enable_at_startup')
	call deoplete#custom#var('omni',
				\'input_patterns',
				\{
				\'tex': g:vimtex#re#deoplete
				\})
endif
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
if has('nvim')
        let g:vimtex_compiler_progname='nvr'
endif
let g:vimtex_fold_enabled=1
let g:vimtex_fold_manual=0
let g:vimtex_view_forward_search_on_start = 1
" cleanup on quit
augroup vimtex_event_1
        au!
        au User VimtexEventQuit call vimtex#compiler#clean(0)
augroup END


set omnifunc=vimtex#complete#omnifunc
let g:vimtex_quickfix_mode=2
let g:vimtex_quickfix_method = 'pplatex'
let g:vimtex_quickfix_latexlog = {
                        \ 'overfull' : 0,
                        \ 'underfull' : 0,
                        \}
let g:vimtex_complete_bib = {
                        \ 'abbr_fmt' : '@author_all (@year)',
                        \ 'menu_fmt' : '@title',
                        \}

let g:vimtex_compiler_latexmk = {
        \ 'options' : [
        \   '-shell-escape' ,
        \   '-file-line-error',
        \   '-synctex=1' ,
        \   '-interaction=nonstopmode' ,
        \ ],
        \}

"}}}
