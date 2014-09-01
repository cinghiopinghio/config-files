" vimrc file.

let maplocalleader=' '
""""""""""""""""""""
" call Vundle
""""""""""""""""""""
set nocompatible               " be iMproved
filetype off                   " required!
"{{{
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
"""""""" git
Bundle 'tpope/vim-fugitive'
"""""""" outliner
Bundle 'vim-scripts/VOoM'
"Bundle 'majutsushi/tagbar'
"""""""" syntax checker
Bundle 'scrooloose/syntastic'
"""""""" folder navigation
Bundle 'scrooloose/nerdtree'
"Bundle 'istib/vifm.vim'
""""""" AutoCompletion
Bundle 'ervandew/supertab'
"Bundle 'Valloric/YouCompleteMe'
"Bundle 'Shougo/neocomplete.vim'
"Bundle 'Shougo/neocomplcache'
""""""" snippets
"Bundle 'honza/snipmate-snippets'
"Bundle 'garbas/vim-snipmate'
"Bundle 'MarcWeber/ultisnips'
if has("python")
  Bundle 'SirVer/ultisnips'
  Bundle 'honza/vim-snippets'
endif
""""""" window splits control
"Bundle 'spolu/dwm.vim'
Bundle 'zhaocai/GoldenView.Vim'
""""""" parenthesis change
Bundle 'tpope/vim-surround'
Bundle 'benmills/vimux'
""""""" unite
Bundle 'Shougo/unite.vim'
Bundle 'Shougo/unite-outline'
Bundle 'Shougo/vimproc.vim'
""""""" colors
" Bundle 'tomasr/molokai'
Bundle 'cinghiopinghio/xinghio-color.vim'
""""""" statusbar
"Bundle 'maciakl/vim-neatstatus'
Bundle 'bling/vim-airline'
""""""" vertical alignement
Bundle 'vim-scripts/Align'
"Bundle 'Raimondi/delimitMate'
Bundle 'jiangmiao/auto-pairs'

Bundle 'cinghiopinghio/abook-vim'
Bundle 'caio/querycommandcomplete.vim'
""""""" calendar for vim
Bundle 'mattn/calendar-vim'
""""""" filetype plugins
""""""" CSV
Bundle 'chrisbra/csv.vim'
""""""" HTML
Bundle 'mattn/emmet-vim'
Bundle 'othree/html5.vim'
""""""" LaTeX
Bundle 'LaTeX-Box-Team/LaTeX-Box'
""""""" Note/Todo writing
"Bundle 'xolox/vim-notes'
"Bundle 'fmoralesc/vim-pad'
"Bundle 'blinry/vimboy'
"Bundle ''

"Bundle 'terryma/vim-multiple-cursors'


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
"}}}
filetype plugin indent on     " required!

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")
  "{{{
  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " set wrap in vimdiff
  au FilterWritePre * if &diff | set wrap | endif

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

  au InsertEnter * set norelativenumber
  au InsertLeave * set relativenumber
else
  set autoindent		" always set autoindenting on
endif " has("autocmd")}}}

"SET
""{{{
set backspace=indent,eol,start " allow backspacing over everything in insert mode
set history=50                 " keep 50 lines of command line history
set ruler                      " show the cursor position all the time
set showcmd                    " display incomplete commands
set incsearch                  " do incremental searching
set ignorecase          " case-insensitive search
set smartcase           " upper-case sensitive search
set nobackup            " fasten writing process (:w)
" tabulation
setlocal shiftwidth=2 softtabstop=2 expandtab smarttab
set complete+=k         " enable dictionary completion
set completeopt+=longest
set clipboard+=unnamed  " yank and copy to X clipboard
"wrapping
set wrap
set linebreak
set textwidth=75
set background=dark
set relativenumber
set number
if exists('+colorcolumn')
  set colorcolumn=80
else
  au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
endif
"colorscheme molokai
colorscheme xinghio
set makeprg=make
set grepprg=grep\ -nH\ $*
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
set ls=2  " show statusline always (airline)
set ttimeoutlen=50 " fast exit from INSERT (airlin
set dir=/tmp//,/var/tmp//,.
"}}}

"MAP
"{{{
""" open file under cursor on a tab
"map gf :tabe<cfile><CR>
"toggle buffers
nnoremap <F5> :buffers<CR>:buffer<Space>
" resize current buffer by +/- 5
nnoremap <C-left> :vertical resize -5<cr>
nnoremap <C-down> :resize +5<cr>
nnoremap <C-up> :resize -5<cr>
nnoremap <C-right> :vertical resize +5<cr>

" move through wrapped lines
"imap <silent> <Down> <C-o>gj
"imap <silent> <Up> <C-o>gk
"nmap <silent> <Down> gj
"nmap <silent> <Up> gk
" prova


nmap    <ESC>[5^    <C-PageUp>
nmap    <ESC>[6^    <C-PageDown>
" Don't use Ex mode, use Q for formatting
map Q gq
" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>
map <F6> :setlocal spell! spelllang=en_us<CR>


" insert date
inoremap <F5> <C-R>=strftime("[%Y-%m-%d]")<CR>

" paste from clipboard without indentation with F2
"nnoremap <F2> :set invpaste paste?<CR>

" reload vimrc
nmap <leader><leader><leader> :so $MYVIMRC<cr>
"}}}"

"Show the Subversion 'blame' annotation for the current file, in a narrow
"  window to the left of it.
"Usage:
"  'gb' or ':Blame'
"  To get rid of it, close or delete the annotation buffer.
"Bugs:
"  If the source file buffer has unsaved changes, these aren't noticed and
"    the annotations won't align properly. Should either warn or preferably
"    annotate the actual buffer contents rather than the last saved version.
"  When annotating the same source file again, it creates a new annotation
"    buffer. It should re-use the existing one if it still exists.
"Possible enhancements:
"  When invoked on a revnum in a Blame window, re-blame same file up to the
"    previous revision.
"  Dynamically synchronize when edits are made to the source file.
function s:svnBlame()
   let line = line(".")
   setlocal nowrap
   " create a new window at the left-hand side
   aboveleft 18vnew
   " blame, ignoring white space changes
   %!svn blame -x-w "#"
   setlocal nomodified readonly buftype=nofile nowrap winwidth=1
   setlocal nonumber
   if has('&relativenumber') | setlocal norelativenumber | endif
   " return to original line
   exec "normal " . line . "G"
   " synchronize scrolling, and return to original window
   setlocal scrollbind
   wincmd p
   setlocal scrollbind
   syncbind
endfunction
map gb :call <SID>svnBlame()<CR>
command Blame call s:svnBlame()

"COMMANDS
"{{{"
" svn commands
command! -b -nargs=0 SvnUp :!svn up
command! -b -nargs=+ SvnCi :!svn ci -m <q-args>
"}}}"

" SYNTASTIC
"{{{
let g:syntastic_mode_map = { 'passive_filetypes': ['sass'] }
"}}}

"UNITE
"{{{
nmap <localleader>uf :Unite -no-split file buffer<cr>
nmap <localleader>ub :Unite -no-split buffer<cr>
nmap <localleader>ur :Unite -no-split file_mru<cr>
nmap <localleader>uo :Unite -vertical outline<cr>
let g:unite_enable_start_insert = 1
"}}}"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VOOM
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"{{{
nnoremap <localleader>y :VoomToggle<CR>
let g:voom_tab_key='<C-Tab>'
let g:voom_return_key = '<C-Return>'
let g:voom_ft_modes = {'markdown': 'markdown', 'pandoc': 'markdown', 'python': 'python', 'tex': 'latex'}
"}}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => NERDTree
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"{{{
" this let start NERDTree if no file name is given
"autocmd vimenter * if !argc() | NERDTree | endif
noremap <localleader>n :NERDTreeToggle<CR>
"}}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => TagBar
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"{{{
"nnoremap <localleader>t :TagbarToggle<CR>
"}}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => MOUSE
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"{{{
" use the mouse in vim:
set mouse=vi
"}}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Latex-Box
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"{{{
" this is here because otherwise it won't be read by the plugin
let g:LatexBox_Folding=1
let g:LatexBox_ignore_warnings =['Underfull', 'Overfull',
                          \'specifier changed to', 'A float is stuck',
                          \'Label(s) may have changed']
"}}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => DWM
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"{{{
let g:dwm_map_keys=1
let g:dwm_master_pane_width="66%"
"}}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Show syntax highlighting groups for word under cursor
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"{{{
nmap <C-S-P> :call <SID>SynStack()<CR>
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc
"}}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SuperTab
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"{{{"
" use OmniComplete function
let g:SuperTabDefaultCompletionType = "context"
"let g:SuperTabDefaultCompletionType = "<C-x><C-o>"
let g:SuperTabContextDefaultCompletionType = "<C-x><C-o>"
"}}}"
let g:UltiSnipsExpandTrigger="<c-j>"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" AirLine
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"{{{ " see the theme file for the color definition
let g:airline_right_sep=''
let g:airline_left_sep=''
let g:airline#extensions#default#layout = [
                  \ [ 'a', 'b', 'c'],
                  \ [ 'x', 'y', 'z', 'warning']]
let g:airline#extensions#whitespace#enabled = 0
"}}}



