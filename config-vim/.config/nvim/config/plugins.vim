
"{{{ Install it
if has('nvim')
    if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
        silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
                    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
    endif
    call plug#begin('~/.local/share/nvim/plugged')
else
    if empty(glob('~/.vim/autoload/plug.vim'))
        silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
                    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
    endif
    call plug#begin('~/.vim/plugged')
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
Plug 'tpope/vim-speeddating'

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
if has('nvim-0.5')
    " {{{
    Plug 'neovim/nvim-lspconfig'

    Plug 'nvim-lua/completion-nvim'
    let g:completion_enable_snippet = 'UltiSnips'
    let g:completion_enable_auto_paren = 1
    let g:completion_enable_auto_hover = 1
    let g:completion_enable_auto_signature = 1
    " let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']
    let g:completion_matching_strategy_list = ['exact', 'substring']
    let g:completion_auto_change_source = 1
    let g:completion_matching_ignore_case = 1
    let g:completion_sorting = 'lenght'
    " " Configure the completion chains
    " imap <c-j> <cmd>lua require'source'.prevCompletion()<CR>
    " imap <c-k> <cmd>lua require'source'.nextCompletion()<CR>

    Plug 'steelsojka/completion-buffers'

    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
    Plug 'romgrk/nvim-treesitter-context'
    Plug 'nvim-treesitter/completion-treesitter' " New home
    Plug 'nvim-treesitter/nvim-treesitter-refactor'
    let g:completion_chain_complete_list = [
                \ {'complete_items': ['ts']},
                \ {'complete_items': ['lsp', 'snippet', 'buffers']},
                \ {'mode': 'file'},
                \ {'mode': 'dict'},
                \ {'mode': '<c-p>'},
                \ {'mode': '<c-n>'}
                \ ]

    " use TAB to cycle through completions sources
    " Do not use `inoremap` since it prevent the expansion of <Plug>
    imap <expr> <Tab> pumvisible() ? "\<Plug>(completion_next_source)" : "\<Tab>"
    autocmd BufEnter * lua require'completion'.on_attach()

    Plug 'nvim-treesitter/playground'

    " Plug 'glepnir/lspsaga.nvim'
    " Plug 'kkoomen/vim-doge', { 'do': { -> doge#install() } }
    " Plug 'mg979/docgen.vim'
    " }}}
elseif has('nvim')
    " {{{
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
                " \ 'python': ['anakinls'],
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
    " }}}
else
    "{{{
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
    "}}}
endif

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
if has('nvim')
    Plug 'lukas-reineke/indent-blankline.nvim', { 'branch': 'lua' }
    let g:indent_blankline_filetype_exclude = ['tex', 'markdown', 'help', 'no ft']
    let g:indent_blankline_buftype_exclude = ['terminal']
    let g:indent_blankline_char_highlight = 'Comment'
    let g:indent_blankline_char = '▏'
    let g:indent_blankline_use_treesitter = v:false
    let g:indent_blankline_show_trailing_blankline_indent = v:false
elseif v:version > 800
    Plug 'Yggdroot/indentLine'
    let g:indentLine_fileTypeExclude = ['tex', 'markdown']
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
" Plug 'bluz71/vim-moonfly-statusline'
" let g:moonflyIgnoreDefaultColors = 0
" let g:moonflyWithNvimLspIndicator = 0

Plug 'datwaft/bubbly.nvim'
" Plug '~/codes/vimplugs/bubbly.nvim'

" so 'config/statusline.vim'

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

" Plug 'pacha/vem-statusline'

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

" Plug 'dylanaraps/root.vim'
" let g:root#patterns = ['.git', '_darcs', '.hg', '.bzr', '.svn', 'Makefile']
" let g:root#auto = 1
Plug 'airblade/vim-rooter'
let g:rooter_targets = '*'
let g:rooter_patterns = ['.git', 'Makefile', 'README.md']
let g:rooter_change_directory_for_non_project_files = 'current'

"{{{ Filetype

Plug 'cespare/vim-toml'

Plug 'freitass/todo.txt-vim'

Plug 'lervag/vimtex'

Plug 'othree/html5.vim'
Plug 'pangloss/vim-javascript'

if has('nvim')
    Plug 'norcalli/nvim-colorizer.lua'
    au TermOpen * ColorizerAttachToBuffer
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
"

" Plug 'erietz/vim-terminator'
" let g:terminator_clear_default_mappings=1
" nnoremap <F7> :TerminatorRunCurrentFile<CR>

Plug '~/codes/vimplugs/simplerun.vim'
command! Top call simplerun#toggle("top")
nnoremap <F7> :call simplerun#toggle()<CR>

Plug '~/codes/vimplugs/futon.vim'

call plug#end()
