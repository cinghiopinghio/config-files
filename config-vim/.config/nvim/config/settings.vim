" INDENT
set autoindent    " copy indent from current line when starting a new line
set smartindent   " do smart autoindenting
set shiftwidth=4  " Number of spaces to use for each step of (auto)indent.
set softtabstop=4 " Number of spaces that a <Tab> counts for
set expandtab     " Use the appropriate number of spaces to insert a <Tab>.
set smarttab      " a <Tab> in front of a line inserts blanks according to 'shiftwidth'.
set formatoptions=tcrqnl1j
    " auto format
    " t text
    " c comments
    " r auto comment new line
    " q auto format comments with gq
    " n respect lists
    " l long lines are not broken
    " 1 break before one-char words
    " j remove comment leader when joining


set backspace=indent,eol,start " allow backspacing over everything in insert mode
set history=100                " keep 100 lines of command line history
set noruler                    " statusline already has it
set noshowcmd                  " display incomplete commands (slow)

set isfname+={,}           " some filenames iclude parenthesis (useful for `gf`)
set clipboard+=unnamedplus " yank and copy to clipboard
set title                  " set terminal title

" SEARCH
set hlsearch   " highlight what I'm searching
set incsearch  " do incremental searching
set ignorecase " case-insensitive search
set smartcase  " upper-case sensitive search

" using rooter.vim
" set autochdir
if has('nvim')
    set inccommand=split " show command output as-you-type
endif

set winwidth=80
set winminwidth=20

set colorcolumn=80
set cursorline
set number
set norelativenumber

set scrolloff=5  " never reach the top or bottom of the page

"wrapping
set wrap
" set wrapmargin=20 " wrap from wrapmargin columns from right (insert <EOL>)
set linebreak " Vim will wrap long lines at a character in 'breakat' rather
set showbreak=↳\ 
set breakindent

set splitbelow " new split below current
set splitright " new vsplit right of current

set list " show tabs and trailing whitespaces
set listchars=tab:╟─,trail:┄,extends:┄
set fillchars+=vert:┃

iabbrev mf Mauro Faccin
iabbrev ... …

if has('termguicolors')
    set termguicolors " enable 24bit colors for the terminal
endif

" set to dark
set background=dark
" use this script to know the background
if !empty(glob("~/.local/bin/day2night"))
    exec 'set background=' . system("~/.local/bin/day2night")
endif

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

let s:host=substitute(hostname(), "\\..*", '', '')
if s:host == 'spin'
    colorscheme seoul256
elseif s:host == 'dingo' && has('nvim')
    let g:futon_transp_bg=1
    colorscheme futon
else
    colorscheme molokai
endif
"}}}

set makeprg=make
set grepprg=grep\ -nH\ $*
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
    set winblend=20
endif

set ls=2  " show statusline always
set dir=/tmp//,/var/tmp//,.
set mouse=a
