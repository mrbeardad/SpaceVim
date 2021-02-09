"=============================================================================
" init.vim --- Entry file for neovim
" Copyright (c) 2016-2020 Wang Shidong & Contributors
" Author: Wang Shidong < wsdjeg@outlook.com >
" URL: https://spacevim.org
" License: GPLv3
"=============================================================================

" ============================ Before Load SpaceVim ==========================
execute 'source' fnamemodify(expand('<sfile>'), ':h').'/main.vim'
" ============================ After Load SpaceVim  ==========================

" ==================================
" CUSTOM: colorscheme After
" ==================================
if &diff == 1
  set termguicolors
  colorscheme gruvbox
  finish
endif
if $DARKBG != ''
  set termguicolors
  if $DARKBG == 'SpaceVim'
    let colorNr = 0
  elseif $DARKBG == 'gruvbox'
    let colorNr = 1
  elseif $DARKBG == 'NeoSolarized'
    let colorNr = 2
  elseif $DARKBG == 'palenight.vim'
    let colorNr = 3
  elseif $DARKBG == 'vim-material'
    let colorNr = 4
  else
    let colorNr = localtime() % 5
  endif
  " let colorNr = 4
  if colorNr == 0
    colorscheme SpaceVim
  elseif colorNr == 1  && &rtp =~ 'gruvbox'
    colorscheme gruvbox
  elseif colorNr == 2  && &rtp =~ 'NeoSolarized'
    colorscheme NeoSolarized
  elseif colorNr == 3  && &rtp =~ 'palenight.vim'
    colorscheme palenight
  elseif colorNr == 4  && &rtp =~ 'vim-material'
    colorscheme material
  endif
endif
let g:header_auto_add_header = 0
