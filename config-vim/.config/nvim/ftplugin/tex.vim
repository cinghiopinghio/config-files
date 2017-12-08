setlocal shiftwidth=2 softtabstop=2 expandtab smarttab
"setlocal formatoptions+=w

imap <C-p> <C-O>gqip

"{{{  VimCompletesMe
let b:vcm_tab_complete='omni'
"}}}

let g:completor_tex_omni_trigger = g:vimtex#re#deoplete

"{{{ NCM
augroup my_cm_setup
autocmd!
autocmd User CmSetup call cm#register_source({
  \ 'name' : 'vimtex',
  \ 'priority': 8,
  \ 'scoping': 1,
  \ 'scopes': ['tex'],
  \ 'abbreviation': 'tex',
  \ 'cm_refresh_patterns': g:vimtex#re#ncm,
  \ 'cm_refresh': {'omnifunc': 'vimtex#complete#omnifunc'},
  \ })
augroup END
"}}}

"{{{ Deoplete
if !exists('g:deoplete#omni#input_patterns')
  let g:deoplete#omni#input_patterns = {}
endif
let g:deoplete#omni#input_patterns.tex = g:vimtex#re#deoplete
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

let g:vimtex_quickfix_mode=2

"}}}
