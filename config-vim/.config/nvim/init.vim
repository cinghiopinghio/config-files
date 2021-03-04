" vimrc file.

"----------------------------------------------------------------------
" PREABLE
"{{{ PREAMBLE
let maplocalleader=' '
if !has('nvim')
    set nocompatible          " be iMproved
endif
filetype indent plugin on
syntax on
"}}}
"

"----------------------------------------------------------------------
" Plugin Manager
source ${HOME}/.config/nvim/config/plugins.vim

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

"-------------------------------------------------------------------------
" SET OPTIONS
source ${HOME}/.config/nvim/config/settings.vim

"-------------------------------------------------------------------------
" MAP
source ${HOME}/.config/nvim/config/maps.vim

if has ("nvim")
    set termguicolors
    if has ("nvim-0.5")
        lua require('init')
    else
        " Use smartcase.
        call deoplete#custom#option('smart_case', v:true)
    endif
endif
