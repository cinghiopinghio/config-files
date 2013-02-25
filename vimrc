" vimrc file.



" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible


"call pathogen#runtime_append_all_bundles()
call pathogen#helptags()
call pathogen#infect()

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching
set ignorecase


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


map <F6> :setlocal spell! spelllang=en_us<CR>

" tabulation
setlocal shiftwidth=2 softtabstop=2 expandtab smarttab

"" Save folds automatically on close, and load them on opening the file
"au BufWinLeave *.* mkview
"au BufWinEnter *.* silent loadview


set complete+=k         " enable dictionary completion
set completeopt+=longest
set clipboard+=unnamed  " yank and copy to X clipboard

set ignorecase          " case-insensitive search
set smartcase           " upper-case sensitive search

"wrapping
set wrap
set linebreak
set textwidth=80

set background=dark
colorscheme xinghio

set makeprg=make
set grepprg=grep\ -nH\ $*


" paste from clipboard without indentation with F2
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
set showmode

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Panes
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" open file under cursor on a tab
map gf :tabe<cfile><CR>
"toggle buffers
nnoremap <F5> :buffers<CR>:buffer<Space> 
" resize current buffer by +/- 5 
nnoremap <C-left> :vertical resize -5<cr>
nnoremap <C-down> :resize +5<cr>
nnoremap <C-up> :resize -5<cr>
nnoremap <C-right> :vertical resize +5<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Move
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" move through wrapped lines
imap <silent> <Down> <C-o>gj
imap <silent> <Up> <C-o>gk
nmap <silent> <Down> gj
nmap <silent> <Up> gk


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => NERDTree
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" this let start NERDTree if no file name is given
"autocmd vimenter * if !argc() | NERDTree | endif
noremap <leader>n :NERDTreeToggle<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => TagBar
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

nnoremap <leader>t :TagbarToggle<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => MOUSE
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" use the mouse in vim:
set mouse=a

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VimWiki
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Work related wiki
let s:wiki_1           = {}
let s:wiki_1.path      = '~/docu/wikis/lavoro'
let s:wiki_1.path_html = '~/docu/wikis/lavoro/html'
let s:wiki_1.ext       = '.wiki'
"let s:wiki_1.syntax    = 'vimwiki'
let s:wiki_1.css_name  = 'wiki.css'
let s:wiki_1.nested_syntaxes = {'python': 'python', 'c++': 'cpp', 'shell': 'sh'}

" Personal Stuff related wiki
let s:wiki_2           = {}
let s:wiki_2.path      = '~/docu/wikis/vita'
let s:wiki_2.path_html = '~/docu/wikis/vita/html'
let s:wiki_2.ext       = '.wiki'
"let s:wiki_2.syntax    = 'vimwiki'
let s:wiki_2.css_name  = 'wiki.css'
let s:wiki_2.nested_syntaxes = {'python': 'python', 'c++': 'cpp', 'shell': 'sh'}

let g:vimwiki_list = [s:wiki_1, s:wiki_2]

"map <leader>tt <Plug>VimwikiToggleListItem
"map <C-T> <Plug>VimwikiToggleListItem
let g:vimwiki_folding = 1
let g:vimwiki_use_calendar = 1
" Use vimwiki syntax highlighting for all markdown (and media) files
let g:vimwiki_ext2syntax = {}
"let g:vimwiki_ext2syntax = {'.md': 'markdown', '.mkd': 'markdown', '.mdown': 'markdown', '.markdown': 'markdown'}
"let g:vimwiki_custom_wiki2html='custom_md2html'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Rainbow Parentesis
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:rbpt_colorpairs = [
    \ ['brown',       'RoyalBlue3'],
    \ ['Darkblue',    'SeaGreen3'],
    \ ['darkgray',    'DarkOrchid3'],
    \ ['darkgreen',   'firebrick3'],
    \ ['darkcyan',    'RoyalBlue3'],
    \ ['darkred',     'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['brown',       'firebrick3'],
    \ ['gray',        'RoyalBlue3'],
    \ ['black',       'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['Darkblue',    'firebrick3'],
    \ ['darkgreen',   'RoyalBlue3'],
    \ ['darkcyan',    'SeaGreen3'],
    \ ['darkred',     'DarkOrchid3'],
    \ ['red',         'firebrick3'],
    \ ]
let g:rbpt_max = 16
let g:rbpt_loadcmd_toggle =0
