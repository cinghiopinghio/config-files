" vimrc file.

"----------------------------------------------------------------------
" PREABLE
"{{{ PREAMBLE
let maplocalleader=' '
set nocompatible               " be iMproved
"}}}

"----------------------------------------------------------------------
" VUNDLE
"{{{ Vundle: plugin manager
filetype off                   " required!
let iCanHazVundle=1
let vundle_readme=expand('~/.vim/bundle/vundle/README.md')
if !filereadable(vundle_readme)
    echo "Installing Vundle.."
    echo ""
    silent !mkdir -p ~/.vim/bundle
    silent !git clone https://github.com/gmarik/vundle ~/.vim/bundle/vundle
    let iCanHazVundle=0
endif
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required!
Bundle 'gmarik/vundle'

" My Bundles here:
"
" original repos on github
"""""""" git
"Bundle 'tpope/vim-fugitive'
Bundle 'mhinz/vim-signify'
"""""""" outliner
"Bundle 'vim-scripts/VOoM'
"Bundle 'majutsushi/tagbar'
"""""""" syntax checker
Bundle 'scrooloose/syntastic'
"""""""" folder navigation
Bundle 'scrooloose/nerdtree'
"Bundle 'istib/vifm.vim'
""""""" AutoCompletion
"Bundle 'jiangmiao/auto-pairs'
Bundle 'Raimondi/delimitMate'
Bundle 'ajh17/VimCompletesMe'
"Bundle 'ervandew/supertab'
"Bundle 'Valloric/YouCompleteMe'
"Bundle 'Shougo/neocomplete.vim'
"Bundle 'Shougo/neocomplcache'
""""""" snippets
"Bundle 'honza/snipmate-snippets'
"Bundle 'garbas/vim-snipmate'
"Bundle 'MarcWeber/ultisnips'
if has("python")
  Bundle 'SirVer/ultisnips'
  Bundle 'honza/vim-snippets'
endif
""""""" window splits control
Bundle 'zhaocai/GoldenView.Vim'
Bundle 'itchyny/thumbnail.vim'
""""""" parenthesis change
Bundle 'tpope/vim-surround'
"Bundle 'benmills/vimux'
""""""" unite
Bundle 'Shougo/unite.vim'
Bundle 'Shougo/unite-outline'
Bundle 'Shougo/vimproc.vim'
""""""" colors
"Bundle 'tomasr/molokai'
"Bundle 'cinghiopinghio/xinghio-color.vim'
Bundle 'morhetz/gruvbox'
""""""" statusbar
"Bundle 'maciakl/vim-neatstatus'
Bundle 'bling/vim-airline'
"Bundle 'bling/vim-bufferline'
"Bundle 'itchyny/lightline.vim'
"Bundle 'edkolev/promptline.vim'
""""""" vertical alignement
"Bundle 'vim-scripts/Align'
Bundle 'junegunn/vim-easy-align'
"Bundle 'Raimondi/delimitMate'

Bundle 'cinghiopinghio/abook-vim'
Bundle 'caio/querycommandcomplete.vim'
""""""" calendar for vim
"Bundle 'mattn/calendar-vim'
""""""" filetype plugins
""""""" CSV
Bundle 'chrisbra/csv.vim'
""""""" HTML
Bundle 'mattn/emmet-vim'
Bundle 'othree/html5.vim'
""""""" LaTeX
Bundle 'LaTeX-Box-Team/LaTeX-Box'
""""""" Note/Todo writing
"Bundle 'xolox/vim-notes'
"Bundle 'fmoralesc/vim-pad'
"Bundle 'blinry/vimboy'
"Bundle ''

"Bundle 'terryma/vim-multiple-cursors'
"Bundle 'felipec/notmuch-vim'


" vim-scripts repos
"Bundle 'L9'
"Bundle 'FuzzyFinder'
" non github repos
"Bundle 'git://git.wincent.com/command-t.git'
" ...

if iCanHazVundle == 0
  echo "Installing Bundles, please ignore key map error messages"
  echo ""
  :BundleInstall
endif

""""""""""""""""""""
"""end"vundle"stuff"
""""""""""""""""""""
filetype plugin indent on     " required!
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
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif
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
set textwidth=75
set background=dark
if exists('+colorcolumn')
  set colorcolumn=80
else
  au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
endif
let g:gruvbox_contrast_dark='medium'
"colorscheme molokai
colorscheme gruvbox
"colorscheme xinghio
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
"{{{ VOoM
nnoremap <localleader>y :VoomToggle<CR>
let g:voom_tab_key='<C-Tab>'
let g:voom_return_key = '<C-Return>'
let g:voom_ft_modes = {'markdown': 'markdown', 'pandoc': 'markdown', 'python': 'python', 'tex': 'latex'}
"}}}

"----------------------------------
"{{{ NERDTree
" this let start NERDTree if no file name is given
"autocmd vimenter * if !argc() | NERDTree | endif
noremap <localleader>n :NERDTreeToggle<CR>
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




function! RunCom(command)
    let winnr = bufwinnr('^_output$')
    if ( winnr >= 0 )
        execute winnr . 'wincmd w'
        execute 'normal ggdG'
    else
        vnew _output
        setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap
    endif
    silent! r! . a:command
endfunction
