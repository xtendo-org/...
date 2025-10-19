set background=light
set notermguicolors

if exists('syntax_on')
    syntax reset
endif

" Colorscheme name
let g:colors_name = 'xtsimple'

" highlight groups {{{

set t_Co=256

hi LineNr ctermbg=NONE ctermfg=3

hi Comment ctermbg=NONE ctermfg=1 cterm=italic
hi Conditional ctermfg=3 cterm=bold
hi Constant ctermbg=NONE ctermfg=12 cterm=bold
hi clear Function
hi Function cterm=italic
hi Identifier ctermbg=none ctermfg=none cterm=bold
hi Include ctermfg=1
hi Keyword ctermbg=NONE ctermfg=3 cterm=bold
hi NormalFloat ctermbg=7
hi Operator ctermfg=3 cterm=bold
hi PreProc ctermbg=NONE ctermfg=13 cterm=italic,bold
hi Repeat ctermfg=1 cterm=bold
hi Search ctermbg=11 ctermfg=0
hi Special ctermbg=NONE ctermfg=5 cterm=bold
hi Statement ctermbg=NONE ctermfg=9 cterm=italic,bold
hi String ctermbg=NONE ctermfg=1
hi Todo ctermbg=10 ctermfg=0
hi Type ctermbg=255 cterm=bold,italic

hi @function.builtin ctermfg=5 cterm=bold

" Custom groups

hi SymbolMain ctermfg=4
hi SymbolSpecial ctermfg=1 cterm=bold
hi SymbolAux ctermfg=7
hi SymbolThreatening ctermbg=10 ctermfg=0

hi! link SymbolAssignment Operator
hi Bracket ctermfg=8 cterm=none

" Semantic tokens (LSP).

hi @lsp.type.parameter ctermfg=8 cterm=bold
hi link @lsp.type.function Function
hi @lsp.type.method ctermfg=6 cterm=nocombine,bold
hi @lsp.type.variable ctermfg=8
hi @lsp.type.keyword ctermfg=white ctermbg=1 cterm=bold
hi @lsp.type.namespace ctermbg=255 ctermfg=8
hi @lsp.type.class ctermfg=none cterm=bold
hi @lsp.type.decorator ctermfg=4 ctermfg=none
hi @lsp.type.enum ctermfg=2 cterm=bold
hi @lsp.type.enumMember ctermfg=5 cterm=bold
" hi @lsp.type.type ctermbg=255 cterm=bold,italic
hi link @lsp.type.type Type
hi @lsp.type.typeParameter ctermbg=230

hi clear LspReferenceText
hi LspReferenceText ctermbg=226

" Python

hi! link pythonFunction Function
hi pythonLocal ctermfg=2
hi pythonBuiltinConstant ctermfg=5 cterm=italic
hi pythonBuiltinFunction ctermfg=13 cterm=bold,italic
hi pythonBuiltinException ctermfg=5 cterm=bold
hi pythonBuiltinModule ctermfg=11 cterm=bold
hi pythonDottedName ctermfg=4
hi pythonConventional ctermfg=5 cterm=bold
hi pythonLower ctermfg=8
hi pythonUpper ctermfg=4
hi link pythonBracket Bracket
hi! link pythonAssignmentOperator Operator

" Mostly Haskell

hi! link hsImportModuleName Structure
" hi VarId ctermfg=4
hi link ConId Constant
hi link hsVarSym Operator
hi link hsDelimiter Bracket
hi link hsStructure Keyword

" Markdown

hi markdownCode cterm=NONE ctermfg=5
hi markdownCodeDelimiter cterm=NONE ctermfg=2

" Vim-specific

hi MatchParen cterm=bold ctermfg=0 ctermbg=10

hi signColumn ctermbg=NONE ctermfg=4
hi vimBracket ctermbg=NONE ctermfg=7
hi vimCommentString ctermbg=NONE ctermfg=8
hi vimMapModKey ctermbg=NONE ctermfg=4
hi vimNotation ctermbg=NONE ctermfg=4
hi vimUserCommand ctermbg=NONE ctermfg=1 cterm=bold
hi xdefaultsValue ctermbg=NONE ctermfg=7
hi DirvishGitModified ctermbg=1 ctermfg=5

hi ColorColumn ctermfg=255 ctermbg=0
hi CursorColumn ctermbg=255 ctermfg=NONE

hi CursorLine cterm=NONE ctermbg=255 ctermfg=NONE
hi Conceal ctermbg=NONE ctermfg=3 cterm=bold

hi DiagnosticUnderlineError cterm=underline guisp=#cf494c
hi DiagnosticUnderlineWarn cterm=underline guisp=#ff9900
hi DiagnosticUnderlineInfo cterm=underline guisp=#0575d8
hi DiagnosticUnderlineHint cterm=underline guisp=Cyan
hi DiagnosticUnderlineOk cterm=underline guisp=Green

" Spell

hi UndercurlRed cterm=undercurl guisp=#cf494c
hi UndercurlGreen cterm=undercurl guisp=#60b442
hi UndercurlYellow cterm=undercurl guisp=#db9c11
hi UndercurlBlue cterm=undercurl guisp=#0575d8
hi UndercurlMagenta cterm=undercurl guisp=#af5ed2
hi UndercurlCyan cterm=undercurl guisp=#1db6bb

hi! link SpellBad UndercurlRed
hi! link SpellCap UndercurlYellow
hi! link SpellLocal UndercurlMagenta
hi! link SpellRare UndercurlMagenta
"hi SpelunkerSpellBad ctermfg=NONE cterm=undercurl guisp=#ff9900
"hi SpelunkerComplexOrCompoundWord ctermbg=NONE cterm=undercurl guisp=Red

" hi Visual ctermbg=231 ctermfg=NONE
" hi PmenuSel ctermbg=231 ctermfg=NONE

" hi @lsp.mod.deprecated       ctermfg=15  cterm=underline  ctermbg=1
" hi @lsp.type.class           ctermfg=3   cterm=bold
" hi @lsp.type.decorator       ctermfg=2   cterm=bold
" hi @lsp.type.enum            ctermfg=1
" hi @lsp.type.enumMember      ctermfg=3
" hi @lsp.type.event           ctermfg=7
" hi @lsp.type.function        ctermfg=2
" hi @lsp.type.interface       ctermfg=3
" hi @lsp.type.keyword         ctermfg=1   cterm=bold
" hi @lsp.type.macro           ctermfg=3   cterm=bold
" hi @lsp.type.method          ctermfg=6   cterm=bold
" hi @lsp.type.modifier        ctermfg=3
" hi @lsp.type.namespace       ctermfg=12
" hi @lsp.type.number          ctermfg=9
" hi @lsp.type.parameter       ctermfg=1   cterm=bold
" hi @lsp.type.property        ctermfg=5
" hi @lsp.type.regexp          ctermfg=13
" hi @lsp.type.string          ctermfg=1
" hi @lsp.type.struct          ctermfg=1
" hi @lsp.type.type            ctermfg=13  cterm=bold      ctermbg=255
" hi @lsp.type.typeParameter   ctermfg=5   ctermbg=255
" hi @lsp.type.variable        ctermfg=NONE

" hi ALEError ctermbg=NONE ctermfg=1
" hi ALEErrorSign ctermbg=NONE ctermfg=1
" hi ALEWarning ctermbg=NONE ctermfg=3
" hi ALEWarningSign ctermbg=NONE ctermfg=3
" hi Boolean ctermbg=NONE ctermfg=5
" hi Character ctermbg=NONE ctermfg=1
" hi ColorColumn ctermbg=4 ctermfg=0
" hi Conceal ctermbg=NONE
" hi Conditional ctermbg=NONE ctermfg=5
" hi Cursor ctermbg=NONE ctermfg=8
" hi CursorColumn ctermbg=8 ctermfg=7
" hi CursorLine ctermbg=2 ctermfg=0
" hi CursorLineNr ctermbg=NONE ctermfg=8
" hi Define ctermbg=NONE ctermfg=5
" hi Delimiter ctermbg=NONE ctermfg=5
" hi DiffAdd ctermbg=NONE ctermfg=2
" hi DiffChange ctermbg=NONE ctermfg=8
" hi DiffDelete ctermbg=NONE ctermfg=1
" hi DiffText ctermbg=NONE ctermfg=4
" hi Directory ctermbg=NONE ctermfg=4
" hi Error ctermbg=1 ctermfg=7 cterm=bold
" hi ErrorMsg ctermbg=NONE ctermfg=8
" hi Float ctermbg=NONE ctermfg=5
" hi FoldColumn ctermbg=NONE ctermfg=7
" hi Folded ctermbg=NONE ctermfg=8
" hi Ignore ctermbg=8 ctermfg=0
" hi IncSearch ctermbg=3 ctermfg=0
" hi Include ctermbg=NONE ctermfg=4
" hi Label ctermbg=NONE ctermfg=3
" hi LineNr ctermbg=NONE ctermfg=8
" hi MatchParen ctermbg=1 ctermfg=8
" hi ModeMsg ctermbg=NONE ctermfg=2
" hi ModeMsg ctermbg=NONE ctermfg=7
" hi MoreMsg ctermbg=NONE ctermfg=2
" hi NERDTreeDirSlash ctermbg=NONE ctermfg=4
" hi NERDTreeExecFile ctermbg=NONE ctermfg=7
" hi NonText ctermbg=NONE ctermfg=8
" hi Normal ctermbg=NONE ctermfg=0 cterm=bold
" hi Number ctermbg=NONE ctermfg=3
" hi Operator ctermbg=NONE ctermfg=5
" hi Pmenu ctermbg=8 ctermfg=7
" hi PmenuSbar ctermbg=6 ctermfg=7
" hi PmenuSel ctermbg=4 ctermfg=0
" hi PmenuThumb ctermbg=8 ctermfg=8
" hi PreProc ctermbg=NONE ctermfg=3
" hi Question ctermbg=NONE ctermfg=4
" hi Repeat ctermbg=NONE ctermfg=3
" hi Search ctermbg=3 ctermfg=0
" hi SignifySignAdd ctermbg=NONE ctermfg=2
" hi SignifySignChange ctermbg=NONE ctermfg=4
" hi SignifySignDelete ctermbg=NONE ctermfg=1
" hi Special ctermbg=NONE ctermfg=6
" hi SpecialChar ctermbg=NONE ctermfg=5
" hi SpecialKey ctermbg=NONE ctermfg=8
" hi SpellBad ctermbg=NONE ctermfg=1 cterm=underline
" hi SpellCap ctermbg=NONE ctermfg=4 cterm=underline
" hi SpellLocal ctermbg=NONE ctermfg=5 cterm=underline
" hi SpellRare ctermbg=NONE ctermfg=6 cterm=underline
" hi Statement ctermbg=NONE ctermfg=3 cterm=bold
" hi StatusLine ctermbg=7 ctermfg=0
" hi StatusLineNC ctermbg=8 ctermfg=0
" hi Structure ctermbg=NONE ctermfg=6 cterm=bold
" hi TabLine ctermbg=NONE ctermfg=8
" hi TabLineFill ctermbg=NONE ctermfg=8
" hi TabLineSel ctermbg=4 ctermfg=0
" hi Tag ctermbg=NONE ctermfg=3
" hi TermCursorNC ctermbg=3 ctermfg=0
" hi Title ctermbg=NONE ctermfg=1
" hi Todo ctermbg=2 ctermfg=0
" hi Type ctermbg=NONE ctermfg=6
" hi Typedef ctermbg=NONE ctermfg=3
" hi Underlined ctermbg=NONE ctermfg=1 cterm=underline
" hi VertSplit ctermbg=8 ctermfg=0
" hi Visual ctermbg=0 ctermfg=15 cterm=reverse term=reverse
" hi VisualNOS ctermbg=NONE ctermfg=1
" hi WarningMsg ctermbg=1 ctermfg=0
" hi WildMenu ctermbg=2 ctermfg=0
" hi cOperator ctermbg=NONE ctermfg=6
" hi cPreCondit ctermbg=NONE ctermfg=5
" hi cssBraces ctermbg=NONE ctermfg=7
" hi cssFunctionName ctermbg=NONE ctermfg=4
" hi cssMultiColumnAttr ctermbg=NONE ctermfg=2
" hi cssNoise ctermbg=NONE ctermfg=8
" hi cssTagName ctermbg=NONE ctermfg=1
" hi cssUnitDecorators ctermbg=NONE ctermfg=7
" hi cssValueLength ctermbg=NONE ctermfg=7
" hi cssValueNumber ctermbg=NONE ctermfg=7
" hi helpLeadBlank ctermbg=NONE ctermfg=7
" hi helpNormal ctermbg=NONE ctermfg=7
" hi htmlBold ctermbg=NONE ctermfg=3 cterm=bold
" hi htmlEndTag ctermbg=NONE ctermfg=7
" hi htmlH1 ctermbg=NONE ctermfg=7
" hi htmlItalic ctermbg=NONE ctermfg=5
" hi htmlLink ctermbg=NONE ctermfg=1 cterm=underline
" hi htmlTag ctermbg=NONE ctermfg=7
" hi htmlTagName ctermbg=NONE ctermfg=1 cterm=bold
" hi javaScript ctermbg=NONE ctermfg=7
" hi javaScriptBraces ctermbg=NONE ctermfg=7
" hi javaScriptNumber ctermbg=NONE ctermfg=5
" hi markdownAutomaticLink ctermbg=NONE ctermfg=2 cterm=underline
" hi markdownBold cterm=Bold
" hi markdownCode ctermbg=NONE ctermfg=3
" hi markdownCodeBlock ctermbg=NONE ctermfg=3
" hi markdownCodeDelimiter ctermbg=NONE ctermfg=5
" hi markdownError ctermbg=NONE ctermfg=7
" hi markdownH1 ctermbg=NONE ctermfg=7
" hi markdownItalic cterm=Italic
" hi phpComparison ctermbg=NONE ctermfg=7
" hi phpMemberSelector ctermbg=NONE ctermfg=7
" hi phpParent ctermbg=NONE ctermfg=7
" hi rubyAttribute ctermbg=NONE ctermfg=4
" hi rubyConstant ctermbg=NONE ctermfg=3
" hi rubyDefine ctermbg=NONE ctermfg=5
" hi rubyFunction ctermbg=NONE ctermfg=4
" hi rubyInclude ctermbg=NONE ctermfg=4
" hi rubyInteger ctermbg=NONE ctermfg=3
" hi rubyInterpolation ctermbg=NONE ctermfg=2
" hi rubyInterpolationDelimiter ctermbg=NONE ctermfg=3
" hi rubyRegexp ctermbg=NONE ctermfg=6
" hi rubyRegexpAnchor ctermbg=NONE ctermfg=7
" hi rubyStringDelimiter ctermbg=NONE ctermfg=2
" hi rubySymbol ctermbg=NONE ctermfg=2
" hi rubyTodo ctermbg=NONE ctermfg=8
" hi sassClassChar ctermbg=NONE ctermfg=5
" hi sassInclude ctermbg=NONE ctermfg=5
" hi sassMixinName ctermbg=NONE ctermfg=4
" hi sassMixing ctermbg=NONE ctermfg=5
" hi sassidChar ctermbg=NONE ctermfg=1
" hi scssAttribute ctermbg=NONE ctermfg=7
" hi scssSelectorChar ctermbg=NONE ctermfg=7

"     hi link cssAttrComma cssBraces
"     hi link cssFlexibleBoxAttr cssMultiColumnAttr
"     hi link cssFontAttr cssMultiColumnAttr
"     hi link cssValueLength cssValueNumber
"     hi link htmlH2 htmlH1
"     hi link htmlH3 htmlH1
"     hi link htmlH4 htmlH1
"     hi link htmlH5 htmlH1
"     hi link htmlH6 htmlH1
"     hi link markdownH2 markdownH1
"     hi link markdownH3 markdownH1
"     hi link markdownH4 markdownH1
"     hi link markdownH5 markdownH1
"     hi link markdownH6 markdownH1
"     hi link markdownUrl markdownAutomaticLink
"     hi link rubyRegexpQuantifier rubyRegexpAnchor
"     hi link scssDefinition cssNoise
"     hi link vimAutoCmd vimUserCommand
"     hi link vimCommand vimUserCommand
"     hi link vimFTCmd vimUserCommand
"     hi link vimLet vimUserCommand
"     hi link vimMap vimUserCommand
"     hi link vimNotFunc vimUserCommand

" hi ALEError ctermbg=NONE ctermfg=1
" hi ALEErrorSign ctermbg=NONE ctermfg=1
" hi ALEWarning ctermbg=NONE ctermfg=3
" hi ALEWarningSign ctermbg=NONE ctermfg=3
" hi Boolean ctermbg=NONE ctermfg=5
" hi Character ctermbg=NONE ctermfg=1
" hi ColorColumn ctermbg=4 ctermfg=0
" hi Comment ctermbg=NONE ctermfg=9 cterm=italic
" hi Conceal ctermbg=NONE
" hi Conditional ctermbg=NONE ctermfg=5
" hi Constant ctermbg=NONE ctermfg=3
" hi Cursor ctermbg=NONE ctermfg=8
" hi CursorColumn ctermbg=8 ctermfg=7
" hi CursorLine ctermbg=2 ctermfg=0
" hi CursorLineNr ctermbg=NONE ctermfg=8
" hi Define ctermbg=NONE ctermfg=5
" hi Delimiter ctermbg=NONE ctermfg=5
" hi DiffAdd ctermbg=NONE ctermfg=2
" hi DiffChange ctermbg=NONE ctermfg=8
" hi DiffDelete ctermbg=NONE ctermfg=1
" hi DiffText ctermbg=NONE ctermfg=4
" hi Directory ctermbg=NONE ctermfg=4
" hi Error ctermbg=1 ctermfg=7 cterm=bold
" hi ErrorMsg ctermbg=NONE ctermfg=8
" hi Float ctermbg=NONE ctermfg=5
" hi FoldColumn ctermbg=NONE ctermfg=7
" hi Folded ctermbg=NONE ctermfg=8
" hi Identifier ctermbg=NONE ctermfg=4
" hi Ignore ctermbg=8 ctermfg=0
" hi IncSearch ctermbg=3 ctermfg=0
" hi Include ctermbg=NONE ctermfg=4
" hi Keyword ctermbg=NONE ctermfg=5
" hi Label ctermbg=NONE ctermfg=3
" hi LineNr ctermbg=NONE ctermfg=8
" hi MatchParen ctermbg=1 ctermfg=8
" hi ModeMsg ctermbg=NONE ctermfg=2
" hi ModeMsg ctermbg=NONE ctermfg=7
" hi MoreMsg ctermbg=NONE ctermfg=2
" hi NERDTreeDirSlash ctermbg=NONE ctermfg=4
" hi NERDTreeExecFile ctermbg=NONE ctermfg=7
" hi NonText ctermbg=NONE ctermfg=8
" hi Normal ctermbg=NONE ctermfg=0 cterm=bold
" hi Number ctermbg=NONE ctermfg=3
" hi Operator ctermbg=NONE ctermfg=5
" hi Pmenu ctermbg=8 ctermfg=7
" hi PmenuSbar ctermbg=6 ctermfg=7
" hi PmenuSel ctermbg=4 ctermfg=0
" hi PmenuThumb ctermbg=8 ctermfg=8
" hi PreProc ctermbg=NONE ctermfg=3
" hi Question ctermbg=NONE ctermfg=4
" hi Repeat ctermbg=NONE ctermfg=3
" hi Search ctermbg=3 ctermfg=0
" hi SignifySignAdd ctermbg=NONE ctermfg=2
" hi SignifySignChange ctermbg=NONE ctermfg=4
" hi SignifySignDelete ctermbg=NONE ctermfg=1
" hi Special ctermbg=NONE ctermfg=6
" hi SpecialChar ctermbg=NONE ctermfg=5
" hi SpecialKey ctermbg=NONE ctermfg=8
" hi SpellBad ctermbg=NONE ctermfg=1 cterm=underline
" hi SpellCap ctermbg=NONE ctermfg=4 cterm=underline
" hi SpellLocal ctermbg=NONE ctermfg=5 cterm=underline
" hi SpellRare ctermbg=NONE ctermfg=6 cterm=underline
" hi Statement ctermbg=NONE ctermfg=3 cterm=bold
" hi StatusLine ctermbg=7 ctermfg=0
" hi StatusLineNC ctermbg=8 ctermfg=0
" hi String ctermbg=NONE ctermfg=2
" hi Structure ctermbg=NONE ctermfg=6 cterm=bold
" hi TabLine ctermbg=NONE ctermfg=8
" hi TabLineFill ctermbg=NONE ctermfg=8
" hi TabLineSel ctermbg=4 ctermfg=0
" hi Tag ctermbg=NONE ctermfg=3
" hi TermCursorNC ctermbg=3 ctermfg=0
" hi Title ctermbg=NONE ctermfg=1
" hi Todo ctermbg=2 ctermfg=0
" hi Type ctermbg=NONE ctermfg=6
" hi Typedef ctermbg=NONE ctermfg=3
" hi Underlined ctermbg=NONE ctermfg=1 cterm=underline
" hi VertSplit ctermbg=8 ctermfg=0
" hi Visual ctermbg=0 ctermfg=15 cterm=reverse term=reverse
" hi VisualNOS ctermbg=NONE ctermfg=1
" hi WarningMsg ctermbg=1 ctermfg=0
" hi WildMenu ctermbg=2 ctermfg=0
" hi cOperator ctermbg=NONE ctermfg=6
" hi cPreCondit ctermbg=NONE ctermfg=5
" hi cssBraces ctermbg=NONE ctermfg=7
" hi cssFunctionName ctermbg=NONE ctermfg=4
" hi cssMultiColumnAttr ctermbg=NONE ctermfg=2
" hi cssNoise ctermbg=NONE ctermfg=8
" hi cssTagName ctermbg=NONE ctermfg=1
" hi cssUnitDecorators ctermbg=NONE ctermfg=7
" hi cssValueLength ctermbg=NONE ctermfg=7
" hi cssValueNumber ctermbg=NONE ctermfg=7
" hi helpLeadBlank ctermbg=NONE ctermfg=7
" hi helpNormal ctermbg=NONE ctermfg=7
" hi htmlBold ctermbg=NONE ctermfg=3 cterm=bold
" hi htmlEndTag ctermbg=NONE ctermfg=7
" hi htmlH1 ctermbg=NONE ctermfg=7
" hi htmlItalic ctermbg=NONE ctermfg=5
" hi htmlLink ctermbg=NONE ctermfg=1 cterm=underline
" hi htmlTag ctermbg=NONE ctermfg=7
" hi htmlTagName ctermbg=NONE ctermfg=1 cterm=bold
" hi javaScript ctermbg=NONE ctermfg=7
" hi javaScriptBraces ctermbg=NONE ctermfg=7
" hi javaScriptNumber ctermbg=NONE ctermfg=5
" hi markdownAutomaticLink ctermbg=NONE ctermfg=2 cterm=underline
" hi markdownBold cterm=Bold
" hi markdownCode ctermbg=NONE ctermfg=3
" hi markdownCodeBlock ctermbg=NONE ctermfg=3
" hi markdownCodeDelimiter ctermbg=NONE ctermfg=5
" hi markdownError ctermbg=NONE ctermfg=7
" hi markdownH1 ctermbg=NONE ctermfg=7
" hi markdownItalic cterm=Italic
" hi phpComparison ctermbg=NONE ctermfg=7
" hi phpMemberSelector ctermbg=NONE ctermfg=7
" hi phpParent ctermbg=NONE ctermfg=7
" hi pythonFunction ctermbg=NONE ctermfg=6
" hi pythonOperator ctermbg=NONE ctermfg=5
" hi pythonRepeat ctermbg=NONE ctermfg=5
" hi pythonStatement ctermbg=NONE ctermfg=3 cterm=bold
" hi rubyAttribute ctermbg=NONE ctermfg=4
" hi rubyConstant ctermbg=NONE ctermfg=3
" hi rubyDefine ctermbg=NONE ctermfg=5
" hi rubyFunction ctermbg=NONE ctermfg=4
" hi rubyInclude ctermbg=NONE ctermfg=4
" hi rubyInteger ctermbg=NONE ctermfg=3
" hi rubyInterpolation ctermbg=NONE ctermfg=2
" hi rubyInterpolationDelimiter ctermbg=NONE ctermfg=3
" hi rubyRegexp ctermbg=NONE ctermfg=6
" hi rubyRegexpAnchor ctermbg=NONE ctermfg=7
" hi rubyStringDelimiter ctermbg=NONE ctermfg=2
" hi rubySymbol ctermbg=NONE ctermfg=2
" hi rubyTodo ctermbg=NONE ctermfg=8
" hi sassClassChar ctermbg=NONE ctermfg=5
" hi sassInclude ctermbg=NONE ctermfg=5
" hi sassMixinName ctermbg=NONE ctermfg=4
" hi sassMixing ctermbg=NONE ctermfg=5
" hi sassidChar ctermbg=NONE ctermfg=1
" hi scssAttribute ctermbg=NONE ctermfg=7
" hi scssSelectorChar ctermbg=NONE ctermfg=7
" hi signColumn ctermbg=NONE ctermfg=4
" hi vimBracket ctermbg=NONE ctermfg=7
" hi vimCommentString ctermbg=NONE ctermfg=8
" hi vimMapModKey ctermbg=NONE ctermfg=4
" hi vimNotation ctermbg=NONE ctermfg=4
" hi vimUserCommand ctermbg=NONE ctermfg=1 cterm=bold
" hi xdefaultsValue ctermbg=NONE ctermfg=7

" }}}

" Plugin options {{{

let g:limelight_conceal_ctermfg = 8

" }}}
