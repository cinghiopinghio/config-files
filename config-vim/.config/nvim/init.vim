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
"{{{ Vundle: plugin manager
call plug#begin('~/.config/nvim/bundle')


"{{{ Syntax, dictionary ...


set dictionary+=/usr/share/dict/cracklib-small


" It's a syntastic alternative. Syntastic was slow for me on python files.
if has('nvim') || v:version >= 800
  Plug 'neomake/neomake'
  " let g:neomake_warning_sign = {
  "   \ 'text': 'W',
  "   \ 'texthl': 'WarningMsg',
  "   \ }
  " let g:neomake_error_sign = {
  "   \ 'text': 'E',
  "   \ 'texthl': 'ErrorMsg',
  "   \ }
  " let g:neomake_python_enabled_makersers = ['flake8']
  " run neomake on the current file on every write:
  autocmd! BufWritePost * Neomake
else
  " only vimL no python required
  Plug 'scrooloose/syntastic'
  let g:syntastic_mode_map = { 'passive_filetypes': ['sass'] }

  let g:syntastic_always_populate_loc_list = 1
  let g:syntastic_auto_loc_list = 1
  let g:syntastic_check_on_open = 1
  let g:syntastic_check_on_wq = 0
endif
"}}}
"{{{ AutoCompletion

set complete+=k         " enable dictionary completion
" set completeopt+=longest
set completeopt=menu,menuone,noinsert,noselect

"complete parenthesis
Plug 'jiangmiao/auto-pairs'
let g:AutoPairs= {'(':')', '[':']', '{':'}',"'":"'",'"':'"', '`':'`'}

"   autocompletion
Plug 'roxma/nvim-completion-manager'

" function! DoRemote(arg)
"   UpdateRemotePlugins
" endfunction
" Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }
" let g:deoplete#enable_at_startup = 1
" Plug 'zchee/deoplete-jedi', { 'for': 'python' }
" let g:deoplete#sources#jedi#show_docstring=1
" " prevent slow popups
" let g:jedi#popup_on_dot = 1

" {{{snippets
if has("python")
  Plug 'SirVer/ultisnips'
  let g:UltiSnipsExpandTrigger="<c-j>"
  let g:UltiSnipsListSnippets="<c-l>"
else
  Plug 'MarcWeber/vim-addon-mw-utils'
  Plug 'tomtom/tlib_vim'
  Plug 'garbas/vim-snipmate'
endif
Plug 'honza/vim-snippets'
"}}}

" {{{swap contrary...
Plug 'mjbrownie/swapit'
let b:swap_lists = [
      \{'name': 'dark/light', 'options': ['dark', 'light']},
      \{'name': 'bw', 'options': ['black', 'white']},
      \{'name': 'be', 'options': ['begin', 'end']},
      \]
"}}}
"}}}
"{{{ Navigation

set scrolloff=5  " never reach the top or bottom of the page

" keep folds as is until save of fold/unfold
" (save time)
Plug 'Konfekt/FastFold'
""""""""""""""""""""""""""""""""""""" window splits control
Plug 'zhaocai/GoldenView.Vim'
"""""""""""""""""""""""""""""""""""""  
Plug 'junegunn/fzf', { 'dir': '~/.cache/fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" get most recent files with preview
nmap <localleader>ff :Files .<cr>
nmap <localleader>fb :Buffers<cr>
nmap <localleader>fr :History<cr>
nmap <localleader>fo :Tags<cr>
nmap <localleader>fl :Lines<cr>
Plug 'Shougo/denite.nvim'
Plug 'Shougo/unite-outline'
Plug 'Shougo/neomru.vim'
Plug 'Shougo/vimproc.vim'
nmap <localleader>uf :Denite file buffer<cr>
nmap <localleader>ub :Denite buffer<cr>
nmap <localleader>ur :Denite file_mru<cr>
nmap <localleader>uo :Denite outline<cr>
nmap <localleader>ul :Denite line<cr>
let g:unite_enable_start_insert = 1

Plug 'terryma/vim-multiple-cursors'
Plug 'junegunn/vim-easy-align'
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
"}}}
"{{{ Colorschemes
Plug 'tomasr/molokai'
Plug 'junegunn/seoul256.vim'
Plug 'morhetz/gruvbox'
Plug 'freeo/vim-kalisi'
Plug 'marcopaganini/termschool-vim-theme'
Plug 'jnurmine/Zenburn'
"Plug 'cinghiopinghio/xinghio-color.vim'
"}}}
"{{{ Statusbar
Plug 'itchyny/lightline.vim'
"}}}
"{{{ External cmds
Plug 'thinca/vim-quickrun'
" GIT integration
Plug 'tpope/vim-fugitive'
" ask if you typed a wrong filename
Plug 'EinfachToll/DidYouMean'
"}}}
"{{{ Filetype
""""""""""""""""""""""""""""""""""""" HTML
Plug 'othree/html5.vim', { 'for': ['html', 'scss', 'css', 'sass', 'htmldjango'] }
Plug 'lepture/vim-jinja'
""""""""""""""""""""""""""""""""""""" LaTeX
Plug 'lervag/vimtex', { 'for': 'tex' }
"}}}
call plug#end()
"}}}

call denite#custom#map(
      \ 'insert',
      \ '<Down>',
      \ '<denite:move_to_next_line>',
      \ 'noremap'
      \)
call denite#custom#map(
      \ 'insert',
      \ '<Up>',
      \ '<denite:move_to_previous_line>',
      \ 'noremap'
      \)

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
set history=100                 " keep 100 lines of command line history
set ruler                      " show the cursor position all the time
set showcmd                    " display incomplete commands
set incsearch                  " do incremental searching
set ignorecase          " case-insensitive search
set smartcase           " upper-case sensitive search
setlocal shiftwidth=2 softtabstop=2 expandtab smarttab

set clipboard+=unnamed  " yank and copy to X clipboard
"wrapping
set wrap
set linebreak

" set terminal title
set title

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


set splitbelow
set splitright

set textwidth=78
if exists('+colorcolumn')
  set colorcolumn=80
else
  au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
endif

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
