" vimrc file.

set nocompatible               " be iMproved
filetype off                   " required!
""""""""""""""""""""
" call Vundle
""""""""""""""""""""
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
Bundle 'tpope/vim-fugitive'
Bundle 'vim-scripts/VOoM'
Bundle 'mbbill/VimExplorer'
Bundle 'majutsushi/tagbar'
Bundle 'scrooloose/syntastic'
Bundle 'scrooloose/nerdtree'
Bundle 'vim-scripts/Conque-Shell'
Bundle 'vim-pandoc/vim-pandoc'
"Bundle 'honza/snipmate-snippets'
"Bundle 'tomtom/tlib_vim'
"Bundle 'MarcWeber/vim-addon-mw-utils'
"Bundle 'garbas/vim-snipmate'
Bundle 'SirVer/ultisnips'
Bundle 'LaTeX-Box-Team/LaTeX-Box'
Bundle 'spolu/dwm.vim'
Bundle 'Shougo/neocomplcache'
Bundle 'tpope/vim-surround'
Bundle 'istib/vifm.vim'

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
"
" Brief help
" :BundleList          - list configured bundles
" :BundleInstall(!)    - install(update) bundles
" :BundleSearch(!) foo - search(or refresh cache first) for foo
" :BundleClean(!)      - confirm(or auto-approve) removal of unused bundles
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Bundle command are not allowed..




" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching
set ignorecase

nmap    <ESC>[5^    <C-PageUp>
nmap    <ESC>[6^    <C-PageDown>
"nnoremap <C-PageDown> :bn!<CR>
"noremap <C-PageUp> :bp!<CR>

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

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

endif " has("autocmd")

map <F6> :setlocal spell! spelllang=en_us<CR>

" tabulation
setlocal shiftwidth=2 softtabstop=2 expandtab smarttab

"" Save folds automatically on close, and load them on opening the file
"au BufWinLeave *.* mkview
"au BufWinEnter *.* silent loadview


set complete+=k         " enable dictionary completion
set completeopt+=longest
set clipboard+=unnamed  " yank and copy to X clipboard

set ignorecase          " case-insensitive search
set smartcase           " upper-case sensitive search

"wrapping
set wrap
set linebreak
set textwidth=80

set background=dark
colorscheme xinghio

set makeprg=make
set grepprg=grep\ -nH\ $*

" paste from clipboard without indentation with F2
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
set showmode


au FilterWritePre * if &diff | set wrap | endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Navigation
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" open file under cursor on a tab
map gf :tabe<cfile><CR>
"toggle buffers
nnoremap <F5> :buffers<CR>:buffer<Space> 
" resize current buffer by +/- 5 
nnoremap <C-left> :vertical resize -5<cr>
nnoremap <C-down> :resize +5<cr>
nnoremap <C-up> :resize -5<cr>
nnoremap <C-right> :vertical resize +5<cr>

" move through wrapped lines
imap <silent> <Down> <C-o>gj
imap <silent> <Up> <C-o>gk
nmap <silent> <Down> gj
nmap <silent> <Up> gk
" prova

" reload vimrc
nmap <leader><leader><leader> :source ~/.vimrc<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VOOM
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:voom_tab_key='<C-Tab>'
let g:voom_return_key = '<C-Return>'


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => NERDTree
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" this let start NERDTree if no file name is given
"autocmd vimenter * if !argc() | NERDTree | endif
noremap <leader>n :NERDTreeToggle<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => TagBar
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

nnoremap <leader>t :TagbarToggle<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => MOUSE
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" use the mouse in vim:
set mouse=vi

""""""""""""""""""""""""""""""
" this is here because otherwise it won't be read by the plugin
let g:LatexBox_Folding=1
""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => DWM
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:dwm_map_keys=1
let g:dwm_master_pane_width="66%"


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""Neocomplcache
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"" Disable AutoComplPop. Comment out this line if AutoComplPop is not installed.
""let g:acp_enableAtStartup = 0
"" Launches neocomplcache automatically on vim startup.
"let g:neocomplcache_enable_at_startup = 1
"" Use smartcase.
"let g:neocomplcache_enable_smart_case = 1
"" Use camel case completion.
"let g:neocomplcache_enable_camel_case_completion = 1
"" Use underscore completion.
"let g:neocomplcache_enable_underbar_completion = 1
"" Sets minimum char length of syntax keyword.
"let g:neocomplcache_min_syntax_length = 3
"" buffer file name pattern that locks neocomplcache. e.g. ku.vim or fuzzyfinder 
"let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'
"
"" Define file-type dependent dictionaries.
"let g:neocomplcache_dictionary_filetype_lists = {
"    \ 'default' : '',
"    \ 'vimshell' : $HOME.'/.vimshell_hist',
"    \ 'scheme' : $HOME.'/.gosh_completions'
"    \ }
"
"" Define keyword, for minor languages
"if !exists('g:neocomplcache_keyword_patterns')
"  let g:neocomplcache_keyword_patterns = {}
"endif
"let g:neocomplcache_keyword_patterns['default'] = '\h\w*'
"
"" Plugin key-mappings.
"imap <C-k>     <Plug>(neocomplcache_snippets_expand)
"smap <C-k>     <Plug>(neocomplcache_snippets_expand)
"inoremap <expr><C-g>     neocomplcache#undo_completion()
"inoremap <expr><C-l>     neocomplcache#complete_common_string()
"
"" SuperTab like snippets behavior.
""imap <expr><TAB> neocomplcache#sources#snippets_complete#expandable() ? "\<Plug>(neocomplcache_snippets_expand)" : pumvisible() ? "\<C-n>" : "\<TAB>"
"
"" Recommended key-mappings.
"" <CR>: close popup and save indent.
"inoremap <expr><CR>  neocomplcache#smart_close_popup() . "\<CR>"
"" <TAB>: completion.
"inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
"" <C-h>, <BS>: close popup and delete backword char.
"inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
"inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
"inoremap <expr><C-y>  neocomplcache#close_popup()
"inoremap <expr><C-e>  neocomplcache#cancel_popup()
"
"" AutoComplPop like behavior.
""let g:neocomplcache_enable_auto_select = 1
"
"" Shell like behavior(not recommended).
""set completeopt+=longest
""let g:neocomplcache_enable_auto_select = 1
""let g:neocomplcache_disable_auto_complete = 1
""inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<TAB>"
""inoremap <expr><CR>  neocomplcache#smart_close_popup() . "\<CR>"
"
"" Enable omni completion. Not required if they are already set elsewhere in .vimrc
"autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
"autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
"autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
"autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
"autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
""autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
"
"" Enable heavy omni completion, which require computational power and may stall the vim. 
"if !exists('g:neocomplcache_omni_patterns')
"  let g:neocomplcache_omni_patterns = {}
"endif
"let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
"let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplcache_omni_patterns.c = '\%(\.\|->\)\h\w*'
"let g:neocomplcache_omni_patterns.cpp = '\h\w*\%(\.\|->\)\h\w*\|\h\w*::'
