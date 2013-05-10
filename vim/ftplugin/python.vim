
setlocal foldmethod=indent autoindent smartindent
setlocal foldnestmax=2

map <leader>ll :!python %<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VOom
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"nnoremap <leader>y :VoomToggle python<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Syntax Highlights
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"    For highlight builtin functions and objects:
"       python_highlight_builtins
"    For highlight builtin objects:
let python_highlight_builtin_objs=1
"    For highlight builtin funtions:
let python_highlight_builtin_funcs=1
"    For highlight standard exceptions:
"       python_highlight_exceptions
"    For highlight string formatting:
"       python_highlight_string_formatting
"    For highlight str.format syntax:
"       python_highlight_string_format
"    For highlight string.Template syntax:
"       python_highlight_string_templates
"    For highlight indentation errors:
"       python_highlight_indent_errors
"    For highlight trailing spaces:
"       python_highlight_space_errors
"    For highlight doc-tests:
"       python_highlight_doctests
