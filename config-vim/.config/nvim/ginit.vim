" vimrc file.

let s:default_fontsize = 11
let s:fontsize = s:default_fontsize
" let s:font = "Fira Code"
let s:font = "Iosevka"
" GuiLinespace 2

function! SetFont() abort
  if exists('g:GtkGuiLoaded')
    call rpcnotify(1, 'Gui', 'Font', s:font . ' ' . s:fontsize)
  else
    exec "GuiFont " . s:font . ":h" . s:fontsize
  endif
endfunction

call SetFont()

function! AdjustFontSize(delta)
  let s:fontsize += a:delta
  call SetFont()
endfunction

function! ResetFontSize()
  let s:fontsize = s:default_fontsize
  call SetFont()
endfunction

nnoremap <c-+> :call AdjustFontSize(1)<CR>
nnoremap <c--> :call AdjustFontSize(-1)<CR>
nnoremap <c-=> :call ResetFontSize()<CR>

" if exists('g:GtkGuiLoaded')
"     call rpcnotify(1, 'Gui', 'Font', 'Fira Code 11')
"     call rpcnotify(1, 'Gui', 'Option', 'Cmdline', 1)
" endif

" GuiFont Fira Code:h11
" GuiLinespace 0

" the following prevent the background to be just white if set to NONE
" in init.vim
highlight Normal guibg=#282828
highlight nonText guibg=#282828
