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
    set completeopt=noinsert,menuone,noselect
else
    set completeopt=menuone
endif
set cmdheight=2

" comment uncomment with gcc
Plug 'tpope/vim-commentary'

" Linter and grammar
" {{{
if ! has('nvim-0.5')
    Plug 'dense-analysis/ale'
    let g:ale_lint_on_insert_leave=1
    let g:ale_linters = {
                \ 'python': ['pylint']
                \}
endif

" Plug 'rhysd/vim-grammarous'
" Plug 'vigoux/LanguageTool.nvim'
" let g:languagetool_server_jar='/usr/share/java/languagetool/languagetool-server.jar'
Plug 'reedes/vim-wordy'
Plug 'davidbeckingsale/writegood.vim'
" }}}

" Completion
" {{{
if has('nvim-0.5')
    Plug 'neovim/nvim-lspconfig'
    Plug 'nvim-lua/completion-nvim'
    let g:completion_enable_snippet = 'UltiSnips'
    let g:completion_enable_auto_paren = 0
    " let g:completion_enable_auto_hover = 1
    let g:completion_enable_auto_signature = 1
    " let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']
    let g:completion_matching_strategy_list = ['exact', 'substring']
    let g:completion_auto_change_source = 1
    let g:completion_matching_ignore_case = 1
    " " Configure the completion chains
    " imap <c-j> <cmd>lua require'source'.prevCompletion()<CR>
    " imap <c-k> <cmd>lua require'source'.nextCompletion()<CR>

    Plug 'steelsojka/completion-buffers'

    Plug 'nvim-treesitter/nvim-treesitter'
    Plug 'romgrk/nvim-treesitter-context'
    Plug 'nvim-treesitter/completion-treesitter' " New home
    Plug 'nvim-treesitter/nvim-treesitter-refactor'
    " let g:completion_chain_complete_list = {
    "             \ 'default' : [
    "             \     {'complete_items' : ['lsp', 'snippet']},
    "             \     {'mode' : 'file'}
    "             \ ],
    "             \ 'vim' : [
    "             \     {'complete_items': ['snippet']},
    "             \     {'mode' : 'cmd'}
    "             \     ],
    "             \ 'python' : [
    "             \     {'complete_items': ['ts', 'snippet']},
    "             \     {'mode' : 'file'}
    "             \     ],
    "             \ 'lua' : [
    "             \     {'complete_items': ['ts']}
    "             \     ],
    "             \ }
    let g:completion_chain_complete_list = [
                \ {'complete_items': ['lsp', 'snippet', 'buffers']},
                \ {'complete_items': ['ts']},
                \ {'mode': 'file'},
                \ {'mode': 'dict'},
                \ {'mode': '<c-p>'},
                \ {'mode': '<c-n>'}
                \ ]

    " " Use completion-nvim in every buffer
    autocmd BufEnter * lua require'completion'.on_attach()

elseif has('nvim')
    Plug 'autozimu/LanguageClient-neovim', {
                \ 'branch': 'next',
                \ 'do': 'bash install.sh',
                \ }

    let g:LanguageClient_serverCommands = {
                \ 'rust': ['rls'],
                \ 'javascript': ['javascript-typescript-stdio'],
                \ 'python': ['jedi-language-server'],
                \ 'lua': ['lua-language-server'],
                \ 'latex': ['texlab'],
                \ 'vim': ['vim-language-server'],
                \ 'sh': ['bash-language-server'],
                \ }
    nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
    nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
    nnoremap <silent> <F2> :call LanguageClient#textDocument_signatureHelp()<CR>

    " Plug 'Shougo/echodoc.vim'
    " let g:echodoc#enable_at_startup = 1
    " let g:echodoc#type = 'floating'

    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    " Plug 'deoplete-plugins/deoplete-jedi'
    " Plug 'paretje/deoplete-notmuch', {'for': 'mail'}
    let g:deoplete#enable_at_startup = 1

else
    Plug 'davidhalter/jedi-vim'
    let g:jedi#popup_on_dot = 0  " It may be 1 as well
    " autocompletion
    Plug 'lifepillar/vim-mucomplete'
    let g:mucomplete#enable_auto_at_startup = 0
    let g:mucomplete#completion_delay = 500

    " Compatibily issues
    let g:AutoPairsMapSpace = 0
    imap <silent> <expr> <space> pumvisible()
        \ ? "<space>"
        \ : "<c-r>=AutoPairsSpace()<cr>"
    " let g:AutoPairsMapCR = 0
    " imap <Plug>MyCR <Plug>(MUcompleteCR)<Plug>AutoPairsReturn
    " imap <cr> <Plug>MyCR
endif
" }}}

" Snippets
" {{{
" Track the engine.
Plug 'SirVer/ultisnips'

" Snippets are separated from the engine. Add this if you want them:
Plug 'honza/vim-snippets'
let g:UltiSnipsExpandTrigger = "<c-k>"        " Do not use <tab>
let g:UltiSnipsJumpForwardTrigger = "<c-k>"  " Do not use <c-j>
" }}}

"  complete parenthesis
Plug 'jiangmiao/auto-pairs'
let g:AutoPairs= {'(':')', '[':']', '{':'}',"'":"'",'"':'"', '`':'`'}

"  word editing (ctrl-A)
"  {{{
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
"  }}}

" navigate tags
" Plug 'majutsushi/tagbar'
" nmap <F8> :TagbarToggle<CR>
Plug 'liuchengxu/vista.vim'
nmap <localleader>ft :Vista finder<cr>

if has('terminal') || has('nvim')
    Plug 'voldikss/vim-floaterm'
    let g:floaterm_keymap_toggle = '<F12>'
    let g:floaterm_winblend=20
    let g:floaterm_position='center'
    " exit from terminal mode
    tnoremap <Esc> <C-\><C-n>
endif

" keep folds as is until save of fold/unfold (save time)
Plug 'Konfekt/FastFold'
" " window splits control
" plugin to remove search highlight once the cursor moved
Plug 'romainl/vim-cool'
" find and replace with s {substitute, search}
Plug 'hauleth/sad.vim'
" highlight coursos on jumps
Plug 'DanilaMihailov/beacon.nvim'
" A vim plugin to display the indention levels with thin vertical lines
if has('nvim') || v:version > 800
    Plug 'Yggdroot/indentLine'
    let g:indentLine_fileTypeExclude = ['tex', 'markdown']
    " let g:indentLine_setColors = 0
    let g:indentLine_defaultGroup = 'Comment'
    let g:indentLine_setConceal = 0
    let g:indentLine_char = '▏'
endif
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
            \ 'bg':      ['bg', 'Pmenu'],
            \ 'hl':      ['fg', 'Warning'],
            \ 'fg+':     ['fg', 'PmenuSel', 'CursorColumn', 'Normal'],
            \ 'bg+':     ['bg', 'PmenuSel', 'CursorColumn'],
            \ 'hl+':     ['fg', 'Error'],
            \ 'info':    ['fg', 'PreProc'],
            \ 'border':  ['fg', 'Pmenu'],
            \ 'prompt':  ['fg', 'Conditional'],
            \ 'pointer': ['fg', 'Exception'],
            \ 'marker':  ['fg', 'Keyword'],
            \ 'spinner': ['fg', 'Label'],
            \ 'header':  ['fg', 'PmenuSel'] }

if has('nvim')
    " load lua functions for navigation
    lua require("navigation")
    let g:fzf_layout = { 'window': 'lua NavigationFloatingWin()' }
else
    let g:fzf_layout = { 'down': '~40%' }
endif

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

"{{{ Colorschemes

Plug 'rktjmp/lush.nvim'
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

" {{{ lightline
Plug 'bluz71/vim-moonfly-statusline'
let g:moonflyIgnoreDefaultColors = 0
let g:moonflyWithNvimLspIndicator = 0

" Plug 'cocopon/shadeline.vim'
" let g:shadeline = {}
" let g:shadeline.active = {
"       \   'left':  ['fname', 'LightlineGitHead', 'flags'],
"       \   'right': ['ruler']
"       \ }
" let g:shadeline.inactive = {
"       \   'left':  ['fname', 'flags']
"       \ }

" Plug 'adelarsq/neoline.vim'

" Plug 'itchyny/lightline.vim'
" let g:lightline = {
"             \ 'colorscheme': 'jellybeans',
"             \ 'active': {
"             \   'left': [ [ 'mode', 'paste' ], [ 'git', 'filename' ] ],
"             \ 'right': [ [ 'lineinfo' ],
"             \            [ 'percent' ],
"             \            [ 'filetype', 'spell' ] ]
"             \ },
"             \ 'component_function': {
"             \   'git': 'LightlineGitHead',
"             \   'filename': 'LightlineFilename'
"             \ },
"             \ 'separator': {'left': '', 'right': ''}
"             \ }
" function! LightlineModified()
"     return &ft =~ 'help\|vimfiler' ? '' : &modified ? '+' : &modifiable ? '' : '-'
" endfunction
" function! LightlineReadonly()
"     return &ft !~? 'help\|vimfiler' && &readonly ? 'RO' : ''
" endfunction
" function! LightlineFilename()
"     return ('' != LightlineReadonly() ? LightlineReadonly() . ' ' : '') .
"                 \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
"                 \  &ft == 'unite' ? unite#get_status_string() :
"                 \  &ft == 'vimshell' ? vimshell#get_status_string() :
"                 \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
"                 \ ('' != LightlineModified() ? ' ' . LightlineModified() : '')
" endfunction

function! LightlineGitHead()
    let l:head = ' ' . system("git rev-parse --abbrev-ref HEAD")
    if v:shell_error
        let l:head = ''
    endif
    return substitute(l:head, '\n', '', 'g')
endfunction

" let g:lightline.mode_map = {
"             \ 'n' : 'N',
"             \ 'i' : 'I',
"             \ 'R' : 'R',
"             \ 'v' : 'V',
"             \ 'V' : 'VL',
"             \ "\<C-v>": 'VB',
"             \ 'c' : 'C',
"             \ 's' : 'S',
"             \ 'S' : 'SL',
"             \ "\<C-s>": 'SB',
"             \ 't': 'T',
"             \ }
" " }}}

Plug 'AndrewRadev/linediff.vim'

"{{{ Filetype

Plug 'cespare/vim-toml'

Plug 'freitass/todo.txt-vim'

Plug 'lervag/vimtex'

Plug 'othree/html5.vim'
Plug 'pangloss/vim-javascript'

if has('nvim')
    Plug 'norcalli/nvim-colorizer.lua'
else
    Plug 'ap/vim-css-color'
endif

Plug 'goerz/jupytext.vim'
let g:jupytext_fmt = 'py'

if has('nvim')
    Plug 'mcchrish/info-window.nvim'
    command! InfoWindowCustomToggle call infowindow#toggle({} , { default_lines -> extend(default_lines, [['words', split(system('wc -w '. expand('%')))[0]]]) })
    nnoremap <silent> <c-g> :InfoWindowCustomToggle<cr>
endif
if (v:version > 810) || has('nvim')
    Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }
endif
Plug 'ferrine/md-img-paste.vim'
" Plug '~/codes/md-img-paste.vim'

" }}}
call plug#end()
"}}}

if has ("nvim")
    set termguicolors
    if has ("nvim-0.5")
        lua require('init')

    else
        " Use smartcase.
        call deoplete#custom#option('smart_case', v:true)
    endif
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
endif " has("autocmd")}}}
set autoindent    " always set autoindenting on
set smartindent

if &diff
    setlocal wrap
endif

"-------------------------------------------------------------------------
" SET
""{{{ Settings

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
set backspace=indent,eol,start " allow backspacing over everything in insert mode
set history=100                 " keep 100 lines of command line history
" set ruler                      " show the cursor position all the time
" set showcmd                    " display incomplete commands
"

" The isfname setting specifies the set of characters that can appear in file names. It does not include { and } by default.
set isfname+={,}

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

set scrolloff=5  " never reach the top or bottom of the page

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
let g:tex_flavor = 'latex'

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
" set pastetoggle=<F2>
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
    set winblend=20
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

" avoid calling :Windows each time
command! W :w

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
