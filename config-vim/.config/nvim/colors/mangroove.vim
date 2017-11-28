" Name:       paramount.vim
" Version:    0.1.0
" Maintainer: github.com/owickstrom
" License:    The MIT License (MIT)
"
" A minimal colorscheme for Vim that only puts emphasis on the paramount.
"
" Based on the pencil and off colorschemes:
"
" https://github.com/reedes/vim-colors-pencil
" https://github.com/reedes/vim-colors-off
"
"""
hi clear

if exists('syntax on')
    syntax reset
endif

let g:colors_name='mangroove'

"{{{ setup palette dictionary
let s:gb = {}

let s:gb.none = ['NONE', 'NONE']

" fill it with absolute colors
let s:gb.dark0_hard     = ['#1d2021', 234] " 29-32-33
let s:gb.dark0          = ['#282828', 235] " 40-40-40
let s:gb.dark0_soft     = ['#32302f', 236] " 50-48-47
let s:gb.dark1          = ['#3c3836', 237] " 60-56-54
let s:gb.dark2          = ['#504945', 239] " 80-73-69
let s:gb.dark3          = ['#665c54', 241] " 102-92-84
let s:gb.dark4          = ['#7c6f64', 243] " 124-111-100
let s:gb.dark4_256      = ['#7c6f64', 243] " 124-111-100

let s:gb.gray_245       = ['#928374', 245] " 146-131-116
let s:gb.gray_244       = ['#928374', 244] " 146-131-116

let s:gb.light0_hard    = ['#f9f5d7', 230] " 249-245-215
let s:gb.light0         = ['#fbf1c7', 229] " 253-244-193
let s:gb.light0_soft    = ['#f2e5bc', 228] " 242-229-188
let s:gb.light1         = ['#ebdbb2', 223] " 235-219-178
let s:gb.light2         = ['#d5c4a1', 250] " 213-196-161
let s:gb.light3         = ['#bdae93', 248] " 189-174-147
let s:gb.light4         = ['#a89984', 246] " 168-153-132
let s:gb.light4_256     = ['#a89984', 246] " 168-153-132

let s:gb.bright_red     = ['#fb4934', 167] " 251-73-52
let s:gb.bright_green   = ['#b8bb26', 142] " 184-187-38
let s:gb.bright_yellow  = ['#fabd2f', 214] " 250-189-47
let s:gb.bright_blue    = ['#83a598', 109] " 131-165-152
let s:gb.bright_purple  = ['#d3869b', 175] " 211-134-155
let s:gb.bright_aqua    = ['#8ec07c', 108] " 142-192-124
let s:gb.bright_orange  = ['#fe8019', 208] " 254-128-25

let s:gb.neutral_red    = ['#cc241d', 124] " 204-36-29
let s:gb.neutral_green  = ['#98971a', 106] " 152-151-26
let s:gb.neutral_yellow = ['#d79921', 172] " 215-153-33
let s:gb.neutral_blue   = ['#458588', 66]  " 69-133-136
let s:gb.neutral_purple = ['#b16286', 132] " 177-98-134
let s:gb.neutral_aqua   = ['#689d6a', 72]  " 104-157-106
let s:gb.neutral_orange = ['#d65d0e', 166] " 214-93-14

let s:gb.faded_red      = ['#9d0006', 88]  " 157-0-6
let s:gb.faded_green    = ['#79740e', 100] " 121-116-14
let s:gb.faded_yellow   = ['#b57614', 136] " 181-118-20
let s:gb.faded_blue     = ['#076678', 24]  " 7-102-120
let s:gb.faded_purple   = ['#8f3f71', 96]  " 143-63-113
let s:gb.faded_aqua     = ['#427b58', 66]  " 66-123-88
let s:gb.faded_orange   = ['#af3a03', 130] " 175-58-3
"}}}

let s:gru = {}
let s:gru.dark0_hard     = {'gui': '#1d2021', 'cterm': '234'}     " 29-32-33
let s:gru.dark0          = {'gui': '#282828', 'cterm': '235'}     " 40-40-40
let s:gru.dark0_soft     = {'gui': '#32302f', 'cterm': '236'}     " 50-48-47
let s:gru.dark1          = {'gui': '#3c3836', 'cterm': '237'}     " 60-56-54
let s:gru.dark2          = {'gui': '#504945', 'cterm': '239'}     " 80-73-69
let s:gru.dark3          = {'gui': '#665c54', 'cterm': '241'}     " 102-92-84
let s:gru.dark4          = {'gui': '#7c6f64', 'cterm': '243'}     " 124-111-100
let s:gru.dark4_256      = {'gui': '#7c6f64', 'cterm': '243'}     " 124-111-100

let s:gru.gray_245       = {'gui': '#928374', 'cterm': '245'}     " 146-131-116
let s:gru.gray_244       = {'gui': '#928374', 'cterm': '244'}     " 146-131-116

let s:gru.light0_hard    = {'gui': '#f9f5d7', 'cterm': '230'}     " 249-245-215
let s:gru.light0         = {'gui': '#fbf1c7', 'cterm': '229'}     " 253-244-193
let s:gru.light0_soft    = {'gui': '#f2e5bc', 'cterm': '228'}     " 242-229-188
let s:gru.light1         = {'gui': '#ebdbb2', 'cterm': '223'}     " 235-219-178
let s:gru.light2         = {'gui': '#d5c4a1', 'cterm': '250'}     " 213-196-161
let s:gru.light3         = {'gui': '#bdae93', 'cterm': '248'}     " 189-174-147
let s:gru.light4         = {'gui': '#a89984', 'cterm': '246'}     " 168-153-132
let s:gru.light4_256     = {'gui': '#a89984', 'cterm': '246'}     " 168-153-132

let s:gru.bright_red     = {'gui': '#fb4934', 'cterm': '167'}     " 251-73-52
let s:gru.bright_green   = {'gui': '#b8bb26', 'cterm': '142'}     " 184-187-38
let s:gru.bright_yellow  = {'gui': '#fabd2f', 'cterm': '214'}     " 250-189-47
let s:gru.bright_blue    = {'gui': '#83a598', 'cterm': '109'}     " 131-165-152
let s:gru.bright_purple  = {'gui': '#d3869b', 'cterm': '175'}     " 211-134-155
let s:gru.bright_aqua    = {'gui': '#8ec07c', 'cterm': '108'}     " 142-192-124
let s:gru.bright_orange  = {'gui': '#fe8019', 'cterm': '208'}     " 254-128-25

let s:gru.neutral_red    = {'gui': '#cc241d', 'cterm': '124'}     " 204-36-29
let s:gru.neutral_green  = {'gui': '#98971a', 'cterm': '106'}     " 152-151-26
let s:gru.neutral_yellow = {'gui': '#d79921', 'cterm': '172'}     " 215-153-33
let s:gru.neutral_blue   = {'gui': '#458588', 'cterm': '66'}      " 69-133-136
let s:gru.neutral_purple = {'gui': '#b16286', 'cterm': '132'}     " 177-98-134
let s:gru.neutral_aqua   = {'gui': '#689d6a', 'cterm': '72'}      " 104-157-106
let s:gru.neutral_orange = {'gui': '#d65d0e', 'cterm': '166'}     " 214-93-14

let s:gru.faded_red      = {'gui': '#9d0006', 'cterm': '88'}      " 157-0-6
let s:gru.faded_green    = {'gui': '#79740e', 'cterm': '100'}     " 121-116-14
let s:gru.faded_yellow   = {'gui': '#b57614', 'cterm': '136'}     " 181-118-20
let s:gru.faded_blue     = {'gui': '#076678', 'cterm': '24'}      " 7-102-120
let s:gru.faded_purple   = {'gui': '#8f3f71', 'cterm': '96'}      " 143-63-113
let s:gru.faded_aqua     = {'gui': '#427b58', 'cterm': '66'}      " 66-123-88
let s:gru.faded_orange   = {'gui': '#af3a03', 'cterm': '130'}     " 175-58-3

let s:background = &background

if &background == "dark"
  let s:bg              = s:gru.dark0
  let s:bg_subtle       = s:gru.gray_245
  let s:bg_very_subtle  = s:gru.dark1
  let s:norm            = s:gru.light0
  let s:norm_subtle     = s:gru.light4
  let s:purple          = s:gru.bright_purple
  let s:cyan            = s:gru.bright_aqua
  let s:green           = s:gru.bright_green
  let s:red             = s:gru.bright_red
  let s:visual          = s:gru.bright_purple
  let s:yellow          = s:gru.bright_yellow
  let s:blue            = s:gru.bright_blue
else
  let s:bg              = s:gru.light0
  let s:bg_subtle       = s:gru.gray_244
  let s:bg_very_subtle  = s:gru.light1
  let s:norm            = s:gru.dark0
  let s:norm_subtle     = s:gru.dark4
  let s:purple          = s:gru.faded_purple
  let s:cyan            = s:gru.faded_aqua
  let s:green           = s:gru.faded_green
  let s:red             = s:gru.faded_red
  let s:visual          = s:gru.faded_purple
  let s:yellow          = s:gru.faded_yellow
  let s:blue            = s:gru.faded_blue
endif

" Highlighting Function: {{{

function! s:hl(group, fg, ...)
  " Arguments: group, fg, bg, gui, guisp

  " foreground
  let fg = a:fg

  " background
  if a:0 >= 1
    let bg = a:1
  else
    let bg = s:none
  endif

  " emphasis
  if a:0 >= 2 && strlen(a:2)
    let emstr = a:2
  else
    let emstr = 'NONE,'
  endif

  " special fallback
  if a:0 >= 3
    if g:gruvbox_guisp_fallback != 'NONE'
      let fg = a:3
    endif

    " bg fallback mode should invert higlighting
    if g:gruvbox_guisp_fallback == 'bg'
      let emstr .= 'inverse,'
    endif
  endif

  let histring = [ 'hi', a:group,
        \ 'guifg=' . fg[0], 'ctermfg=' . fg[1],
        \ 'guibg=' . bg[0], 'ctermbg=' . bg[1],
        \ 'gui=' . emstr[:-2], 'cterm=' . emstr[:-2]
        \ ]

  " special
  if a:0 >= 3
    call add(histring, 'guisp=' . a:3[0])
  endif

  execute join(histring, ' ')
endfunction

" }}}

" https://github.com/noahfrederick/vim-hemisu/
function! s:h(group, style)
  execute "highlight" a:group
    \ "guifg="   (has_key(a:style, "fg")    ? a:style.fg.gui   : "NONE")
    \ "guibg="   (has_key(a:style, "bg")    ? a:style.bg.gui   : "NONE")
    \ "guisp="   (has_key(a:style, "sp")    ? a:style.sp.gui   : "NONE")
    \ "gui="     (has_key(a:style, "gui")   ? a:style.gui      : "NONE")
    \ "ctermfg=" (has_key(a:style, "fg")    ? a:style.fg.cterm : "NONE")
    \ "ctermbg=" (has_key(a:style, "bg")    ? a:style.bg.cterm : "NONE")
    \ "cterm="   (has_key(a:style, "cterm") ? a:style.cterm    : "NONE")
endfunction

call s:h("Normal",        {"fg": s:norm})
hi! link Identifier       Normal
hi! link Function         Identifier

" restore &background's value in case changing Normal changed &background (:help :hi-normal-cterm)
if &background != s:background
   execute "set background=" . s:background
endif

call s:h("Cursor",        {"bg": s:purple, "fg": s:norm })

call s:h("Comment",       {"fg": s:bg_subtle, "gui": "italic"})

call s:h("Constant",      {"fg": s:green})
hi! link Character        Constant
hi! link Number           Constant
hi! link Boolean          Constant
hi! link Float            Constant
hi! link String           Constant

call s:h("Operator",      {"fg": s:norm, "cterm": "bold", "gui": "bold"})

call s:h("Statement",     {"fg": s:norm_subtle})
hi! link Conditonal       Statement
hi! link Repeat           Statement
hi! link Label            Statement
hi! link Keyword          Statement
hi! link Exception        Statement

call s:h("PreProc",     {"fg": s:norm_subtle})
hi! link Include          PreProc
hi! link Define           PreProc
hi! link Macro            PreProc
hi! link PreCondit        PreProc

call s:h("Type",          {"fg": s:norm})
hi! link StorageClass     Type
hi! link Structure        Type
hi! link Typedef          Type

call s:h("Special",       {"fg": s:gru.neutral_green, "gui": "italic"})
hi! link SpecialChar      Special
hi! link Tag              Special
hi! link Delimiter        Special
hi! link SpecialComment   Special
hi! link Debug            Special

hi! link User3         ErrorMsg
hi! link User4         Special
hi! link User5         Comment
hi! link User6         WarningMsg
call s:hl('User1', s:gb.light0,        s:gb.dark1)
call s:hl('User2', s:gb.light2,        s:gb.dark1)
call s:hl('User3', s:gb.bright_red,    s:gb.dark1)
call s:hl('User4', s:gb.neutral_green, s:gb.dark1)
call s:hl('User5', s:gb.light4,        s:gb.dark1, 'italic,')
call s:hl('User6', s:gb.bright_yellow, s:gb.dark1)

call s:h("Underlined",    {"fg": s:norm, "gui": "underline", "cterm": "underline"})
call s:h("Ignore",        {"fg": s:bg})
call s:h("Error",         {"fg": s:bg, "bg": s:red, "cterm": "bold"})
call s:h("Todo",          {"fg": s:purple, "gui": "underline", "cterm": "underline"})
call s:h("SpecialKey",    {"fg": s:green})
call s:h("NonText",       {"fg": s:bg_subtle})
call s:h("Directory",     {"fg": s:blue})
call s:h("ErrorMsg",      {"fg": s:red})
call s:h("IncSearch",     {"bg": s:yellow, "fg": s:bg})
call s:h("Search",        {"bg": s:green, "fg": s:bg})
call s:h("MoreMsg",       {"fg": s:bg_subtle, "cterm": "bold", "gui": "bold"})
hi! link ModeMsg MoreMsg
call s:h("LineNr",        {"fg": s:bg_subtle})
call s:h("CursorLineNr",  {"fg": s:purple, "bg": s:bg_very_subtle})
call s:h("Question",      {"fg": s:red})
call s:h("StatusLine",    {"bg": s:bg_very_subtle})
call s:h("StatusLineNC",  {"bg": s:bg_very_subtle, "fg": s:bg_subtle})
call s:h("VertSplit",     {"bg": s:bg_very_subtle, "fg": s:bg_very_subtle})
call s:h("Title",         {"fg": s:blue})
call s:h("Visual",        {"fg": s:norm, "bg": s:visual})
call s:h("VisualNOS",     {"bg": s:bg_subtle})
call s:h("WarningMsg",    {"fg": s:red})
call s:h("WildMenu",      {"fg": s:bg, "bg": s:norm})
call s:h("Folded",        {"fg": s:bg_subtle, 'bg': s:bg})
call s:h("FoldColumn",    {"fg": s:bg_subtle})
call s:h("DiffAdd",       {"fg": s:bg, "bg": s:green})
call s:h("DiffDelete",    {"fg": s:bg, "bg": s:red})
call s:h("DiffChange",    {"fg": s:bg, "bg": s:yellow})
call s:h("DiffText",      {"fg": s:bg, "bg": s:blue})
call s:h("SignColumn",    {"fg": s:green})


if has("gui_running")
  call s:h("SpellBad",    {"gui": "underline", "sp": s:red})
  call s:h("SpellCap",    {"gui": "underline", "sp": s:green})
  call s:h("SpellRare",   {"gui": "underline", "sp": s:red})
  call s:h("SpellLocal",  {"gui": "underline", "sp": s:green})
else
  call s:h("SpellBad",    {"cterm": "underline", "fg": s:red})
  call s:h("SpellCap",    {"cterm": "underline", "fg": s:green})
  call s:h("SpellRare",   {"cterm": "underline", "fg": s:red})
  call s:h("SpellLocal",  {"cterm": "underline", "fg": s:green})
endif

call s:h("Pmenu",         {"fg": s:norm, "bg": s:bg_subtle})
call s:h("PmenuSel",      {"fg": s:norm, "bg": s:purple})
call s:h("PmenuSbar",     {"fg": s:norm, "bg": s:bg_subtle})
call s:h("PmenuThumb",    {"fg": s:norm, "bg": s:bg_subtle})
call s:h("TabLine",       {"fg": s:norm, "bg": s:bg_very_subtle})
call s:h("TabLineSel",    {"fg": s:purple, "bg": s:bg_subtle, "gui": "bold", "cterm": "bold"})
call s:h("TabLineFill",   {"fg": s:norm, "bg": s:bg_very_subtle})
call s:h("CursorColumn",  {"bg": s:bg_very_subtle})
call s:h("CursorLine",    {"bg": s:bg_very_subtle})
call s:h("ColorColumn",   {"bg": s:bg_very_subtle})

call s:h("MatchParen",    {"bg": s:bg_subtle, "fg": s:norm})
call s:h("qfLineNr",      {"fg": s:bg_subtle})

call s:h("htmlH1",        {"bg": s:bg, "fg": s:norm})
call s:h("htmlH2",        {"bg": s:bg, "fg": s:norm})
call s:h("htmlH3",        {"bg": s:bg, "fg": s:norm})
call s:h("htmlH4",        {"bg": s:bg, "fg": s:norm})
call s:h("htmlH5",        {"bg": s:bg, "fg": s:norm})
call s:h("htmlH6",        {"bg": s:bg, "fg": s:norm})

" Synatastic
call s:h("SyntasticWarningSign",    {"fg": s:yellow})
call s:h("SyntasticWarning",        {"bg": s:yellow, "fg": s:bg, "gui": "bold", "cterm": "bold"})
call s:h("SyntasticErrorSign",      {"fg": s:red})
call s:h("SyntasticError",          {"bg": s:red, "fg": s:norm, "gui": "bold", "cterm": "bold"})

" Neomake
hi link NeomakeWarningSign	SyntasticWarningSign
hi link NeomakeErrorSign	SyntasticErrorSign

" ALE
hi link ALEWarningSign	SyntasticWarningSign
hi link ALEErrorSign	SyntasticErrorSign

" Signify, git-gutter
hi link SignifySignAdd              LineNr
hi link SignifySignDelete           LineNr
hi link SignifySignChange           LineNr
hi link GitGutterAdd                LineNr
hi link GitGutterDelete             LineNr
hi link GitGutterChange             LineNr
hi link GitGutterChangeDelete       LineNr

" Python
call s:h("Python",          {"fg": s:norm_subtle, "gui": "italic", "cterm": "italic"})
hi! link pythonBuiltin     Python
hi! link pythonBuiltinObj  Python
hi! link pythonBuiltinFunc Python
hi! link pythonFunction    Statement
hi! link pythonStatement   Python
hi! link pythonDecorator   Python
hi! link pythonInclude     Python
hi! link pythonImport      Python
hi! link pythonRun         Python
hi! link pythonCoding      Python
hi! link pythonOperator    Python
hi! link pythonException   Python
hi! link pythonExceptions  Python
hi! link pythonBoolean     Python
hi! link pythonDot         Python
hi! link pythonConditional Python
hi! link pythonRepeat      Python
hi! link pythonDottedName  Python

" Vimtex
call s:h("Tex",          {"fg": s:norm_subtle, "gui": "italic", "cterm": "italic"})
hi! link texSection Tex
hi! link texStatement Tex
hi! link texBeginEnd Tex
