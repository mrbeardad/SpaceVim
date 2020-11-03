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
  finish
else
  let g:colors_name='default-reduce'
endif


set notermguicolors
hi PmenuSel ctermbg=146
hi LineNr ctermfg=183
hi CursorLineNr ctermfg=195
hi NonText ctermfg=97
hi CursorLine ctermbg=black cterm=none
hi Cursor ctermfg=black ctermbg=white
hi Comment ctermfg=99
hi DiffAdd ctermbg=33
hi DiffChange ctermbg=141
hi DiffText ctermbg=200
hi Special ctermfg=217
hi SignColumn ctermbg=none

