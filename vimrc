" vimrc file.

set nocompatible               " be iMproved
filetype off                   " required!
""""""""""""""""""""
" call Vundle
""""""""""""""""""""
let iCanHazVundle=1 
let vundle_readme=expand('~/.vim/bundle/vundle/README.md')
if !filereadable(vundle_readme)
    echo "Installing Vundle.."
    echo ""
    silent !mkdir -p ~/.vim/bundle
    silent !git clone https://github.com/gmarik/vundle ~/.vim/bundle/vundle
    let iCanHazVundle=0
endif
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required! 
Bundle 'gmarik/vundle'

" My Bundles here:
"
" original repos on github
Bundle 'tpope/vim-fugitive'
Bundle 'vim-scripts/VOoM'
"Bundle 'mbbill/VimExplorer'
Bundle 'majutsushi/tagbar'
Bundle 'scrooloose/syntastic'
Bundle 'scrooloose/nerdtree'
Bundle 'vim-scripts/Conque-Shell'
Bundle 'vim-pandoc/vim-pandoc'
"Bundle 'honza/snipmate-snippets'
"Bundle 'tomtom/tlib_vim'
"Bundle 'MarcWeber/vim-addon-mw-utils'
"Bundle 'garbas/vim-snipmate'
Bundle 'SirVer/ultisnips'
Bundle 'LaTeX-Box-Team/LaTeX-Box'
Bundle 'spolu/dwm.vim'
"Bundle 'Shougo/neocomplcache'
Bundle 'tpope/vim-surround'
Bundle 'istib/vifm.vim'
Bundle 'benmills/vimux'
Bundle 'mattn/emmet-vim'

" vim-scripts repos
"Bundle 'L9'
"Bundle 'FuzzyFinder'
" non github repos
"Bundle 'git://git.wincent.com/command-t.git'
" ...

if iCanHazVundle == 0
  echo "Installing Bundles, please ignore key map error messages"
  echo ""
  :BundleInstall
endif

""""""""""""""""""""
"""end"vundle"stuff"
""""""""""""""""""""

filetype plugin indent on     " required!
"
" Brief help
" :BundleList          - list configured bundles
" :BundleInstall(!)    - install(update) bundles
" :BundleSearch(!) foo - search(or refresh cache first) for foo
" :BundleClean(!)      - confirm(or auto-approve) removal of unused bundles
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Bundle command are not allowed..




" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching
set ignorecase

nmap    <ESC>[5^    <C-PageUp>
nmap    <ESC>[6^    <C-PageDown>
"nnoremap <C-PageDown> :bn!<CR>
"noremap <C-PageUp> :bp!<CR>

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

" Wildmenu
if has("wildmenu")
    set wildignore+=*.a,*.o
    set wildignore+=*.bmp,*.gif,*.ico,*.jpg,*.png
    set wildignore+=.DS_Store,.git,.hg,.svn
    set wildignore+=*~,*.swp,*.tmp
    set wildmenu
    set wildmode=longest,full
endif

au FilterWritePre * if &diff | set wrap | endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Navigation
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

" move through wrapped lines
imap <silent> <Down> <C-o>gj
imap <silent> <Up> <C-o>gk
nmap <silent> <Down> gj
nmap <silent> <Up> gk
" prova

" reload vimrc
nmap <leader><leader><leader> :source ~/.vimrc<cr>

" svn commands
command! -b -nargs=0 SvnUp :!svn up
command! -b -nargs=+ SvnCi :!svn ci -m <q-args>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VOOM
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <leader>y :VoomToggle<CR>
let g:voom_tab_key='<C-Tab>'
let g:voom_return_key = '<C-Return>'
let g:voom_ft_modes = {'markdown': 'markdown', 'pandoc': 'markdown', 'python': 'python', 'tex': 'latex'}


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
set mouse=vi

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Latex-Box
""""""""""""""""""""""""""""""
" this is here because otherwise it won't be read by the plugin
let g:LatexBox_Folding=1
let g:LatexBox_ignore_warnings =['Underfull', 'Overfull',
			\'specifier changed to', 'A float is stuck',
			\'Label(s) may have changed']
""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => DWM
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:dwm_map_keys=1
let g:dwm_master_pane_width="66%"
" Show syntax highlighting groups for word under cursor
nmap <C-S-P> :call <SID>SynStack()<CR>
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc
