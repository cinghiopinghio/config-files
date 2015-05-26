" vimrc file.

"----------------------------------------------------------------------
" PREABLE
"{{{ PREAMBLE
let maplocalleader=' '
set nocompatible               " be iMproved
filetype indent plugin on
let s:host=substitute(hostname(), "\\..*", "", "") 
if s:host == 'giove'
  set term=builtin_ansi
  set t_Co=256
endif
syntax on
"}}}

"----------------------------------------------------------------------
" Plugin Manager
""{{{ Vundle: plugin manager
call plug#begin('~/.vim/bundle')

Plug 'tpope/vim-fugitive'
Plug 'mhinz/vim-signify'
"""""""" outliner
"Plug 'vim-scripts/VOoM'
"Plug 'majutsushi/tagbar'
"""""""" syntax checker
Plug 'scrooloose/syntastic'
"""""""" folder navigation
"Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
"Plug 'istib/vifm.vim'
""""""" AutoCompletion
"Plug 'jiangmiao/auto-pairs'
Plug 'Raimondi/delimitMate'
Plug 'ajh17/VimCompletesMe'
"Plug 'ervandew/supertab'
"Plug 'Valloric/YouCompleteMe'
"Plug 'Shougo/neocomplete.vim'
"Plug 'Shougo/neocomplcache'
""""""" snippets
"Plug 'honza/snipmate-snippets'
"Plug 'garbas/vim-snipmate'
"Plug 'MarcWeber/ultisnips'
if has("python")
  Plug 'SirVer/ultisnips'
  Plug 'honza/vim-snippets'
endif
"Plug 'nvie/vim-flake8', { 'for': 'python' }

Plug 'davidhalter/jedi-vim', { 'for': 'python' }
" prevent slow popups
let g:jedi#popup_on_dot = 0
let g:jedi#show_call_signatures = 0 

"Plug 'JuliaLang/julia-vim', { 'for': 'julia' }
""""""" window splits control
Plug 'zhaocai/GoldenView.Vim'
Plug 'itchyny/thumbnail.vim', { 'on': 'Thumbnail' }
""""""" parenthesis change
Plug 'tpope/vim-surround'
"Plug 'zef/vim-cycle' " No upper cases like 'True/False'
Plug 'mjbrownie/swapit'
"Plug 'benmills/vimux'
""""""" unite
Plug 'Shougo/unite.vim'
Plug 'Shougo/unite-outline'
Plug 'Shougo/neomru.vim'
Plug 'Shougo/vimproc.vim'
""""""" colors
Plug 'tomasr/molokai'
Plug 'junegunn/seoul256.vim'
Plug 'morhetz/gruvbox'
"Plug 'chriskempson/base16-vim' " not prepared for shell
Plug 'freeo/vim-kalisi'
"Plug 'nanotech/jellybeans.vim'
"Plug 'cinghiopinghio/xinghio-color.vim'
"Plug 'zeis/vim-kolor'
"Plug 'sjl/badwolf' " too dark 
"Plug 'altercation/vim-colors-solarized'
""""""" statusbar
"Plug 'maciakl/vim-neatstatus'
Plug 'bling/vim-airline'
"Plug 'bling/vim-bufferline'
"Plug 'itchyny/lightline.vim'
"Plug 'edkolev/promptline.vim'
""""""" vertical alignement
"Plug 'vim-scripts/Align'
Plug 'junegunn/vim-easy-align'
"Plug 'Raimondi/delimitMate'
Plug 'thinca/vim-quickrun'

"Plug 'cinghiopinghio/abook-vim'
Plug 'caio/querycommandcomplete.vim'
Plug 'guyzmo/notmuch-abook'
""""""" calendar for vim
"Plug 'mattn/calendar-vim'
""""""" filetype plugins
""""""" CSV
Plug 'chrisbra/csv.vim', { 'for': 'csv' }
""""""" HTML
Plug 'mattn/emmet-vim', { 'for': ['html', 'sass', 'scss', 'css']} 
Plug 'othree/html5.vim', { 'for': ['html', 'sass', 'scss', 'css']}
""""""" LaTeX
Plug 'lervag/vimtex', { 'for': 'tex' }
"Plug 'LaTeX-Box-Team/LaTeX-Box', { 'for': 'tex' }
""""""" Note/Todo writing
"Plug 'xolox/vim-notes'
"Plug 'fmoralesc/vim-pad'
"Plug 'blinry/vimboy'
"Plug ''

"Plug 'terryma/vim-multiple-cursors'
"Plug 'felipec/notmuch-vim'

" Using git URL
"Plug 'https://github.com/junegunn/vim-github-dashboard.git'
" Plugin options
"Plug 'nsf/gocode', { 'tag': 'go.weekly.2012-03-13', 'rtp': 'vim' }
" Plugin outside ~/.vim/plugged with post-update hook
"Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'yes \| ./install' }
" Unmanaged plugin (manually installed and updated)
"Plug '~/my-prototype-plugin'
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
set nobackup            " fasten writing process (:w)
" tabulation
setlocal shiftwidth=2 softtabstop=2 expandtab smarttab

set complete+=k         " enable dictionary completion
set completeopt+=longest

set clipboard+=unnamed  " yank and copy to X clipboard
"wrapping
set wrap
set linebreak

set textwidth=78
if exists('+colorcolumn')
  set colorcolumn=80
else
  au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
endif


set background=dark
if (s:host == 'mercurio')
  let g:airline_theme='gruvbox'
  let g:seoul256_background = 235
  let g:seoul256_light_background = 256
  colorscheme seoul256
elseif s:host == 'arcinghio'
  let g:airline_theme='gruvbox'
  let g:gruvbox_contrast_dark='medium'
  colorscheme gruvbox
else
  let g:airline_theme='badwolf'
  colorscheme molokai
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
vmap ,y "*y
nmap ,p "*p

" reload vimrc
nmap <leader><leader><leader> :so $MYVIMRC<cr>
"}}}"

"-------------------------------------------------------------------------
" COMMANDS
"{{{ local defined commands
" svn commands
command! -b -nargs=0 SvnUp :!svn up
command! -b -nargs=+ SvnCi :!svn ci -m <q-args>
"}}}"

"-------------------------------------------------------------------------
" PLUGINS SETTINGS
"{{{
"----------------------------------
"{{{ Use emmet only in html,css
let g:user_emmet_install_global = 0
autocmd FileType html,css,scss,sass EmmetInstall
"}}}

"----------------------------------
"{{{ Syntastic
let g:syntastic_mode_map = { 'passive_filetypes': ['sass'] }
"}}}

"----------------------------------
"{{{ Unite
nmap <localleader>uf :Unite -no-split file buffer<cr>
nmap <localleader>ub :Unite -no-split buffer<cr>
nmap <localleader>ur :Unite -no-split file_mru<cr>
nmap <localleader>uo :Unite -vertical outline<cr>
let g:unite_enable_start_insert = 1
"}}}"

"----------------------------------
"{{{ NERDTree
" this let start NERDTree if no file name is given
"autocmd vimenter * if !argc() | NERDTree | endif
noremap <localleader>n :NERDTreeToggle<CR>

" use netrw instead:
" https://medium.com/@mozhuuuuu/vimmers-you-dont-need-nerdtree-18f627b561c3
let g:netrw_liststyle=3
noremap <localleader>e :e.<CR>

"}}}

"----------------------------------
"{{{ LatexBox
" this is here because otherwise it won't be read by the plugin
let g:LatexBox_Folding=1
let g:LatexBox_ignore_warnings =['Underfull', 'Overfull',
                          \'specifier changed to', 'A float is stuck',
                          \'Label(s) may have changed']
"}}}

"----------------------------------
"{{{ SuperTab
" use OmniComplete function
let g:SuperTabDefaultCompletionType = "context"
"let g:SuperTabDefaultCompletionType = "<C-x><C-o>"
let g:SuperTabContextDefaultCompletionType = "<C-x><C-o>"
"}}}"

"----------------------------------
"{{{ UltiSnips
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsListSnippets="<c-l>"
"}}}

"----------------------------------
"{{{ AirLine
" see the theme file for the color definition
let g:airline_right_sep=''
let g:airline_left_sep=''
let g:airline#extensions#default#layout = [
                  \ [ 'a', 'b', 'c'],
                  \ [ 'x', 'y', 'z', 'warning']]
let g:airline#extensions#whitespace#enabled = 0
"}}}

"----------------------------------
"{{{ Signify
let g:signify_vcs_list              = [ 'git', 'svn', 'hg' ]
let g:signify_cursorhold_insert     = 1
let g:signify_cursorhold_normal     = 1
let g:signify_update_on_bufenter    = 0
let g:signify_update_on_focusgained = 1
let g:signify_disable_by_default    = 1

nnoremap <localleader>gt :SignifyToggle<cr>
nnoremap <localleader>gh :SignifyToggleHighlight<cr>
nnoremap <localleader>gr :SignifyRefresh<cr>
nnoremap <localleader>gd :SignifyDebug<cr>

" hunk jumping
nmap <leader>gj <plug>(signify-next-hunk)
nmap <leader>gk <plug>(signify-prev-hunk)

" hunk text object
"omap ic <plug>(signify-motion-inner-pending)
"xmap ic <plug>(signify-motion-inner-visual)
"omap ac <plug>(signify-motion-outer-pending)
"xmap ac <plug>(signify-motion-outer-visual)

"<cr>}}}

"----------------------------------
"{{{ Thumbnail
nnoremap <localleader>t :Thumbnail -include=help<cr>
"}}}
"}}}

"{{{ Func+Command: Run a command and paste output in a buffer
function! RunCom(command)
    let winnr = bufwinnr('^_output$')
    if ( winnr >= 0 )
        execute winnr . 'wincmd w'
        execute 'normal ggdG'
    else
        "TODO: check if GoldenView is available
        if exists("*GoldenView#Split")
          call GoldenView#Split()
          edit _output
        else
          vnew _output
        endif
        setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap
    endif
    let s:com='VimProcRead ' . a:command
    exec s:com
    "silent! VimProcRead . a:command 
    "back to previous buffer
    wincmd p
endfunction
command! -b -nargs=+ Runit :call RunCom(<q-args>)
"}}}
