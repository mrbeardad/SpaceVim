"=============================================================================
" init.vim --- Entry file for neovim
" Copyright (c) 2016-2022 Wang Shidong & Contributors
" Author: Wang Shidong < wsdjeg@outlook.com >
" URL: https://spacevim.org
" License: GPLv3
"=============================================================================

" ============================ Before Load SpaceVim ==========================
execute 'source' fnamemodify(expand('<sfile>'), ':h').'/main.vim'
" ============================ After Load SpaceVim  ==========================

" color schemes
set termguicolors
let s:colorschemes = [
      \ 'SpaceVim',
      \ 'gruvbox',
      \ 'NeoSolarized',
      \ 'palenight',
      \ 'material',
      \]
if &diff == 1
  colorscheme gruvbox
elseif $DARKBG !=# ''
  if index(s:colorschemes, $DARKBG) > 0
    exe 'colorscheme '. $DARKBG
  else
    exe 'colorscheme '. s:colorschemes[localtime() % 5]
  endif
endif
