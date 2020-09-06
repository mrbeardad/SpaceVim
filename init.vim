let g:disable_quickrun = 0
let g:quickrun_disable_auto_launch_gdb = 0
let g:quickrun_cpp_default_compile_flag = '-std=c++17 '
let g:quickrun_c_default_compile_flag = '-std=c11 '
let g:quickrun_compileflag_extension_regex =[
      \ '^\#include\s*<future>',
      \ '^\#include\s*<mysql++\/mysql++.h>'
      \ ]
let g:quickrun_compileflag_extension_flags = [
      \ '-lpthread',
      \ '-I/usr/include/mysql -lmysqlpp'
      \ ]

let g:ycm_filetype_whitelist = {
      \ "c":1,
      \ "cpp":1,
      \ "java":1,
      \ "python":1,
      \ "vim":1,
      \ "sh":1,
      \ }
let g:ycm_semantic_triggers =  {
      \ "c,cpp,python,java,vim,sh": ['re!\w{2}'],
      \ }
let g:ycm_clangd_args = [ '--header-insertion=never' ]

let g:translator_default_engines = ['bing']

let g:ale_linters = {
      \   'cpp': ['cppcheck', 'gcc', 'clangtidy'],
      \   'c': ['gcc', 'cppcheck'],
      \   'sh': ['shellcheck'],
      \   'python': ['flake8', 'pylint'],
      \}
"=============================  Load SpaceVim ===============================
execute 'source' fnamemodify(expand('<sfile>'), ':h').'/config/main.vim'
"=============================== After Load =================================

let g:ale_cpp_std = '-std=c++17'
let g:ale_linters_explicit = 1
let g:ale_sign_column_always = 1
let g:ale_disable_lsp = 1
let g:ale_completion_enabled = 0
let g:ale_set_highlights = 1
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 1
let g:ale_lint_on_enter = 0
let g:ale_lint_on_save = 0
let g:ale_cpp_cc_executable = 'gcc'
let g:ale_cpp_cc_options = '-Wall -Wextra -O2 -I. ' . g:ale_cpp_std
let g:ale_cpp_cppcheck_options = '--inconclusive --enable=warning,style,performance,portability -'.g:ale_cpp_std
let g:ale_cpp_clangtidy_options = ' -I. ' . g:ale_cpp_std
" let g:ale_cpp_clangtidy_options = '-extra-arg="-Weverything -Wno-c++98-compat -Wno-c++98-compat-pedantic -Wno-pedantic -Wno-missing-prototypes -Wno-padded -Wno-old-style-cast -O2 '.g:ale_and_quickrun_cpp_compile_std.'"'
let g:ale_clangtidy_period = 6
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
      \ '-readability-isolate-declaration',
      \ ]

let g:ale_sign_error = ' '
let g:ale_sign_warning = ' '
let g:ale_sign_info = ' '
let g:ale_echo_msg_error_str = 'Error'
let g:ale_echo_msg_warning_str = 'Warning'
let g:ale_echo_msg_info_str = 'Info'

set path+=/usr/include/c++/*/,/usr/include/boost/,/usr/include/mysql++/,.

if $DARKBG != ''
  let colorNr = localtime() % 5
  if colorNr == 0
    colorscheme SpaceVim
    hi! CursorLineNr gui=bold guifg=#df5fdf
    hi! CursorLine guibg=#363636
    hi! LineNr guifg=#6c6c6c
    hi! Constant guifg=#af00ee
    hi! Boolean guifg=#af00ee
    hi! Structure guifg=#bd93f9
    hi! StorageClass guifg=#47d0ff
    hi! Comment gui=italic guifg=#007f7f
    hi! String gui=italic guifg=#00dfd7
    hi! Statement guifg=#ff5f87
    hi! Repeat guifg=#ff5f87
    hi! Conditional guifg=#ff5f87
    hi! Label guifg=#ff5f87
    hi! MatchParen gui=bold
    hi! Operator gui=bold
    hi! Function gui=bold guifg=#df5faf
    hi! Type guifg=#ffafdf
    hi! Typedef guifg=#ffafdf
  elseif colorNr == 1  && &rtp =~ 'gruvbox'
    colorscheme gruvbox
    hi! CursorLineNr gui=bold
    hi! GruvboxYellow gui=italic
  elseif colorNr == 2  && &rtp =~ 'NeoSolarized'
    colorscheme NeoSolarized
    hi! NonText guifg=#596364
    hi! Normal guifg=#a5b4b4
    hi! CursorLineNr gui=bold guifg=#2aa198
    hi! CursorLine guibg=#2c4b53
    hi! Operator gui=bold guifg=#8787af
    hi! Structure guifg=#5fafd7
    hi! StorageClass guifg=#d78700
    hi! Function gui=bold guifg=#268bd2
    hi! Type gui=italic
    hi! String gui=italic guifg=#2aa198
  elseif colorNr == 3  && &rtp =~ 'palenight.vim'
    colorscheme palenight
    hi! CursorLine guibg=#3c4658
    hi! CursorLineNr gui=bold
    hi! Structure guifg=#00dfd7
    hi! StorageClass guifg=#87ff00
    hi! StorageClass guifg=#c3e88d
    hi! Operator gui=bold
    hi! MatchParen gui=bold
    hi! Constant guifg=#ff5370
    hi! Function gui=bold guifg=#82b1ff
    hi! Typedef gui=italic guifg=#ffcb6b
    hi! Type gui=italic guifg=#ffcb6b
    hi! String gui=italic guifg=#c3e88d
  elseif colorNr == 4  && &rtp =~ 'vim-material'
    colorscheme material
    hi! Normal guifg=#ccdddd
    hi! Search gui=underline guifg=#cfffff
    hi! SignColumn guibg=#374349
    hi! Error guibg=#374349
    hi! ALEWarningSign guibg=#374349
    hi! Pmenu guifg=#cfffff
    hi! Structure guifg=#00dfd7
    hi! StorageClass guifg=#bd93f9
    hi! MatchParen gui=bold
    hi! Operator gui=bold
    hi! Function gui=bold guifg=#82aaff
    hi! Type gui=italic guifg=#ffcb6b
    hi! String gui=italic guifg=#c3e88d
  endif
else
  colorscheme default-plus
endif

if $WSL_DISTRO_NAME != ''
  " WSL访问Windows剪切板，需要下载一个小工具
  " https://github.com/neovim/neovim/wiki/FAQ#how-to-use-the-windows-clipboard-from-wsl

  " Windows Terminal暂时还不支持undercurl，且无法回滚为underline
  hi! SpellBad gui=underline
  hi! SpellCap gui=underline
  hi! SpellRare gui=underline
else
  hi! SpellBad gui=undercurl guisp=red
  hi! SpellCap gui=undercurl guisp=yellow
  hi! SpellRare gui=undercurl guisp=magenta
endif

" Terminal Color
" let terminal_color_1 = '#ff5555'
" let terminal_color_2 = '#50fa7b'
" let terminal_color_3 = '#fabd2f'
" let terminal_color_4 = '#bd93f9'
" let terminal_color_5 = '#ff79c6'
" let terminal_color_6 = '#8be9fd'
" let terminal_color_7 = '#bfffff'
