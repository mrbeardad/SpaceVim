let g:ale_clangtidy_period = 6

"=============================  Load SpaceVim ===============================
execute 'source' fnamemodify(expand('<sfile>'), ':h').'/config/main.vim'
"=============================== After Load =================================

" QuickRun
let g:cpp_default_compile_flag = '-std=c++20 '
let g:c_default_compile_flag = '-std=c11 '

" ALE
let g:ale_cpp_std = '-std=c++20'
let g:ale_cpp_clangtidy_checks = ['*',
      \ '-abseil*',
      \ '-android*',
      \ '-darwin*',
      \ '-fuchsia*',
      \ '-linuxkernel*',
      \ '-*osx*',
      \ '-*objc*',
      \ '-openmp*',
      \ '-zircon*',
      \ '-*avoid-c-arrays',
      \ '-modernize-use-trailing-return-type',
      \ '-readability-isolate-declaration',
      \ ]

" Translator
let g:translator_default_engines = ['bing']

" YCM
let g:ycm_clangd_args = [ '--header-insertion=never' ] " disable automatic insertion `#include`

" Colorscheme
" colorscheme palenight "srcery material
if $DARKBG != ''
  let colorNr = localtime() % 5
  if colorNr == 0
    colorscheme SpaceVim
    hi! CursorLineNr gui=bold guifg=#df5fdf
    hi! CursorLine guibg=#363636
    hi! LineNr guifg=#6c6c6c
    hi! Constant guifg=#af00ee
    hi! Boolean guifg=#af00ee
    hi! Structure guifg=#bd93f9
    hi! StorageClass guifg=#47d0ff
    hi! Comment gui=italic guifg=#007f7f
    hi! String gui=italic guifg=#00dfd7
    hi! Statement guifg=#ff5f87
    hi! Repeat guifg=#ff5f87
    hi! Conditional guifg=#ff5f87
    hi! Label guifg=#ff5f87
    hi! MatchParen gui=bold
    hi! Operator gui=bold
    hi! Function gui=bold guifg=#df5faf
    hi! Type guifg=#ffafdf
    hi! Typedef guifg=#ffafdf
  elseif colorNr == 1  && &rtp =~ 'gruvbox'
    colorscheme gruvbox
    hi! CursorLineNr gui=bold
    hi! GruvboxYellow gui=italic
  elseif colorNr == 2  && &rtp =~ 'NeoSolarized'
    colorscheme NeoSolarized
    hi! NonText guifg=#596364
    hi! Normal guifg=#a5b4b4
    hi! CursorLineNr gui=bold guifg=#2aa198
    hi! CursorLine guibg=#2c4b53
    hi! Operator gui=bold guifg=#8787af
    hi! Structure guifg=#5fafd7
    hi! StorageClass guifg=#d78700
    hi! Function gui=bold guifg=#268bd2
    hi! Type gui=italic
    hi! String gui=italic guifg=#2aa198
  elseif colorNr == 3  && &rtp =~ 'palenight.vim'
    colorscheme palenight
    hi! CursorLine guibg=#3c4658
    hi! CursorLineNr gui=bold
    hi! Structure guifg=#00dfd7
    hi! StorageClass guifg=#87ff00
    hi! StorageClass guifg=#c3e88d
    hi! Operator gui=bold
    hi! MatchParen gui=bold
    hi! Constant guifg=#ff5370
    hi! Function gui=bold guifg=#82b1ff
    hi! Typedef gui=italic guifg=#ffcb6b
    hi! Type gui=italic guifg=#ffcb6b
    hi! String gui=italic guifg=#c3e88d
  elseif colorNr == 4  && &rtp =~ 'vim-material'
    colorscheme material
    hi! Normal guifg=#ccdddd
    hi! Search gui=underline guifg=#cfffff
    hi! SignColumn guibg=#374349
    hi! Error guibg=#374349
    hi! ALEWarningSign guibg=#374349
    hi! Pmenu guifg=#cfffff
    hi! Structure guifg=#00dfd7
    hi! StorageClass guifg=#bd93f9
    hi! MatchParen gui=bold
    hi! Operator gui=bold
    hi! Function gui=bold guifg=#82aaff
    hi! Type gui=italic guifg=#ffcb6b
    hi! String gui=italic guifg=#c3e88d
  endif
else
    colorscheme default-plus
endif
hi! SpellBad gui=undercurl guisp=red
hi! SpellCap gui=undercurl guisp=yellow
hi! SpellRare gui=undercurl guisp=magenta

" Terminal Color
let terminal_color_1 = '#ff5555'
let terminal_color_2 = '#50fa7b'
let terminal_color_3 = '#fabd2f'
let terminal_color_4 = '#bd93f9'
let terminal_color_5 = '#ff79c6'
let terminal_color_6 = '#8be9fd'
let terminal_color_7 = '#bfffff'

" path
set path+=/usr/include/c++/*/,/usr/include/boost/,.
