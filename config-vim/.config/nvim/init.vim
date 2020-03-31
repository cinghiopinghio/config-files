" vimrc file.

"----------------------------------------------------------------------
" PREABLE
"{{{ PREAMBLE
let maplocalleader=' '
if !has('nvim')
    set nocompatible          " be iMproved
endif
filetype indent plugin on
let s:host=substitute(hostname(), "\\..*", '', '')
syntax on
"}}}
"

"----------------------------------------------------------------------
" Plugin Manager
"{{{ Plug-vim: plugin manager
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

set complete+=k         " enable dictionary completion
set dictionary+=/usr/share/dict/words

if has('nvim') || v:version > 800
    set completeopt=noinsert,menuone,noselect,preview
else
    set completeopt=menuone,preview
endif
set cmdheight=2

" comment uncomment with gcc
Plug 'tpope/vim-commentary'

Plug 'dense-analysis/ale'
if has('nvim')
    Plug 'neovim/nvim-lsp'
    " Plug 'haorenW1025/diagnostic-nvim'
    let g:diagnostic_enable_virtual_text = 1
    Plug 'haorenW1025/completion-nvim'
endif

"  autocompletion
Plug 'lifepillar/vim-mucomplete'
if has('nvim')
    let g:mucomplete#enable_auto_at_startup = 0
else
    let g:mucomplete#enable_auto_at_startup = 1
endif
let g:mucomplete#chains = {
            \ 'default' : ['path', 'incl', 'dict', 'uspl', 'nsnp'],
            \ 'vim'     : ['path', 'cmd', 'incl'],
            \ }

"  complete parenthesis
Plug 'jiangmiao/auto-pairs'
let g:AutoPairs= {'(':')', '[':']', '{':'}',"'":"'",'"':'"', '`':'`'}

"  word editing
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

set scrolloff=5  " never reach the top or bottom of the page

" navigate tags
" Plug 'majutsushi/tagbar'
" nmap <F8> :TagbarToggle<CR>
" Plug 'liuchengxu/vista.vim'
" nmap <F8> :Vista!!<CR>

if has('terminal') || has('nvim')
    Plug 'voldikss/vim-floaterm'
    let g:floaterm_keymap_toggle = '<F12>'
    let g:floaterm_winblend=20
    let g:floaterm_position='center'
    " exit from terminal mode
    tnoremap <Esc> <C-\><C-n>
endif

" Plug 'camspiers/lens.vim'
" let g:lens#animate = 0
" let g:lens#width_resize_max = 80
" let g:lens#width_resize_min = 20

" keep folds as is until save of fold/unfold (save time)
Plug 'Konfekt/FastFold'
" " window splits control
" Plug 'zhaocai/GoldenView.Vim'
" Plug 'justincampbell/vim-eighties'
" Plug 'roman/golden-ratio'
" plugin to remove search highlight once the cursor moved
Plug 'romainl/vim-cool'
"""""""""""""""""""""""""""""""""""""
"{{{ FZF
Plug 'junegunn/fzf', { 'dir': '~/codes/fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" This is the default extra key bindings
let g:fzf_action = {
            \ 'ctrl-t': 'tab split',
            \ 'ctrl-x': 'split',
            \ 'ctrl-v': 'vsplit' }
let g:fzf_colors = {
            \ 'fg':      ['fg', 'Normal'],
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
" let g:fzf_layout = { 'down': '~40%' }
" let $FZF_DEFAULT_COMMAND =  "find * -path '*/\.*' -prune -o -path 'node_modules/**' -prune -o -path 'target/**' -prune -o -path 'dist/**' -prune -o  -type f -print -o -type l -print 2> /dev/null"
let $FZF_DEFAULT_COMMAND =  "fd --hidden --ignore-case --type f --type l 2> /dev/null"
" let $FZF_DEFAULT_OPTS=' --layout=reverse  --margin=1,2 --preview "bat --color always --theme ansi-dark {}"'
let $FZF_DEFAULT_OPTS=' --layout=reverse  --margin=1,2'
" let g:fzf_layout = { 'window': 'call FloatingFZF()' }
" load lua functions for navigation
if has('nvim')
    lua require("navigation")
    let g:fzf_layout = { 'window': 'lua NavigationFloatingWin()' }
endif

function! FloatingFZF()
  let buf = nvim_create_buf(v:false, v:true)
  call setbufvar(buf, '&signcolumn', 'no')

  let height = float2nr(20)
  let width = float2nr(80)
  let horizontal = float2nr((&columns - width) / 2)
  let vertical = 1

  let opts = {
        \ 'relative': 'editor',
        \ 'row': vertical,
        \ 'col': horizontal,
        \ 'width': width,
        \ 'height': height,
        \ 'style': 'minimal'
        \ }

  call nvim_open_win(buf, v:true, opts)
endfunction

" get most recent files with preview
nmap <localleader>ff :Files .<CR>
nmap <localleader>fb :Buffers<cr>
nmap <localleader>fg :GitFiles<cr>
" nmap <localleader>ft :call LanguageClient_textDocument_documentSymbol()<CR>
" use the neomru cache!
Plug 'Shougo/neomru.vim'
command! -bang History
            \ call fzf#run(fzf#wrap({
            \ 'options': '--tiebreak=index',
            \ 'source': 'cat ~/.cache/neomru/file | sed 1d'
            \ }, <bang>0))
nmap <localleader>fr :History<cr>
nmap <localleader>fl :Lines<cr>
au FileType fzf silent! tunmap <Esc>
"}}}

" Align blocks
Plug 'tommcdo/vim-lion'
let g:lion_squeeze_spaces=1
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
" move parameters left or right

" switch position of arguments
Plug 'AndrewRadev/sideways.vim'
nnoremap <m-left> :SidewaysLeft<cr>
nnoremap <m-right> :SidewaysRight<cr>

" A plugin to expand args brtween parenthesis
Plug 'FooSoft/vim-argwrap'
nnoremap <silent> <localleader>a :ArgWrap<CR>

" A vim plugin to display the indention levels with thin vertical lines
Plug 'Yggdroot/indentLine'
let g:indentLine_fileTypeExclude = ['tex', 'markdown']
" let g:indentLine_setColors = 0
let g:indentLine_defaultGroup = 'Comment'
let g:indentLine_setConceal = 0
let g:indentLine_char = '▏'

"{{{ Colorschemes

Plug 'lifepillar/vim-colortemplate'
Plug 'andreypopp/vim-colors-plain'
Plug 'pgdouyon/vim-yin-yang'
Plug 'axvr/photon.vim'
Plug 'freeo/vim-kalisi'
Plug 'tomasr/molokai'

" my colorscheme
let g:mangroove_transparent_bg = 1
let g:mangroove_accent_color='aqua'
if isdirectory(expand('~/codes/mangroove.vim'))
    Plug '~/codes/mangroove.vim'
else
    Plug 'cinghiopinghio/mangroove.vim'
endif
"}}}

" find and replace with s {substitute, search}
Plug 'hauleth/sad.vim'

" {{{ lightline
Plug 'itchyny/lightline.vim'
let g:lightline = {
            \ 'colorscheme': 'jellybeans',
            \ 'active': {
            \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ],
            \ 'right': [ [ 'lineinfo' ],
            \            [ 'percent' ],
            \            [ 'filetype', 'spell' ] ]
            \ },
            \ 'component_function': {
            \   'fugitive': 'GitHead',
            \   'filename': 'LightlineFilename'
            \ },
            \ 'separator': {'left': '', 'right': ''}
            \ }
function! LightlineModified()
    return &ft =~ 'help\|vimfiler' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction
function! LightlineReadonly()
    return &ft !~? 'help\|vimfiler' && &readonly ? 'RO' : ''
endfunction
function! LightlineFilename()
    return ('' != LightlineReadonly() ? LightlineReadonly() . ' ' : '') .
                \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
                \  &ft == 'unite' ? unite#get_status_string() :
                \  &ft == 'vimshell' ? vimshell#get_status_string() :
                \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
                \ ('' != LightlineModified() ? ' ' . LightlineModified() : '')
endfunction

function! GitHead()
    let l:head = ' ' . system("git rev-parse --abbrev-ref HEAD")
    if v:shell_error
        let l:head = ''
    endif
    return substitute(l:head, '\n', '', 'g')
endfunction

function! LightlineFugitive()
    if &ft !~? 'vimfiler' && exists('*fugitive#head')
        return ' ' . fugitive#head()
    endif
    return ''
endfunction
let g:lightline.mode_map = {
            \ 'n' : 'N',
            \ 'i' : 'I',
            \ 'R' : 'R',
            \ 'v' : 'V',
            \ 'V' : 'VL',
            \ "\<C-v>": 'VB',
            \ 'c' : 'C',
            \ 's' : 'S',
            \ 'S' : 'SL',
            \ "\<C-s>": 'SB',
            \ 't': 'T',
            \ }
" }}}

Plug 'AndrewRadev/linediff.vim'
" Plug 'rhysd/vim-grammarous'
Plug 'vigoux/LanguageTool.nvim'
let g:languagetool_server_jar='/usr/share/java/languagetool/languagetool-server.jar'
Plug 'reedes/vim-wordy'

"{{{ Filetype
Plug 'cespare/vim-toml'

Plug 'lervag/vimtex'   ", { 'for': ['tex', 'bib'] }
" There is no reason to lazily load vimtex. Vimtex is a filetype plugin that
" uses the autoload feature, and it does not load or source any vimscript file
" until you open a tex file/buffer.
" https://github.com/lervag/vimtex/issues/885

Plug 'othree/html5.vim'
Plug 'pangloss/vim-javascript'

" Plug 'RRethy/vim-hexokinase'
" Enable for css and xml
" let g:Hexokinase_ftAutoload = ['css', 'xml', 'scss', 'dosini', 'sass']
" let g:Hexokinase_virtualText = '██'
if has('nvim')
    Plug 'norcalli/nvim-colorizer.lua'
else
    Plug 'ap/vim-css-color'
endif
" }}}
call plug#end()
"}}}


if has ("nvim")
    "lua require'nvim_lsp'.pyls.setup{on_attach=require'diagnostic'.on_attach}
    lua require'nvim_lsp'.pyls.setup{
                \ on_attach=require'completion'.on_attach;
                \ capabilities = {
                \   textDocument = {
                \     completion = {
                \       completionItem = {
                \         snippetSupport = true
                \       }
                \     }
                \   }
                \ },
                \ init_options = {
                \   usePlaceholders = true,
                \   completeUnimported = true
                \ }
                \ }
    lua require'nvim_lsp'.bashls.setup{on_attach=require'completion'.on_attach}
    lua require'nvim_lsp'.sumneko_lua.setup{
                \ on_attach=require'completion'.on_attach;
                \ cmd = { "/usr/bin/lua-language-server" };
                \ }
    set termguicolors
    " let DEFAULT_OPTIONS = {
    "             \ RGB      = true;         " #RGB hex codes
    "             \ RRGGBB   = true;         " #RRGGBB hex codes
    "             \ names    = true;         " "Name" codes like Blue
    "             \ RRGGBBAA = false;        " #RRGGBBAA hex codes
    "             \ rgb_fn   = false;        " CSS rgb() and rgba() functions
    "             \ hsl_fn   = false;        " CSS hsl() and hsla() functions
    "             \ css      = false;        " Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
    "             \ css_fn   = false;        " Enable all CSS *functions*: rgb_fn, hsl_fn
    "             \ mode     = 'background'; " Set the display mode.
    "             \ }
    lua require'colorizer'.setup (
                \ { '*'; '!vim-plug'; 'lua'; },
                \ { rgb_fn=true; RRGGBBAA=true; }
                \ )
    " autocmd FileType scss lua require'colorizer/sass'.attach_to_buffer()
endif

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
set shiftwidth=4 softtabstop=4 expandtab smarttab
set autochdir
" show command output as-you-type
if has('nvim')
    set inccommand=nosplit
endif

set textwidth=0
set wrapmargin=0
set colorcolumn=80
set cursorline

set nonumber
set norelativenumber

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

iabbrev mf Mauro Faccin
iabbrev ... …

"{{{ THEME and COLORS
if has('termguicolors')
    " enable 24bit colors for the terminal
    set termguicolors
endif

" set to dark
set background=dark
" use this script to know the background
exec 'set background=' . system("~/.local/bin/day2night")

function! ToggleBackground()
    if &background == 'dark'
        set background=light
    else
        set background=dark
    endif
endfunction

function! TransparentBG() abort
    highlight Normal guibg=none ctermbg=none
    highlight NonText guibg=none ctermbg=none
endfunction

" if !empty($NOGUI)
"     call TransparentBG()
"     augroup transparent_background
"         autocmd!
"         autocmd ColorScheme * call TransparentBG()
"         autocmd ColorScheme * call TransparentBG()
"     augroup END
" endif
nnoremap <F9> :call ToggleBackground()<CR>

if has('conceal')
    set conceallevel=2
    set concealcursor=""   " do not conceal on my line
    let g:tex_conceal="abdmgs"
    "   a = accents/ligatures
    "   b = bold and italic
    "   d = delimiters
    "   m = math symbols
    "   g = Greek
    "   s = superscripts/subscripts
endif

" function! ReadableConceals() abort
"     if &background == 'dark'
"         highlight Conceal guifg=#ffffff
"     else
"         highlight Conceal guifg=#000000
"     endif
" endfunction
" augroup MyConcealColors
"     autocmd!
"     autocmd ColorScheme * call ReadableConceals()
"     " autocmd ColorScheme * highlight link Conceal Normal
" augroup END

if s:host == 'spin'
    colorscheme seoul256
elseif s:host == 'dingo' && has('nvim')
    let g:futon_transp_bg=1
    colorscheme futon
else
    colorscheme molokai
endif
" call ReadableConceals()
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
if has('nvim')
    set wildoptions=pum
    set pumblend=20
    hi PmenuSel blend=0
endif
set ls=2  " show statusline always
set dir=/tmp//,/var/tmp//,.
set mouse=a
"}}}

"{{{ Run it
function! Runnit(runner)
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
    au FileType javascript nnoremap <buffer> <F7> :call Runnit('node ' . expand('%'))<CR>
    au FileType make nnoremap <buffer> <F7> :call Runnit('make --always-make --silent --dry-run')<CR>
    au FileType lua nnoremap <buffer> <F7> :call Runnit('lua ' . expand('%'))<CR>
augroup END
"}}}

command! Top call Runnit("top")

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
let g:local_dictionaries = {
            \ 'it': ['/usr/share/dict/italian'],
            \ 'en_gb': ['/usr/share/dict/british-english'],
            \ 'fr': ['/usr/share/dict/french'],
            \ 'es': ['/share/dict/spanish'],
            \ }

function! CycleLang()
    let langs = ['en_gb', 'it', 'fr', 'es', '']
    set dictionary=/usr/share/dict/words
    let i = index(langs, &spelllang)
    let j = (i+1)%len(langs)
    let &spelllang = langs[j]

    if empty(&spelllang)
        set nospell
        echo 'Unset spell language'
    else
        set spell
        echo 'Using: "'.&spelllang.'" spell language'
        for dict in g:local_dictionaries[&spelllang]
            exe 'set dictionary+='.dict
        endfor
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
"
"

"
" DEOPLETE
"
" call deoplete#custom#source('vim',           'mark', 'V')
" call deoplete#custom#source('around',        'mark', '[]')
" call deoplete#custom#source('buffer',        'mark', 'B')
" call deoplete#custom#source('syntax',        'mark', '#')
" call deoplete#custom#source('member',        'mark', '.')


" LanguageClient
" Automatically call highlight and hover
function! LspMaybeHover(is_running) abort
  if a:is_running.result
    call LanguageClient_textDocument_hover()
  endif
endfunction

function! LspMaybeHighlight(is_running) abort
  if a:is_running.result
    call LanguageClient_clearDocumentHighlight()
    call LanguageClient#textDocument_documentHighlight()
  endif
endfunction

augroup lsp_aucommands
  au!
  " au CursorHold * call LanguageClient#isAlive(function('LspMaybeHover'))
  " au CursorMoved * call LanguageClient#isAlive(function('LspMaybeHighlight'))
augroup END

" inoremap <C-i> <esc>:call LanguageClient#textDocument_signatureHelp()<cr>a
