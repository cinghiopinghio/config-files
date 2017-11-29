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
"{{{ Pluc-vim: plugin manager
if has('nvim')
	call plug#begin('~/.config/nvim/bundle')
else
	call plug#begin('~/.vim/bundle')
endif

Plug 'mbbill/undotree'
" Plug 'simnalamburt/vim-mundo'
" Plug 'jaxbot/selective-undo.vim'

"{{{ Syntax, dictionary ...

set dictionary+=/usr/share/dict/cracklib-small

" Syntax check
"{{{ neomake/Syntastic/ALE
if has('nvim') || v:version >= 800
  Plug 'w0rp/ale'
  " Only lint on save or when switching back to normal mode, not every keystroke in insert mode
  let g:ale_lint_on_text_changed = 'normal'
  let g:ale_lint_on_insert_leave = 1
  " Only fix on save
  let g:ale_fix_on_save = 1

  " Plug 'neomake/neomake'
  " let g:neomake_warning_sign = {
  "   \ 'text': 'W',
  "   \ 'texthl': 'WarningMsg',
  "   \ }
  " let g:neomake_error_sign = {
  "   \ 'text': 'E',
  "   \ 'texthl': 'ErrorMsg',
  "   \ }
  " " let g:neomake_python_enabled_makersers = ['flake8']
  " " run neomake on the current file on every write:
  " autocmd! BufWritePost * Neomake
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
"}}}
"{{{ AutoCompletion

set complete+=k         " enable dictionary completion
" set completeopt+=longest
set completeopt=menu,menuone,noinsert,noselect,preview

"  complete parenthesis
"{{{ jiangmiao/auto-pairs
Plug 'jiangmiao/auto-pairs'
let g:AutoPairs= {'(':')', '[':']', '{':'}',"'":"'",'"':'"', '`':'`'}
"}}}

"  autocompletion
"{{{ deoplete / completor / VimCompletesMe / NCM
if has('nvim')
  " the framework
  Plug 'roxma/nvim-completion-manager'
  " with neovim use deoplete
  " function! DoRemote(arg)
  "   UpdateRemotePlugins
  " endfunction
  " Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }
  " let g:deoplete#enable_at_startup = 1
  " Plug 'zchee/deoplete-jedi', { 'for': 'python' }
  " let g:deoplete#sources#jedi#show_docstring=1
elseif v:version >= 800
  " with vim8 use completor
  Plug 'maralla/completor.vim'
  let g:completor_python_binary='python'
else
  Plug 'ajh17/VimCompletesMe'
endif
"}}}

"  snippets
" {{{ ultisnips
if has("python")
  Plug 'SirVer/ultisnips'
  let g:UltiSnipsExpandTrigger="<c-j>"
  let g:UltiSnipsListSnippets="<c-l>"
else
  Plug 'MarcWeber/vim-addon-mw-utils'
  Plug 'tomtom/tlib_vim'
  Plug 'garbas/vim-snipmate'
  imap <C-j> <Plug>snipMateNextOrTrigger
  smap <C-j> <Plug>snipMateNextOrTrigger
  imap <C-l> <Plug>snipMateShow
endif
Plug 'honza/vim-snippets'
"}}}

"  word editing
" {{{ mjbrownie/swapit
Plug 'mjbrownie/swapit'
let b:swap_lists = [
      \{'name': 'dark/light', 'options': ['dark', 'light']},
      \{'name': 'bw', 'options': ['black', 'white']},
      \{'name': 'be', 'options': ['begin', 'end']},
      \{'name': 'rl', 'options': ['right', 'left']},
      \{'name': 'ab', 'options': ['above', 'bottom']},
      \]
"}}}
"}}}
"{{{ Navigation

set scrolloff=5  " never reach the top or bottom of the page

" keep folds as is until save of fold/unfold (save time)
Plug 'Konfekt/FastFold'
" window splits control
Plug 'zhaocai/GoldenView.Vim'
"""""""""""""""""""""""""""""""""""""
Plug 'ludovicchabant/vim-gutentags'
"{{{ FZF
Plug 'junegunn/fzf', { 'dir': '~/codes/fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" This is the default extra key bindings
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" Default fzf layout
" - down / up / left / right
let g:fzf_layout = { 'down': '~40%' }

" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }
" get most recent files with preview
nmap <localleader>ff :Files .<CR>
nmap <localleader>fb :Buffers<cr>
" use the neomru cache!
Plug 'Shougo/neomru.vim'
nmap <localleader>fr :History<cr>
command! -bang History
  \ call fzf#run(fzf#wrap({
  \ 'options': '--tiebreak=index',
  \ 'source': 'cat ~/.cache/neomru/file | sed 1d'
  \ }, <bang>0))
nmap <localleader>fl :Lines<cr>
"}}}
"{{{ Denite
" Plug 'Shougo/denite.nvim'
" Plug 'Shougo/unite-outline'
" Plug 'Shougo/neomru.vim'
" Plug 'Shougo/vimproc.vim'
" nmap <localleader>uf :Denite file buffer<cr>
" nmap <localleader>ub :Denite buffer<cr>
" nmap <localleader>ur :Denite file_mru<cr>
" nmap <localleader>uo :Denite outline<cr>
" nmap <localleader>ul :Denite line<cr>
" let g:unite_enable_start_insert = 1
"}}}

Plug 'terryma/vim-multiple-cursors'
" if ! exists("g:deoplete_multicursors")
"   " load this only once
"   let g:deoplete_multicursors = 1
"   function g:Multiple_cursors_before()
"    let g:deoplete#disable_auto_complete = 1
"   endfunction
"   function g:Multiple_cursors_after()
"    let g:deoplete#disable_auto_complete = 0
"   endfunction
" endif
"{{{ junegunn/vim-easy-align
Plug 'junegunn/vim-easy-align'
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
"}}}
" move parameters left or right
Plug 'AndrewRadev/sideways.vim'
nnoremap <m-left> :SidewaysLeft<cr>
nnoremap <m-right> :SidewaysRight<cr>

"Plug 'xtal8/traces.vim'
Plug 'haya14busa/incsearch.vim'
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

" better search experience
" {{{ junegunn/vim-slash
" Plug 'junegunn/vim-slash'
" if has('timers')
"   " Blink 2 times with 50ms interval
"   noremap <expr> <plug>(slash-after) slash#blink(2, 50)
" endif
" }}}
"}}}
"{{{ Colorschemes
Plug 'tomasr/molokai'
Plug 'junegunn/seoul256.vim'
let g:seoul256_background = 235
let g:seoul256_light_background = 256
Plug 'morhetz/gruvbox'
let g:gruvbox_italic=1
Plug 'freeo/vim-kalisi'
Plug 'marcopaganini/termschool-vim-theme'
Plug 'jnurmine/Zenburn'
Plug 'fxn/vim-monochrome'
Plug 'owickstrom/vim-colors-paramount'
Plug 'pbrisbin/vim-colors-off'
"}}}
"{{{ Statusbar
"Plug 'itchyny/lightline.vim'
"Plug 'oldgaro/graynito'  " graysh lightline colorscheme
Plug 'airblade/vim-gitgutter'
" Plug 'airblade/vim-rooter'
" Plug 'ludovicchabant/vim-gutentags'
" let g:gutentags_cache_dir = '~/.cache/ctags/'
Plug 'tpope/vim-fugitive'
" do not set maps
let g:gitgutter_map_keys = 0
" let g:lightline = {
"       \ 'colorscheme': 'wombat',
"       \ 'active': {
"       \   'left': [ [ 'mode', 'paste' ],
"       \             [ 'fugitive', 'filename', 'modified', 'readonly' ] ],
"       \   'right': [ [ 'percent', 'lineinfo' ],
"       \              [ 'fileformat', 'fileencoding', 'filetype' ] ],
"       \ },
"       \ 'component_function': {
"       \   'fugitive': 'fugitive#head',
"       \ },
"       \ 'separator': { 'left': '▙', 'right': '▟' },
"       \ 'subseparator': { 'left': '', 'right': '' },
"       \ }
"   function! LightLineFugitive()
"     return exists('*fugitive#head') ? fugitive#head() : ''
"   endfunction
"}}}
"{{{ External cmds
Plug 'thinca/vim-quickrun'
Plug 'skywind3000/asyncrun.vim'
augroup vimrc
    autocmd User AsyncRunStart call asyncrun#quickfix_toggle(8, 1)
augroup END
" GIT integration
" ask if you typed a wrong filename
Plug 'EinfachToll/DidYouMean'
"}}}
"{{{ Filetype
""""""""""""""""""""""""""""""""""""" HTML
Plug 'othree/html5.vim', { 'for': ['html', 'scss', 'css', 'sass', 'htmldjango'] }
Plug 'lepture/vim-jinja'
""""""""""""""""""""""""""""""""""""" LaTeX
" {{{ lervag/Vimtex
"There is no reason to lazily load vimtex. Vimtex is a filetype plugin that
"uses the autoload feature, and it does not load or source any vimscript file
"until you open a tex file/buffer. Thus my suggestion is that you load vimtex
"without restricting it to tex files. And in this case, there should be no
"conflict.
"https://github.com/lervag/vimtex/issues/885
Plug 'lervag/vimtex'   ", { 'for': 'tex' }
" }}}
"}}}
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

set termguicolors
set background=dark
if s:host == 'spin'
  colorscheme seoul256
elseif s:host == 'arcinghio'
  colorscheme gruvbox
elseif s:host == 'dingo'
  " colorscheme paramount
  colorscheme mangroove
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
augroup rowcolumn
  autocmd!
  autocmd InsertEnter * setlocal colorcolumn=80 cursorline
  autocmd InsertLeave * setlocal colorcolumn=0 nocursorline
augroup END

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


function! WindowNumber()
  return tabpagewinnr(tabpagenr())
endfunction
function! TrailingSpaceWarning()
  if !exists("b:statline_trailing_space_warning")
    let lineno = search('\s$', 'nw')
    if lineno != 0
      let b:statline_trailing_space_warning = '[TS:'.lineno.']'
    else
      let b:statline_trailing_space_warning = ''
    endif
  endif
  return b:statline_trailing_space_warning
endfunction

" recalculate when idle, and after saving
augroup statline_trail
  autocmd!
  autocmd cursorhold,bufwritepost * unlet! b:statline_trailing_space_warning
augroup END

set statusline=
set statusline+=%6*%m%r%*                          " modified, readonly
set statusline+=%2*%{expand('%:p:h')}/               " relative path to file's directory
set statusline+=%1*%t%*                            " file name
set statusline+=%<                                 " truncate here if needed
set statusline+=\ %3*%{TrailingSpaceWarning()}%*     " trailing whitespace

set statusline+=%=                                 " switch to RHS

set statusline+=%5*L:%l/%L%*                     " number of lines
set statusline+=\ %5*W:%{WindowNumber()}%*     " window number

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

" Use tab and shift-tab to cycle through windows.
nnoremap <Tab> <C-W>w
nnoremap <S-Tab> <C-W>W
" Use | and _ to split windows (while preserving original behaviour of [count]bar and [count]_).
nnoremap <expr><silent> <Bar> v:count == 0 ? "<C-W>v<C-W><Right>" : ":<C-U>normal! 0".v:count."<Bar><CR>"
nnoremap <expr><silent> _     v:count == 0 ? "<C-W>s<C-W><Down>"  : ":<C-U>normal! ".v:count."_<CR>"

nmap    <ESC>[5^    <C-PageUp>
nmap    <ESC>[6^    <C-PageDown>
" Don't use Ex mode, use Q for formatting
map Q gq
" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" cycle through a number of languages
function! CycleLang()
  let langs = ['en_gb', 'it', 'fr', 'en_us', '']
  let i = index(langs, &spelllang)
  let j = (i+1)%len(langs)
  let &spelllang = langs[j]

  if empty(&spelllang)
    set nospell
    echo 'Unset spell language'
  else
    set spell
    echo 'Using: "'.&spelllang.'" spell language'
  endif
endfunction
nnoremap <F6> :call CycleLang()<CR>

" reload vimrc
nmap <leader><leader><leader> :so $MYVIMRC<cr>

" show the highlight used (under the cursor)
map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>
"}}}
