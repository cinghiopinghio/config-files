" vimrc file.



" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible


"call pathogen#runtime_append_all_bundles()
"call pathogen#helptags()
call pathogen#infect()

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

set ignorecase
"set spellfile=~/.vim/spell.add
"set spell
"set spelllang=en_gb
syntax on
"setlocal spell spelllang=es
"set spellfile=~/.vim/dict-es.add
set ruler

map <F6> :setlocal spell! spelllang=en_gb<CR>
au Filetype mail setlocal spell
au Filetype tex setlocal spell

set pastetoggle=<F12> 
set complete+=k         " enable dictionary completion
set completeopt+=longest
set clipboard+=unnamed  " yank and copy to X clipboard

set ignorecase          " case-insensitive search
set smartcase           " upper-case sensitive search


" Save folds automatically on close, and load them on opening the file
au BufWinLeave *.* mkview
au BufWinEnter *.* silent loadview

" Turn on line numbers:
set number
" Toggle line numbers and fold column for easy copying:
nnoremap <F2> :set nonumber!<CR>:set foldcolumn=0<CR>
set nonumber
"toggle buffers
nnoremap <F5> :buffers<CR>:buffer<Space> 

filetype plugin indent on
" tabulation
setlocal shiftwidth=2 softtabstop=2 expandtab smarttab
autocmd FileType    matlab set comments=:% expandtab foldmethod=indent
autocmd FileType    matlab set formatoptions=crql expandtab
autocmd FileType make setlocal noexpandtab foldmethod=indent
autocmd FileType python setlocal foldmethod=indent

"wrapping
set wrap
set linebreak
set textwidth=80

colorscheme ron

set makeprg=make

set grepprg=grep\ -nH\ $*
"let g:tex_flavor='latex'
let g:Tex_CompileRule_dvi = 'latex -interaction=nonstopmode $*'
"let g:Tex_CompileRule_ps  = 'ps2pdf $*'
let g:Tex_CompileRule_pdf = 'dvipdf $*.dvi'
let g:Tex_DefaultTargetFormat='pdf'
let g:Tex_FormatDependency_pdf = 'dvi,pdf'
"let g:Tex_MultipleCompileFormats='dvi,pdf'
let g:Tex_UseMakefile=0
"let g:Tex_ViewRule_pdf='zathura'
"let g:Tex_Menus=0
"let g:Tex_FoldedCommands='ctable'

" Set the warning messages to ignore.
let g:Tex_IgnoredWarnings =
\"Underfull\n".
\"Overfull\n".
\"Float too large\n".
\"specifier changed to\n".
\"You have requested\n".
\"Missing number, treated as zero.\n".
\"There were undefined references\n".
\"Citation %.%# undefined\n".
\'LaTeX Font Warning:'"
" This number N says that latex-suite should ignore the first N of the above.
let g:Tex_IgnoreLevel = 9

" TIP: if you write your \label's as \label{fig:something}, then if you
" type in \ref{fig: and press Ctrl-N you will automatically cycle through
" all the figure labels. Very useful!
set iskeyword+=:
set noscrollbind
diffoff


