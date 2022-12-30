" local syntax file - set colors on a per-machine basis: vim: tw=0 ts=4 sw=4
" Vim color file

set background=dark
hi clear
if exists("syntax_on")
  syntax reset
endif
let g:colors_name = "rem"

hi Normal cterm=none ctermfg=White
hi Constant cterm=none  ctermfg=green
hi Special cterm=none ctermfg=Magenta
hi Underlined cterm=underline ctermfg=Blue
hi Title cterm=bold ctermfg=Magenta
hi NonText cterm=none ctermfg=DarkCyan
hi Identifier cterm=none ctermfg=Blue
hi Function cterm=none ctermfg=Magenta
hi Statement cterm=none ctermfg=Magenta guifg=fa5ead
hi PreProc term=underline ctermfg=Yellow guifg=Purple
hi Define cterm=none ctermfg=Yellow guifg=Purple
hi Type term=underline ctermfg=blue gui=NONE guifg=Blue
hi Search term=reverse ctermfg=Black ctermbg=Cyan
hi Tag ctermfg=DarkGreen guifg=DarkGreen
hi Error term=reverse ctermfg=15 ctermbg=9
hi Todo term=standout ctermbg=None ctermfg=Yellow guifg=Blue guibg=Yellow
hi StatusLine term=bold,reverse cterm=NONE ctermfg=Yellow ctermbg=DarkCyan
hi Directory ctermfg=blue
hi VertSplit cterm=NONE
hi LineNr cterm=bold ctermfg=DarkCyan
hi Comment cterm=bold ctermfg=Blue
hi Visual ctermbg=DarkCyan
hi Pmenu ctermbg=Black ctermfg=DarkCyan

hi! link MoreMsg Comment
hi! link ErrorMsg Visual
hi! link WarningMsg ErrorMsg
hi! link Question Comment
hi link String	Constant
hi link Character	Constant
hi link Number	Constant
hi link MyFilename	Identifier
hi link Boolean	Constant
hi link Float		Number
hi link Conditional	Statement
hi link Repeat	Statement
hi link Label		Statement
hi link Operator	Statement
hi link Keyword	Define
hi link Exception	Statement
hi link Include	PreProc
hi link Macro		PreProc
hi link PreCondit	PreProc
hi link StorageClass	Type
hi link Structure	Type
hi link Typedef	Type
hi link SpecialChar	Special
hi link Delimiter	Special
hi link SpecialComment Special
hi link Debug		Special

" TABLINE
" hi TabLineFill cterm=bold ctermfg=DarkCyan ctermbg=Black
hi TabLine cterm=bold ctermfg=DarkCyan ctermbg=None
hi TabLineSel cterm=bold ctermfg=Magenta ctermbg=None
hi Folded ctermfg=DarkBlue
hi Folded ctermbg=None
hi WildMenu ctermfg=White ctermbg=Black

" CSV FILES
hi CSVColumnEven ctermfg=White ctermbg=None
hi CSVColumnOdd ctermfg=White ctermbg=None
hi CSVColumnHeaderEven ctermfg=Magenta ctermbg=None
hi CSVColumnHeaderOdd ctermfg=Magenta ctermbg=None
hi CSVDelimiter ctermfg=DarkCyan ctermbg=None
hi def link myCsvHeading Special
hi def link myCsvComma NonText

" FLOATERM
hi Floaterm ctermbg=None
" Set floating window border line color to cyan, and background to orange
hi FloatermBorder ctermfg=Blue ctermbg=None

" START SCREEN
hi StartifyBracket ctermfg=Blue
hi StartifyFile    ctermfg=Blue
hi StartifySection cterm=bold ctermfg=Magenta
hi StartifyFooter  ctermfg=DarkCyan
hi StartifyHeader  ctermfg=Blue
hi StartifyNumber  ctermfg=Blue
hi StartifyPath    ctermfg=White
hi StartifySlash   ctermfg=White
hi StartifySpecial ctermfg=DarkCyan

" SPELLING
hi SpellBad cterm=underline ctermfg=Red ctermbg=NONE
hi SpellCap cterm=underline ctermfg=White ctermbg=NONE
hi SpellLocal cterm=underline ctermfg=White ctermbg=NONE
hi SpellRare cterm=underline ctermfg=White ctermbg=NONE

" LATEX
hi Conceal ctermbg=none ctermfg=Magenta
hi texStatement ctermbg=NONE ctermfg=Magenta
hi texSection ctermbg=NONE ctermfg=Green

" GITGUTTER
hi clear SignColumn
hi GitGutterAdd ctermbg=none ctermfg=Green
hi GitGutterChange ctermbg=none ctermfg=Blue
hi GitGutterDelete ctermbg=none ctermfg=Magenta
hi GitGutterChangeDelete ctermbg=none ctermfg=Yellow

" QUICKFIXLINE
hi StatusLine cterm=none ctermbg=None ctermfg=Black
hi StatusLineNC cterm=none ctermbg=None ctermfg=Black
hi QuickFixLine ctermbg=DarkCyan ctermfg=Blue
hi qfFileName ctermbg=None ctermfg=Blue
hi qfLineNr ctermbg=None ctermfg=White
hi qfSeparator ctermbg=None ctermfg=White
hi qfError ctermbg=None ctermfg=Green

"CURSORLINE
hi CursorLine cterm=none ctermfg=Blue ctermbg=DarkCyan
hi CursorColumn cterm=none ctermbg=DarkCyan
hi CtrlPNoEntries cterm=none ctermfg=DarkCyan
hi CtrlPPrtText cterm=none ctermfg=Green ctermbg=none
hi CtrlPPrtBase cterm=none ctermfg=DarkCyan ctermbg=none
hi CtrlPPrtCursor cterm=none ctermfg=DarkCyan ctermbg=none
hi CtrlPMatch cterm=none ctermfg=White ctermbg=none

"STATUS LINE
hi User2 cterm=bold ctermfg=DarkCyan ctermbg=None
hi ModeMsg cterm=bold ctermfg=Blue ctermbg=None 

"ALE
hi ALEErrorSign ctermfg=DarkCyan ctermbg=None
hi ALEWarningSign ctermfg=DarkCyan ctermbg=None

"MARKDOWN
hi myFilesMd cterm=bold ctermfg=Blue
hi link myFilesTxt myFilesMd
hi link myFilesCsv myFilesMd
hi link myCheckbox myFilesMd
hi link myCheckboxOK myFilesMd

"PYTHON
hi link myPyDecorators Define
