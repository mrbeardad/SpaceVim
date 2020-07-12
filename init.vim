let g:ale_clangtidy_period = 6

"=============================  Load SpaceVim ===============================
execute 'source' fnamemodify(expand('<sfile>'), ':h').'/config/main.vim'
"=============================== After Load =================================

" QuickRun
let g:cpp_default_compile_flag = '-std=c++20 '
let g:c_default_compile_flag = '-std=c11 '

" ALE
let g:ale_cpp_std = '-std=c++20'
let g:ale_cpp_clangtidy_checks = ['*',
      \ '-abseil*',
      \ '-android*',
      \ '-darwin*',
      \ '-fuchsia*',
      \ '-linuxkernel*',
      \ '-*osx*',
      \ '-*objc*',
      \ '-openmp*',
      \ '-zircon*',
      \ '-*avoid-c-arrays',
      \ '-modernize-use-trailing-return-type',
      \ '-cppcoreguidelines-pro-bounds-constant-array-index',
      \ '-readability-isolate-declaration',
      \ ]

" Translator
let g:translator_default_engines = ['bing']

" Colorscheme
if $DARKBG != ''
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

" Terminal Color
let terminal_color_1 = '#ff5555'
let terminal_color_2 = '#50fa7b'
let terminal_color_3 = '#fabd2f'
let terminal_color_4 = '#bd93f9'
let terminal_color_5 = '#ff79c6'
let terminal_color_6 = '#8be9fd'
let terminal_color_7 = '#bfffff'

" path
set path+=/usr/include/c++/*/,/usr/include/boost/,.

