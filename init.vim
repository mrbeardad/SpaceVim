"=============================================================================
" init.vim --- Entry file for neovim
" Copyright (c) 2016-2020 Wang Shidong & Contributors
" Author: Wang Shidong < wsdjeg@outlook.com >
" URL: https://spacevim.org
" License: GPLv3
"=============================================================================

" ============================ Before Load SpaceVim ==========================
execute 'source' fnamemodify(expand('<sfile>'), ':h').'/config/main.vim'
" ============================ After Load SpaceVim  ==========================

" ==================================
" CUSTOM: colorscheme After
" ==================================
if $DARKBG != ''
  set termguicolors
  let colorNr = localtime() % 5
  " let colorNr = 1
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
