"=============================================================================
" init.vim --- Entry file for neovim
" Copyright (c) 2016-2020 Wang Shidong & Contributors
" Author: Wang Shidong < wsdjeg@outlook.com >
" URL: https://spacevim.org
" License: GPLv3
"=============================================================================

execute 'source' fnamemodify(expand('<sfile>'), ':h').'/config/main.vim'

" ==================================
" CUSTOM: colorscheme After
" ==================================
if $DARKBG != ''
  set termguicolors
  " let colorNr = localtime() % 5
  let colorNr = 1
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
    hi! CursorLine guibg=#2c4b53 gui=none
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
    hi! link ALEWarningSign Type
  elseif colorNr == 4  && &rtp =~ 'vim-material'
    colorscheme material
    hi! Normal guifg=#ccdddd
    hi! Search gui=underline guifg=#cfffff
    hi! SignColumn guibg=#374349
    hi! Error guibg=#374349
    hi! Pmenu guifg=#cfffff guibg=#323232
    hi! Structure guifg=#00dfd7
    hi! StorageClass guifg=#bd93f9
    hi! MatchParen gui=bold
    hi! Operator gui=bold
    hi! Function gui=bold guifg=#82aaff
    hi! Type gui=italic guifg=#ffcb6b
    hi! String gui=italic guifg=#c3e88d
    hi! Pmenu guifg=#d7dfff
    hi! link ALEWarningSign Type
  endif
endif
hi! BookmarkSignDefault guifg=yellow
if $WSL_DISTRO_NAME != ''
  " Windows Terminal暂时还不支持undercurl，且无法回滚为underline
  hi! SpellBad gui=underline guifg=Red
  hi! SpellCap gui=underline guifg=Yellow
  hi! SpellRare gui=underline guifg=Green
else
  hi! SpellBad gui=undercurl guisp=red
  hi! SpellCap gui=undercurl guisp=yellow
  hi! SpellRare gui=undercurl guisp=magenta
endif

