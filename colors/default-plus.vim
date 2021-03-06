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
  let g:colors_name='default-plus'
endif


hi Pmenu guifg=#c0c0c0 guibg=#404080
hi PmenuSel guifg=#c0c0c0 guibg=#2050d0
hi PmenuSbar guifg=blue guibg=darkgray
hi PmenuThumb guifg=#c0c0c0
hi LineNr guifg=#d7daff
hi CursorLineNr guifg=#d7ffff
hi MoreMsg  guifg=springgreen
hi Question guifg=springgreen
hi NonText guifg=blue
hi CursorLine guibg=Grey25
hi Cursor guibg=#ffffff

" #d7cfff   基佬紫
" #bfffff   基佬青
" #00dfd7   清山水彩
" #40ffff   蓝天彩靛
