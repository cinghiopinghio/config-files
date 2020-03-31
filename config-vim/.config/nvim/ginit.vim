" vimrc file.

let s:default_fontsize = 11
let s:fontsize = s:default_fontsize
let s:font = "Iosevka"
let s:font = "Hack"
let s:font = "Source Code Pro"
let s:font = "Fira Code"
" GuiLinespace 2

function! SetFont() abort
	if exists('g:GtkGuiLoaded')
		call rpcnotify(1, 'Gui', 'Font', s:font . ' ' . s:fontsize)
		call rpcnotify(1, 'Gui', 'Option', 'Tabline', 1)
		call rpcnotify(1, 'Gui', 'Option', 'Cmdline', 1)
		call rpcnotify(1, 'Gui', 'Option', 'Linespace', 0)
	else
		exec "GuiFont! " . s:font . ":h" . s:fontsize

		GuiLinespace 0
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

" the following prevent the background to be just white if set to NONE
" in init.vim
" highlight Normal guibg=#282828
" highlight nonText guibg=#282828
"
let g:futon_transp_bg=0
colorscheme futon
