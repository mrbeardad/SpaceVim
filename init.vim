let g:ale_and_quickrun_cpp_default_compile_flag = '-std=c++20'
let g:ale_clangtidy_period = 6
let g:ale_cpp_clangtidy_checks = ['*',
      \ '-android-*',
      \ '-fuchsia-*',
      \ '-*osx*',
      \ '-abseil*',
      \ '-*-avoid-c-arrays',
      \ '-google-build-using-namespace',
      \ '-google-readability-casting',
      \ '-google-runtime-references',
      \ '-llvm-include-order',
      \ '-cppcoreguidelines-pro-bounds-constant-array-index',
      \ '-cppcoreguidelines-narrowing-conversions',
      \ '-readability-magic-numbers',
      \ '-readability-isolate-declaration',
      \ '-misc-non-private-member-variables-in-classes',
      \ '-modernize-use-trailing-return-type']

execute 'source' fnamemodify(expand('<sfile>'), ':h').'/config/main.vim'

if $COLORBG != ''
  if localtime() % 2 == 1  && &rtp =~ 'NeoSolarized'
    colorscheme NeoSolarized
    hi! Function gui=bold guifg=#268bd2
    hi! NonText guifg=#596364
    hi! String gui=italic guifg=#2aa198
    hi! CursorLineNr gui=bold guifg=#2aa198
    hi! CursorLine guibg=#2c4b53
    hi! Normal guifg=#a5b4b4
    hi! Type gui=italic
  else
    colorscheme gruvbox
    hi! CursorLineNr gui=bold
    hi! GruvboxYellow gui=italic
  endif
else
    colorscheme default-plus
endif

let terminal_color_1 = '#ff5555'
let terminal_color_2 = '#50fa7b'
let terminal_color_3 = '#fabd2f'
let terminal_color_4 = '#bd93f9'
let terminal_color_5 = '#ff79c6'
let terminal_color_6 = '#8be9fd'
let terminal_color_7 = '#bfffff'
au VimEnter * iunmap <c-g>%
