" default-plus.vim is based on default.vim ,it provide a better looks if you
" like to use vim in transparent terminal

if v:version > 580
  hi clear
  if exists('syntax_on')
    syntax reset
  endif
endif

if !(has('termguicolors') && &termguicolors) && !has('gui_running') && &t_Co != 256
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

" #d7cfff   基佬紫
" #bfffff   基佬青
" #00dfd7   清山水彩
" #40ffff   蓝天彩靛
