"=============================================================================
" SpaceVim.vim --- default-plus colorscheme
" Copyright (c) 2020 Wang Shidong & Contributors
" Author: Heachen Bear < mrbeardad@qq.com >
" License: GPLv3
"=============================================================================

if v:version > 580
  hi clear
  if exists('syntax_on')
    syntax reset
  endif
endif

if !(has('termguicolors') && &termguicolors) && !has('gui_running') && &t_Co != 256
  " prevent change statuslines
  finish
else
  let g:colors_name='default-reduce'
endif


set notermguicolors
hi PmenuSel ctermbg=146
hi LineNr ctermfg=183
hi CursorLineNr ctermfg=195
hi NonText ctermfg=93
hi CursorLine ctermbg=243 cterm=none
hi Cursor ctermfg=black ctermbg=white

" #d7cfff   基佬紫
" #bfffff   基佬青
" #00dfd7   清山水彩
" #40ffff   蓝天彩靛
