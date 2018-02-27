" vimrc file.

"----------------------------------------------------------------------
" PREABLE
"{{{ PREAMBLE
let maplocalleader=' '
if !has('nvim')
  set nocompatible               " be iMproved
endif
filetype indent plugin on
let s:host=substitute(hostname(), "\\..*", '', '')
syntax on
"}}}

"----------------------------------------------------------------------
" Plugin Manager
"{{{ Pluc-vim: plugin manager
if has('nvim')
  if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
  endif
  call plug#begin('~/.config/nvim/bundle')
else
  if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
  endif
  call plug#begin('~/.vim/bundle')
endif

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
  let g:ale_linters = {
    \ 'python': ['pyls'],
    \ }
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

" comment uncomment
Plug 'tpope/vim-commentary'
"}}}
"{{{ AutoCompletion
if has('nvim') || v:version >= 800
  Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh' }
  Plug 'Shougo/echodoc.vim'
  " Required for operations modifying multiple buffers like rename.
  " set hidden

  let g:LanguageClient_serverCommands = {
      \ 'python': ['pyls'],
      \ 'html': ['html-languageserver', '--stdio'],
      \ 'css': ['css-languageserver', '--stdio'],
      \ 'json': ['json-languageserver', '--stdio'],
      \ }
  nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
  nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
  nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>

  " Automatically start language servers.
  let g:LanguageClient_autoStart = 1
else
  Plug 'lifepillar/vim-mucomplete'
  let g:mucomplete#enable_auto_at_startup = 1
endif

set complete+=k         " enable dictionary completion
set completeopt=menuone,preview
if (v:version >= 704 && has('patch755')) || has('nvim')
  set completeopt+=noinsert,noselect
endif

"  complete parenthesis
"{{{ jiangmiao/auto-pairs
Plug 'jiangmiao/auto-pairs'
let g:AutoPairs= {'(':')', '[':']', '{':'}',"'":"'",'"':'"', '`':'`'}
"}}}

"  autocompletion
"{{{ deoplete / completor / VimCompletesMe / NCM
if has('nvim') || v:version >= 800
  " the framework
  Plug 'roxma/nvim-completion-manager'
  " Requires vim8 with has('python') or has('python3')
  " Requires the installation of msgpack-python. (pip install msgpack-python)
  Plug 'roxma/vim-hug-neovim-rpc', has('nvim') ? { 'on': [] } : {}
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
" Plug 'mjbrownie/swapit'
" let b:swap_lists = [
"       \{'name': 'dark/light', 'options': ['dark', 'light']},
"       \{'name': 'bw', 'options': ['black', 'white']},
"       \{'name': 'be', 'options': ['begin', 'end']},
"       \{'name': 'rl', 'options': ['right', 'left']},
"       \{'name': 'ab', 'options': ['above', 'bottom']},
"       \]
"}}}
Plug 'bootleq/vim-cycle'
let g:cycle_no_mappings = 1    " just set my keys
let g:cycle_max_conflict = 1   " do not handle conflicts (better performance)
nmap <silent> <C-A> <Plug>CycleNext
nmap <silent> <C-X> <Plug>CyclePrev
noremap <silent> <Plug>CycleFallbackNext <C-A>
noremap <silent> <Plug>CycleFallbackPrev <C-X>
let g:cycle_default_groups = [
      \   [['true', 'false']],
      \   [['yes', 'no']],
      \   [['on', 'off']],
      \   [['+', '-']],
      \   [['>', '<']],
      \   [['"', "'"]],
      \   [['==', '!=']],
      \   [['and', 'or']],
      \   [["in", "out"]],
      \   [["up", "down"]],
      \   [["min", "max"]],
      \   [["get", "set"]],
      \   [["add", "remove"]],
      \   [["to", "from"]],
      \   [["read", "write"]],
      \   [['without', 'with']],
      \   [["exclude", "include"]],
      \   [['{:}', '[:]', '(:)'], 'sub_pairs'],
      \   [['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday',
      \     'Friday', 'Saturday'], 'hard_case', {'name': 'Days'}],
      \ ]
let g:cycle_default_groups_for_tex = [
        \   [['tiny', 'scriptsize', 'footnotesize', 'small', 'normalsize', 'large', 'Large', 'LARGE', 'huge', 'Huge'], 'hard_case', 'match_case'],
        \   [['displaystyle', 'scriptstyle', 'scriptscriptstyle', 'textstyle']],
        \   [['part', 'chapter', 'section', 'subsection', 'subsubsection', 'paragraph', 'subparagraph']],
        \   [['article', 'report', 'book', 'letter', 'slides']],
        \   [['scrbook', 'scrreprt', 'scrartcl', 'scrlttr2']],
        \   [['oneside', 'twoside']],
        \   [['onecolumn', 'twocolumn']],
        \   [['draft', 'final']],
        \   [['\big(:\big)', '\Big(:\Big)', '\bigg(:\bigg)', '\Bigg(:\Bigg)'], 'sub_pairs', 'hard_case', 'match_case'],
        \   [['\big[:\big]', '\Big[:\Big]', '\bigg[:\bigg]', '\Bigg[:\Bigg]'], 'sub_pairs', 'hard_case', 'match_case'],
        \   [['\big\{:\big\}', '\Big\{:\Big\}', '\bigg\{:\bigg\}', '\Bigg\{:\Bigg\}'], 'sub_pairs', 'hard_case', 'match_case'],
        \   [['\big\l:\big\r', '\Big\l:\Big\r', '\bigg\l:\bigg\r', '\Bigg\l:\Bigg\r'], 'sub_pairs', 'hard_case', 'match_case'],
        \   [['\big', '\Big', '\bigg', '\Bigg'], 'hard_case', 'match_case'],
        \ ]
"}}}
"{{{ Navigation

set scrolloff=5  " never reach the top or bottom of the page

" keep folds as is until save of fold/unfold (save time)
Plug 'Konfekt/FastFold'
" " window splits control
" Plug 'zhaocai/GoldenView.Vim'
"""""""""""""""""""""""""""""""""""""
" Plug 'ludovicchabant/vim-gutentags'
" Plug 'troydm/zoomwintab.vim'
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
nmap <localleader>fg :GitFiles<cr>
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

Plug 'hauleth/sad.vim'
" Plug 'terryma/vim-multiple-cursors'
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
"Plug 'junegunn/vim-easy-align'
Plug 'tommcdo/vim-lion'
let g:lion_squeeze_spaces=1
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

let g:seoul256_background = 235
let g:seoul256_light_background = 256
Plug 'junegunn/seoul256.vim'

let g:gruvbox_italic=1
Plug 'morhetz/gruvbox'

Plug 'freeo/vim-kalisi'
Plug 'marcopaganini/termschool-vim-theme'
Plug 'jnurmine/Zenburn'
Plug 'owickstrom/vim-colors-paramount'
Plug 'hauleth/blame.vim'
Plug 'tpozzi/Sidonia'

" my colorscheme
let g:mangroove_transparent_bg = 1
let g:mangroove_accent_color='aqua'
if isdirectory(expand('~/codes/mangroove.vim'))
  Plug '~/codes/mangroove.vim'
else
  Plug 'cinghiopinghio/mangroove.vim'
endif
"}}}
Plug 'airblade/vim-gitgutter'
let g:gitgutter_map_keys = 0   " do not set maps
Plug 'tpope/vim-fugitive'
"{{{ External cmds
if has('nvim') || v:version >= 800
  Plug 'hauleth/asyncdo.vim'
else
  Plug 'thinca/vim-quickrun'
endif

" ask if you typed a wrong filename
Plug 'EinfachToll/DidYouMean'
"}}}
"{{{ Filetype
Plug 'Vimjas/vim-python-pep8-indent'
" {{{ lervag/Vimtex
" There is no reason to lazily load vimtex. Vimtex is a filetype plugin that
" uses the autoload feature, and it does not load or source any vimscript file
" until you open a tex file/buffer.
" https://github.com/lervag/vimtex/issues/885
Plug 'lervag/vimtex'   ", { 'for': 'tex' }
Plug 'othree/html5.vim'
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
  set autoindent    " always set autoindenting on
endif " has("autocmd")}}}

"-------------------------------------------------------------------------
" SET
""{{{ Settings

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
set backspace=indent,eol,start " allow backspacing over everything in insert mode
set history=100                 " keep 100 lines of command line history
" set ruler                      " show the cursor position all the time
" set showcmd                    " display incomplete commands

set clipboard+=unnamed  " yank and copy to X clipboard

" SEARCH
set hlsearch
set incsearch                  " do incremental searching
set ignorecase          " case-insensitive search
set smartcase           " upper-case sensitive search
setlocal shiftwidth=2 softtabstop=2 expandtab smarttab

set textwidth=78
set colorcolumn=80
set cursorline

set number
set relativenumber

"wrapping
set wrap
set linebreak

set splitbelow
set splitright

" set terminal title
set title

" show tabs and trailing whitespaces
set list
set listchars=tab:╟─,trail:┄,extends:┄

iabbrev mf Mauro Faccin
iabbrev ... …

"{{{ THEME and COLORS
if has('termguicolors')
  set termguicolors
endif
if filereadable('/tmp/theme_status_light')
  set background=light
else
  set background=dark
endif
if s:host == 'spin'
  colorscheme seoul256
elseif s:host == 'arcinghio'
  colorscheme gruvbox
elseif s:host == 'susto'
  colorscheme mangroove
elseif s:host == 'dingo'
  " colorscheme paramount
  colorscheme mangroove
else
  colorscheme molokai
endif
"set background light
" highlight Normal guibg=NONE ctermbg=NONE
" highlight nonText guifg=#787878 guibg=NONE ctermfg=243 ctermbg=NONE

function! ToggleBackground()
  if &background == 'dark'
    set background=light
  else
    set background=dark
  endif

  "highlight Normal guibg=NONE ctermbg=NONE
  "highlight nonText guifg=#787878 guibg=NONE ctermfg=243 ctermbg=NONE
endfunction

nnoremap <F9> :call ToggleBackground()<CR>
"}}}

set makeprg=make
set grepprg=grep\ -nH\ $*
set pastetoggle=<F2>
set showmode
" Wildmenu
if has("wildmenu")
  set wildignore+=*.a,*.o
  " set wildignore+=*.bmp,*.gif,*.ico,*.jpg,*.png
  set wildignore+=.DS_Store,.git,.hg,.svn
  set wildignore+=*~,*.swp,*.tmp
  set wildmenu
  set wildmode=longest,full
endif
set ls=2  " show statusline always
set dir=/tmp//,/var/tmp//,.
set mouse=vi
"}}}

" Status Line: {{{
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
" Status Function: {{{2
function! Status(winnum)
  let active = a:winnum == winnr()
  let bufnum = winbufnr(a:winnum)

  let stat = ''

  " this function just outputs the content colored by the
  " supplied colorgroup number, e.g. num = 2 -> User2
  " it only colors the input if the window is the currently
  " focused one

  function! Color(active, num, content)
    if a:active
      return '%' . a:num . '*' . a:content . '%*'
    else
      return a:content
    endif
  endfunction

  " this handles alternative statuslines
  let usealt = 0

  let type = getbufvar(bufnum, '&buftype')
  let name = bufname(bufnum)

  if type ==# 'help'
    let altstat = ' ' . fnamemodify(name, ':t:r')
    let usealt = 1
  elseif name ==# '__Gundo__'
    let altstat = ' Gundo'
    let usealt = 1
  elseif name ==# '__Gundo_Preview__'
    let altstat = ' Gundo Preview'
    let usealt = 1
  endif

  if usealt
    return altstat . "%=%Y "
  endif

  " file name
  let stat .= Color(active, 3, expand('#' . bufnum . ':p:h:~') . '/' )
  let stat .= Color(active, 1, expand('#' . bufnum . ':t'))
  let stat .= ' %<'  " truncate here if too long

  " file modified + readonly
  let stat .= Color(active, 1, '%m%r')

  " paste
  if active && &paste
    let stat .= Color(active, 2, 'P')
  endif

  if active
     let stat .= TrailingSpaceWarning()
  endif

  " right side
  let stat .= '%='

  " git branch
  let head = fugitive#head(8)
  if active && !empty(head)
    let stat .= Color(active, 3, ' [' . head . ']')
  endif

  if active
    let stat .= Color(active, 2, ' %l/%L')
  endif

  return stat
endfunction
" }}}

" Status AutoCMD: {{{

function! s:RefreshStatus()
  for nr in range(1, winnr('$'))
    call setwinvar(nr, '&statusline', '%!Status(' . nr . ')')
  endfor
endfunction

augroup status
  autocmd!
  autocmd VimEnter,WinEnter,BufWinEnter * call <SID>RefreshStatus()
augroup END
" }}}

" Status Colors: {{{
hi! link User1 CursorLineNr
hi! link User2 LineNr
hi! link User3 Pmenu
hi! link User4 LineNr
" }}}

" }}}

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

" move through wrapped lines (you shouldn't do it in insert mode)
" imap <silent> <Down> <C-o>gj
" imap <silent> <Up> <C-o>gk
nmap <silent> <Down> gj
nmap <silent> <Up> gk

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
  let langs = ['en_gb', 'it', 'fr', 'en_us', 'es', '']
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
map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name")
       \ . '> trans<' . synIDattr(synID(line("."),col("."),0),"name")
          \ . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>
"}}}
