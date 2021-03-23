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

if &diff == 1
  set termguicolors
  colorscheme gruvbox
  finish
endif

let colorschemes = [
      \ 'SpaceVim',
      \ 'gruvbox',
      \ 'NeoSolarized',
      \ 'palenight',
      \ 'material',
      \]
if $DARKBG != ''
  set termguicolors
  if index(colorschemes, $DARKBG) > 0
    exe 'colorscheme '. $DARKBG
  else
    let colorNr = localtime() % 5
    " let colorNr = 4
    exe 'colorscheme '. colorschemes[colorNr]
  endif
endif
