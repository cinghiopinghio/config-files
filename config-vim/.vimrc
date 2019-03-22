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
"

"----------------------------------------------------------------------
" Plugin Manager
"{{{ Pluc-vim: plugin manager
"{{{ Install it
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
"}}}

"{{{ Syntax, dictionary ... AutoCompletion

set complete+=k         " enable dictionary completion
set dictionary+=/usr/share/dict/cracklib-small

" comment uncomment
Plug 'tpope/vim-commentary'

set completeopt=noinsert,menuone,noselect

if has('nvim') || v:version >= 800
  Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh' }

  " Plug 'Shougo/echodoc.vim'
  " set cmdheight=2
  " let g:echodoc#enable_at_startup = 1
  " let g:echodoc#type = 'echo'
  " Required for operations modifying multiple buffers like rename.
  " set hidden

  let g:LanguageClient_serverCommands = {
      \ 'python': ['pyls'],
      \ 'sh': ['bash-language-server', 'start'],
      \ 'html': ['html-languageserver', '--stdio'],
      \ 'css': ['css-languageserver', '--stdio'],
      \ 'json': ['json-languageserver', '--stdio'],
      \ 'tex': ['~/.luarocks/bin/digestif'],
      \ }
  nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
  nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
  nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>

  " Automatically start language servers.
  let g:LanguageClient_autoStart = 1
  let g:LanguageClient_useVirtualText = 1
  let g:LanguageClient_hasSnippetSupport = 0
endif

"  complete parenthesis
"{{{ jiangmiao/auto-pairs
Plug 'jiangmiao/auto-pairs'
let g:AutoPairs= {'(':')', '[':']', '{':'}',"'":"'",'"':'"', '`':'`'}
"}}}

"  autocompletion
"{{{ deoplete / completor / VimCompletesMe / NCM
if has('nvim')
  " Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install()}}
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  " Plug 'ncm2/ncm2'
  " Plug 'roxma/nvim-yarp'
  " Plug 'ncm2/ncm2-bufword'
  " Plug 'ncm2/ncm2-path'
  " Plug 'ncm2/ncm2-syntax' | Plug 'Shougo/neco-syntax'
  " Plug 'fgrsnau/ncm2-aspell'
  " autocmd BufEnter  *  call ncm2#enable_for_buffer()
elseif v:version >= 800
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
  " Plug 'zchee/deoplete-jedi'
else
  " Plug 'ajh17/VimCompletesMe'
  Plug 'lifepillar/vim-mucomplete'
  let g:mucomplete#enable_auto_at_startup = 1
  	let g:mucomplete#chains = {
              \ 'default' : ['path', 'omni', 'keyn', 'dict', 'uspl'],
              \ 'vim'     : ['path', 'cmd', 'keyn'],
              \ 'python'  : ['path', 'cmd', 'keyn', 'uspl']
              \ }
endif

let g:deoplete#enable_at_startup = 1

"}}}

"  snippets
" {{{ ultisnips
" if has('python')
"   Plug 'SirVer/ultisnips'
"   let g:UltiSnipsExpandTrigger='<c-j>'
"   let g:UltiSnipsListSnippets='<c-l>'
" else
"   Plug 'MarcWeber/vim-addon-mw-utils'
"   Plug 'tomtom/tlib_vim'
"   Plug 'garbas/vim-snipmate'
"   imap <C-j> <Plug>snipMateNextOrTrigger
"   smap <C-j> <Plug>snipMateNextOrTrigger
"   imap <C-l> <Plug>snipMateShow
" endif
" Plug 'honza/vim-snippets'
" Plug 'Shougo/neosnippet.vim'
" Plug 'Shougo/neosnippet-snippets'
" Plugin key-mappings.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
" imap <C-j>     <Plug>(neosnippet_expand_or_jump)
" smap <C-j>     <Plug>(neosnippet_expand_or_jump)
" xmap <C-j>     <Plug>(neosnippet_expand_target)

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif
" let g:neosnippet#enable_completed_snippet = 1
" autocmd CompleteDone * call neosnippet#complete_done()
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

" navigate tags
Plug 'majutsushi/tagbar'
nmap <F8> :TagbarToggle<CR>

" keep folds as is until save of fold/unfold (save time)
Plug 'Konfekt/FastFold'
" " window splits control
" Plug 'zhaocai/GoldenView.Vim'
" Plug 'justincampbell/vim-eighties'
Plug 'roman/golden-ratio'
"""""""""""""""""""""""""""""""""""""
"{{{ FZF
Plug 'junegunn/fzf', { 'dir': '~/codes/fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" This is the default extra key bindings
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

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
nmap <localleader>ft :call LanguageClient_textDocument_documentSymbol()<CR>
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

Plug 'hauleth/sad.vim'
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

" highlight current word
Plug 'RRethy/vim-illuminate'
" Don't highlight word under cursor (default: 1)
let g:Illuminate_highlightUnderCursor = 0

" Plug 'dominikduda/vim_current_word'
" " Twins of word under cursor:
" let g:vim_current_word#highlight_twins = 1
" " The word under cursor:
" let g:vim_current_word#highlight_current_word = 0

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
Plug 'andreypopp/vim-colors-plain'

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
"
Plug 'mhinz/vim-signify'
let g:signify_vcs_list = [ 'git', 'svn' ]
let g:signify_disable_by_default = 1

Plug 'itchyny/lightline.vim'
let g:lightline = {
      \ 'colorscheme': 'jellybeans',
      \ }

" Plug 'airblade/vim-gitgutter'
let g:gitgutter_map_keys = 0   " do not set maps
Plug 'tpope/vim-fugitive'
Plug 'Yggdroot/indentLine'
let g:indentLine_fileTypeExclude = ['tex', 'markdown']

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
Plug 'pangloss/vim-javascript'
Plug 'ap/vim-css-color'
" }}}
"}}}
" Used from gonvim to set fonts
Plug 'equalsraf/neovim-gui-shim'
Plug 'https://gitlab.com/dbeniamine/todo.txt-vim'
call plug#end()
"}}}
"
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
set autochdir

set textwidth=0
set wrapmargin=0
set colorcolumn=80
set cursorline

set number
set relativenumber

"wrapping
set wrap
set linebreak
let &showbreak="~> "

set splitbelow
set splitright

" set terminal title
set title

" show tabs and trailing whitespaces
set list
set listchars=tab:╟─,trail:┄,extends:┄

let g:tex_conceal="a"

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

" " Status Line: {{{
" function! TrailingSpaceWarning()
"   if !exists('b:statline_trailing_space_warning')
"     let lineno = search('\s$', 'nw')
"     if lineno != 0
"       let b:statline_trailing_space_warning = '[TS:'.lineno.']'
"     else
"       let b:statline_trailing_space_warning = ''
"     endif
"   endif
"   return b:statline_trailing_space_warning
" endfunction

" " recalculate when idle, and after saving
" augroup statline_trail
"   autocmd!
"   autocmd cursorhold,bufwritepost * unlet! b:statline_trailing_space_warning
" augroup END
" " Status Function: {{{2
" function! Status(winnum)
"   let active = a:winnum == winnr()
"   let bufnum = winbufnr(a:winnum)

"   let stat = ''

"   " this function just outputs the content colored by the
"   " supplied colorgroup number, e.g. num = 2 -> User2
"   " it only colors the input if the window is the currently
"   " focused one

"   function! Color(active, num, content)
"     if a:active
"       return '%' . a:num . '*' . a:content . '%*'
"     else
"       return a:content
"     endif
"   endfunction

"   " this handles alternative statuslines
"   let usealt = 0

"   let type = getbufvar(bufnum, '&buftype')
"   let name = bufname(bufnum)

"   if type ==# 'help'
"     let altstat = ' ' . fnamemodify(name, ':t:r')
"     let usealt = 1
"   elseif name ==# '__Gundo__'
"     let altstat = ' Gundo'
"     let usealt = 1
"   elseif name ==# '__Gundo_Preview__'
"     let altstat = ' Gundo Preview'
"     let usealt = 1
"   elseif type ==# 'quickfix'
"     let altstat = ' QuickFix'
"     let usealt = 1
"   elseif name == ''
"     let altstat = ' NoName'
"     let usealt = 1
"   endif

"   if usealt
"     return altstat . "%=%Y "
"   endif

"   " file name
"   let stat .= Color(active, 3, expand('#' . bufnum . ':p:h:~') . '/' )
"   " let stat .= expand('#' . bufnum . ':p:h:~') . '/'
"   let stat .= Color(active, 1, expand('#' . bufnum . ':t'))
"   let stat .= ' %<'  " truncate here if too long

"   " file modified + readonly
"   let stat .= Color(active, 1, '%m%r')

"   " paste
"   if active && &paste
"     let stat .= Color(active, 2, 'P')
"   endif

"   if active
"      let stat .= TrailingSpaceWarning()
"   endif

"   " right side
"   let stat .= '%='

"   " git branch
"   let head = fugitive#head(8)
"   if active && !empty(head)
"     let stat .= ' [' . head . ']'
"   endif

"   if active
"     let stat .= Color(active, 2, ' %l/%L')
"   endif

"   return stat
" endfunction
" " }}}

" " Status AutoCMD: {{{

" function! s:RefreshStatus()
"   for nr in range(1, winnr('$'))
"     call setwinvar(nr, '&statusline', '%!Status(' . nr . ')')
"   endfor
" endfunction

" augroup status
"   autocmd!
"   " autocmd VimEnter,WinEnter,BufWinEnter * call <SID>RefreshStatus()
"   autocmd BufWinEnter,VimEnter,WinEnter * call setwinvar(winnr(), '&statusline', '%!Status(' . winnr() . ')')
"   autocmd WinLeave * call setwinvar(winnr(), '&statusline', '%!Status(' . winnr() . ')')
" augroup END
" " }}}

" " Status Colors: {{{
" hi! link User1 CursorLineNr
" hi! link User2 LineNr
" hi! link User3 StatusLineNC
" " }}}

" " }}}

"{{{ Run it

function Runnit(runner)
  if !exists('b:runnitBuffer')
    let b:runnitBuffer = {}
  endif
  if has_key(b:runnitBuffer, a:runner) && bufwinnr(b:runnitBuffer[a:runner]) > 0
    let l:buff=remove(b:runnitBuffer, a:runner)
    exec 'bdelete! ' . l:buff
  endif
  " if exists('b:runnitBuffer') && bufwinnr(b:runnitBuffer) > 0
  "   exec 'bdelete! ' . b:runnitBuffer
  " endif
  vsplit
  exec 'terminal ' . a:runner
  let l:runnitBuffer = winbufnr(0)
  execute "normal G"
  wincmd p
  let b:runnitBuffer[a:runner] = l:runnitBuffer
endfunction

augroup runner_filetype
  au!
  au FileType python nnoremap <buffer> <F7> :call Runnit('python ' . expand('%'))<CR>
  au FileType sh nnoremap <buffer> <F7> :call Runnit('bash ' . expand('%'))<CR>
augroup END
"}}}

command Top call Runnit("top")

"-------------------------------------------------------------------------
" MAP
"{{{ Key mappings
""" open file under cursor on a tab
"toggle buffers
nnoremap <F5> :buffers<CR>:buffer<Space>
" resize current buffer by +/- 5
nnoremap <C-left> :vertical resize -5<cr>
nnoremap <C-down> :resize +5<cr>
nnoremap <C-up> :resize -5<cr>
nnoremap <C-right> :vertical resize +5<cr>

nnoremap <c-t> :tabnew<cr>

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
