" Vim color file
"
" Author: Tomas Restrepo <tomas@winterdom.com>
" https://github.com/tomasr/molokai
"
" Note: Based on the Monokai theme for TextMate
" by Wimer Hazenberg and its darker variant
" by Hamish Stuart Macpherson
"

hi clear
if exists("syntax_on")
    syntax reset
endif
let g:colors_name="molokai"

hi Boolean         guifg=#AE81FF
hi Character       guifg=#E6DB74
hi Number          guifg=#AE81FF
hi String          guifg=#E6DB74
hi Conditional     guifg=#F92672               gui=bold
hi Constant        guifg=#AE81FF               gui=bold
hi Cursor          guifg=#000000 guibg=#F8F8F0
hi iCursor         guifg=#000000 guibg=#F8F8F0
hi Debug           guifg=#BCA3A3               gui=bold
hi Define          guifg=#66D9EF
hi Delimiter       guifg=#8F8F8F

" diff (unified)
hi diffAdded       guifg=#2BFF2B gui=NONE      ctermfg=46  cterm=NONE
hi diffRemoved     guifg=#FF2B2B gui=NONE      ctermfg=196 cterm=NONE
hi link diffSubname Normal

" diff (side-by-side)
hi DiffAdd         guifg=black   guibg=#2BFF2B ctermfg=0   ctermbg=46  gui=NONE cterm=NONE
hi DiffChange      guifg=white   guibg=#4C4745 ctermfg=255 ctermbg=239 gui=NONE cterm=NONE
hi DiffDelete      guifg=white   guibg=#FF2B2B ctermfg=255 ctermbg=196 gui=NONE cterm=NONE
hi DiffText        guifg=#000000 guibg=#ffb733 gui=NONE  ctermfg=000  ctermbg=214  cterm=NONE

hi Directory       guifg=#A6E22E               gui=bold

hi Error           guifg=White   guibg=Red                 ctermfg=15 ctermbg=9
hi ErrorMsg        guifg=White   guibg=Red     gui=bold    ctermfg=15 ctermbg=1 cterm=bold

hi Exception       guifg=#A6E22E               gui=bold
hi Float           guifg=#AE81FF

"If 242 is too dark, keep incrementing...
hi FoldColumn      guifg=#465457 guibg=#000000 ctermfg=242 ctermbg=16
hi Folded          guifg=#465457 guibg=NONE    ctermfg=242 ctermbg=NONE

hi Function        guifg=#A6E22E
hi Identifier      guifg=#FD971F
hi Ignore          guifg=#808080 guibg=bg

hi Keyword         guifg=#F92672               gui=bold
hi Label           guifg=#E6DB74               gui=none
hi Macro           guifg=#C4BE89               gui=italic
hi SpecialKey      guifg=#66D9EF               gui=italic

hi MatchParen      guifg=#000000 guibg=#FD971F gui=NONE ctermfg=000 ctermbg=208 cterm=NONE
hi ModeMsg         guifg=#E6DB74
hi MoreMsg         guifg=#E6DB74
hi Operator        guifg=#F92672

" completion/popup menu
hi Pmenu           guifg=white   guibg=#000000 ctermfg=255  ctermbg=16
hi PmenuSel        guifg=white   guibg=#0a9dff gui=NONE ctermfg=255 ctermbg=242 cterm=NONE
hi PmenuSbar                     guibg=#857f78             ctermbg=232
hi PmenuThumb      guifg=#242321               ctermfg=81

hi PreCondit       guifg=#A6E22E               gui=bold
hi PreProc         guifg=#A6E22E
hi Question        guifg=#66D9EF
hi Repeat          guifg=#F92672               gui=bold
hi Search          guifg=#000000 guibg=#FFE792 ctermfg=0   ctermbg=222   cterm=NONE
hi IncSearch       guifg=#C4BE89 guibg=#000000 ctermfg=193 ctermbg=16
hi QuickFixLine    guibg=#F92672 ctermbg=197


" marks
hi SignColumn      guifg=#A6E22E guibg=#232526
hi SpecialChar     guifg=#F92672               gui=bold
hi SpecialComment  guifg=#7E8E91               gui=bold
hi Special         guifg=#66D9EF guibg=bg      gui=italic
if has("spell")
    hi SpellBad    guisp=#FF0000 gui=undercurl cterm=underline
    hi SpellCap    guisp=#7070F0 gui=undercurl cterm=undercurl
    hi SpellLocal  guisp=#70F0F0 gui=undercurl cterm=underline
    hi SpellRare   guisp=#FFFFFF gui=undercurl cterm=underline
endif
hi Statement       guifg=#F92672 gui=bold ctermfg=197 cterm=bold
hi StatusLine      guifg=#455354 guibg=fg
hi StatusLineNC    guifg=#808080 guibg=#080808
hi StorageClass    guifg=#FD971F               gui=italic
hi Structure       guifg=#66D9EF
hi Tag             guifg=#F92672               gui=italic
hi Title           guifg=#ef5939
hi Todo            guifg=#FFFFFF guibg=bg      gui=bold

hi Typedef         guifg=#66D9EF
hi Type            guifg=#66D9EF               gui=none
hi Underlined      guifg=#808080               gui=underline

hi VertSplit       guifg=#808080 guibg=#080808 gui=bold
hi VisualNOS                     guibg=#403D3D
hi Visual                        guibg=#403D3D
hi WarningMsg      guifg=#FFFFFF guibg=#333333 gui=bold
hi WildMenu        guifg=#66D9EF guibg=#000000

hi TabLineFill     guifg=#1B1D1E guibg=#1B1D1E
hi TabLine         guibg=#1B1D1E guifg=#808080 gui=none

hi Normal          guifg=#F8F8F2 guibg=#1B1D1E
hi Comment         guifg=#7E8E91
hi CursorLine                    guibg=#293739
hi CursorLineNr    guifg=#FD971F               gui=none
hi CursorColumn                  guibg=#293739
hi ColorColumn                   guibg=#232526
hi LineNr          guifg=#465457 guibg=#232526
hi NonText         guifg=#465457
hi SpecialKey      guifg=#465457

" cterm ...............................

hi Normal       ctermfg=252 ctermbg=234
hi CursorLine               ctermbg=236   cterm=none
hi CursorLineNr ctermfg=208               cterm=none
hi CursorColumn                ctermbg=236
hi ColorColumn                 ctermbg=236
hi Cursor          ctermfg=16  ctermbg=253

hi Debug           ctermfg=225               cterm=bold
hi Define          ctermfg=81
hi Delimiter       ctermfg=241

" hi Exception       ctermfg=154               cterm=bold
hi Exception       ctermfg=118               cterm=bold

hi Ignore          ctermfg=244 ctermbg=234

hi Label           ctermfg=229               cterm=none
hi Macro           ctermfg=193

hi ModeMsg         ctermfg=229
hi MoreMsg         ctermfg=229

hi Question        ctermfg=81

" marks column
hi SignColumn      ctermfg=118 ctermbg=235
hi SpecialChar     ctermfg=161               cterm=bold
hi SpecialComment  ctermfg=245               cterm=bold
hi Special         ctermfg=81
if has("spell")
   hi SpellBad                ctermbg=52
   hi SpellCap                ctermbg=17
   hi SpellLocal              ctermbg=17
   hi SpellRare  ctermfg=none ctermbg=none  cterm=reverse
endif
hi StatusLine      ctermfg=238 ctermbg=253
hi StatusLineNC    ctermfg=244 ctermbg=232
hi StorageClass    ctermfg=208
hi Structure       ctermfg=81
hi Todo            ctermfg=231 ctermbg=234   cterm=bold

hi Typedef         ctermfg=81
hi Type            ctermfg=81                cterm=none
hi Underlined      ctermfg=244               cterm=underline

hi VertSplit       ctermfg=244 ctermbg=232   cterm=bold
hi VisualNOS                   ctermbg=238
hi WarningMsg      ctermfg=231 ctermbg=238   cterm=bold
hi WildMenu        ctermfg=81  ctermbg=16

hi Boolean         ctermfg=141
hi Character       ctermfg=222
hi Number          ctermfg=141
hi String          ctermfg=222
hi Conditional     ctermfg=197               cterm=bold
hi Constant        ctermfg=141               cterm=bold

hi Directory       ctermfg=154               cterm=bold
hi Float           ctermfg=141
hi Function        ctermfg=154
hi Identifier      ctermfg=208

hi Keyword         ctermfg=197               cterm=bold
hi Operator        ctermfg=197
hi PreCondit       ctermfg=154               cterm=bold
hi PreProc         ctermfg=154
hi Repeat          ctermfg=197               cterm=bold

hi Tag             ctermfg=197
hi Title           ctermfg=203
hi Visual                      ctermbg=238

hi Comment         ctermfg=244
hi LineNr          ctermfg=239 ctermbg=235
hi NonText         ctermfg=239
hi SpecialKey      ctermfg=239

" Must be at the end, because of ctermbg=234 bug.
" https://groups.google.com/forum/#!msg/vim_dev/afPqwAFNdrU/nqh6tOM87QUJ
set background=dark
