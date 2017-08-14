" vimrc file.

"----------------------------------------------------------------------
" PREABLE
"{{{ PREAMBLE
let maplocalleader=' '
set nocompatible               " be iMproved
filetype indent plugin on
let s:host=substitute(hostname(), "\\..*", "", "") 
syntax on
"}}}

"----------------------------------------------------------------------
" Plugin Manager
""{{{ Vundle: plugin manager
call plug#begin('~/.vim/bundle')

"""""""""""""""""""""""""""""""""""""" syntax checker
Plug 'scrooloose/syntastic'
""""""""""""""""""""""""""""""""""""" AutoCompletion
Plug 'jiangmiao/auto-pairs'
""Plug 'Raimondi/delimitMate'
"Plug 'ajh17/VimCompletesMe'
Plug 'cinghiopinghio/vim-clevertab', { 'branch': 'filecomplete' }
" for email address completion
Plug 'caio/querycommandcomplete.vim'
""""""""""""""""""""""""""""""""""""" snippets
if has("python")
  Plug 'SirVer/ultisnips'
else
  Plug 'MarcWeber/vim-addon-mw-utils'
  Plug 'tomtom/tlib_vim'
  Plug 'garbas/vim-snipmate'
endif
Plug 'honza/vim-snippets'
Plug 'davidhalter/jedi-vim', { 'for': 'python' }
" keep folds as is until save of fold/unfold
" (save time)
Plug 'Konfekt/FastFold'
" prevent slow popups
let g:jedi#popup_on_dot = 0
""""""""""""""""""""""""""""""""""""" window splits control
Plug 'zhaocai/GoldenView.Vim'
Plug 'itchyny/thumbnail.vim', { 'on': 'Thumbnail' }
""""""""""""""""""""""""""""""""""""" unite
Plug 'Shougo/unite.vim'
Plug 'Shougo/unite-outline'
Plug 'Shougo/neomru.vim'
Plug 'Shougo/vimproc.vim'
Plug 'kopischke/unite-spell-suggest' " text suggestion
""""""""""""""""""""""""""""""""""""" colors
Plug 'tomasr/molokai'
Plug 'junegunn/seoul256.vim'
Plug 'morhetz/gruvbox'
Plug 'freeo/vim-kalisi'
Plug 'marcopaganini/termschool-vim-theme'
Plug 'jnurmine/Zenburn'
"Plug 'cinghiopinghio/xinghio-color.vim'
""""""""""""""""""""""""""""""""""""" statusbar
"Plug 'maciakl/vim-neatstatus'
"Plug 'vim-airline/vim-airline'
"Plug 'vim-airline/vim-airline-themes'
Plug 'itchyny/lightline.vim'
""""""""""""""""""""""""""""""""""""" vary
Plug 'junegunn/vim-easy-align'
Plug 'thinca/vim-quickrun'
Plug 'mjbrownie/swapit'
Plug 'terryma/vim-multiple-cursors'
" GIT integration
Plug 'tpope/vim-fugitive'
" ask if you typed a wrong filename
Plug 'EinfachToll/DidYouMean'

""""""""""""""""""""""""""""""""""""" HTML
"Plug 'mattn/emmet-vim', { 'for': ['html', 'scss', 'css', 'sass', 'htmldjango'] } 
Plug 'othree/html5.vim', { 'for': ['html', 'scss', 'css', 'sass', 'htmldjango'] }
Plug 'lepture/vim-jinja'
"Plug 'cakebaker/scss-syntax.vim', { 'for': ['scss', 'css', 'sass'] }
""""""""""""""""""""""""""""""""""""" LaTeX
Plug 'lervag/vimtex', { 'for': 'tex' }
""""""""""""""""""""""""""""""""""""" Note/Todo writing
"Plug 'xolox/vim-notes'
"Plug 'fmoralesc/vim-pad'
"Plug 'blinry/vimboy'
"Plug 'freitass/todo.txt-vim'

call plug#end()
"}}}

"----------------------------------------------------------------------
"{{{ Autocommands
if has("autocmd") " only with autocommands
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

else
  set autoindent		" always set autoindenting on
endif " has("autocmd")}}}

"-------------------------------------------------------------------------
" SET
""{{{ Settings

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
set hlsearch
set backspace=indent,eol,start " allow backspacing over everything in insert mode
set history=50                 " keep 50 lines of command line history
set ruler                      " show the cursor position all the time
set showcmd                    " display incomplete commands
set incsearch                  " do incremental searching
set ignorecase          " case-insensitive search
set smartcase           " upper-case sensitive search
" set nobackup            " fasten writing process (:w)
" tabulation
setlocal shiftwidth=2 softtabstop=2 expandtab smarttab

set scrolloff=5

set complete+=k         " enable dictionary completion
set completeopt+=longest

set clipboard+=unnamed  " yank and copy to X clipboard
"wrapping
set wrap
set linebreak

" set terminal title
set title

set splitbelow
set splitright

set textwidth=78
if exists('+colorcolumn')
  set colorcolumn=80
else
  au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
endif

let g:lightline = {
      \ 'colorscheme': 'wombat'
      \ }

set termguicolors
set background=dark
if s:host == 'spin'
  let g:seoul256_background = 235
  let g:seoul256_light_background = 256
  colorscheme seoul256
elseif s:host == 'arcinghio'
  colorscheme gruvbox
elseif s:host == 'dingo'
  "colorscheme kalisi
  colorscheme gruvbox
else
  colorscheme molokai
endif
"set background light
highlight Normal guibg=NONE ctermbg=NONE
highlight nonText guifg=#787878 guibg=NONE ctermfg=243 ctermbg=NONE

function! ToggleBackground()
  if &background == 'dark'
    set background=light
  else
    set background=dark
  endif

  highlight Normal guibg=NONE ctermbg=NONE
  highlight nonText guifg=#787878 guibg=NONE ctermfg=243 ctermbg=NONE
endfunction

nnoremap <F9> :call ToggleBackground()<CR>


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
set mouse=vi
"}}}

"-------------------------------------------------------------------------
" MAP
"{{{ Key mappings
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
nnoremap <silent> <localleader><Up>    :wincmd k<CR>
nnoremap <silent> <localleader><Down>  :wincmd j<CR>
nnoremap <silent> <localleader><Right> :wincmd l<CR>
nnoremap <silent> <localleader><Left>  :wincmd h<CR>
" prova

nmap    <ESC>[5^    <C-PageUp>
nmap    <ESC>[6^    <C-PageDown>
" Don't use Ex mode, use Q for formatting
map Q gq
" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>
map <F6> :setlocal spell! spelllang=en_gb<CR>

" insert date
inoremap <F5> <C-R>=strftime("[%Y-%m-%d]")<CR>

" paste from clipboard without indentation with F2
"nnoremap <F2> :set invpaste paste?<CR>
vmap ,y "*y
nmap ,p "*p

" reload vimrc
nmap <leader><leader><leader> :so $MYVIMRC<cr>
"}}}"

"-------------------------------------------------------------------------
" PLUGINS SETTINGS
"{{{
"----------------------------------
"{{{ EasyAlign
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

"}}}

"----------------------------------
"{{{ Clevertab - complete chain


if has("python")
  inoremap <silent><tab> <c-r>=CleverTab#Complete('start')<cr>
                        \<c-r>=CleverTab#Complete('tab')<cr>
                        \<c-r>=CleverTab#Complete('ultisnips')<cr>
                        \<c-r>=CleverTab#Complete('omni')<cr>
                        \<c-r>=CleverTab#Complete('keyword')<cr>
                        \<c-r>=CleverTab#Complete('file')<cr>
                        \<c-r>=CleverTab#Complete('stop')<cr>
else
  inoremap <silent><tab> <c-r>=CleverTab#Complete('start')<cr>
                        \<c-r>=CleverTab#Complete('tab')<cr>
                        \<c-r>=CleverTab#Complete('keyword')<cr>
                        \<c-r>=CleverTab#Complete('omni')<cr>
                        \<c-r>=CleverTab#Complete('file')<cr>
                        \<c-r>=CleverTab#Complete('stop')<cr>
endif
inoremap <silent><s-tab> <c-r>=CleverTab#Complete('prev')<cr>
"}}}

"----------------------------------
"{{{ Use emmet only in html,css
"let g:user_emmet_install_global = 0
"autocmd FileType html,css,scss,sass,htmldjango EmmetInstall
"}}}

"----------------------------------
"{{{ Syntastic
let g:syntastic_mode_map = { 'passive_filetypes': ['sass'] }

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
"}}}

"----------------------------------
"{{{ Unite
nmap <localleader>uf :Unite -no-split file buffer<cr>
nmap <localleader>ub :Unite -no-split buffer<cr>
nmap <localleader>ur :Unite -no-split file_mru<cr>
nmap <localleader>uo :Unite -vertical outline<cr>
let g:unite_enable_start_insert = 1

nmap <localleader>us :Unite spell_suggest<cr>
"}}}"

"----------------------------------
"{{{ UltiSnips
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsListSnippets="<c-l>"
"}}}

"----------------------------------
"{{{ Thumbnail
nnoremap <localleader>t :Thumbnail -include=help<cr>
"}}}

"----------------------------------
"{{{ AutoPairs
let g:AutoPairs= {'(':')', '[':']', '{':'}',"'":"'",'"':'"', '`':'`'}
"}}}

"----------------------------------
"{{{ SwapIt
let b:swap_lists = [
      \{'name': 'dark/light', 'options': ['dark', 'light']},
      \{'name': 'bw', 'options': ['black', 'white']},
      \]
"}}}