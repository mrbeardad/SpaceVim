scriptencoding utf-8
let g:ale_sign_error = get(g:, 'spacevim_error_symbol', '❌') " ✗
let g:ale_sign_warning = get(g:,'spacevim_warning_symbol', '⚡') " ➤
let g:ale_sign_info = get(g:,'spacevim_info_symbol', '‼')
let g:ale_echo_msg_format = get(g:, 'ale_echo_msg_format', '[%linter%] %s  [%severity%]')
let g:ale_lint_on_save = get(g:, 'spacevim_lint_on_save', 0)

if g:spacevim_colorscheme ==# 'gruvbox'
  highlight link ALEErrorSign GruvboxRedSign
  highlight link ALEWarningSign GruvboxYellowSign
endif

if g:spacevim_lint_on_the_fly
  let g:ale_lint_on_text_changed = 'always'
  let g:ale_lint_delay = 750
else
  let g:ale_lint_on_text_changed = 'never'
endif

let ale_cpp_std = get(g:, 'ale_cpp_std', '-std=c++17')
let g:ale_linters = {
      \   'cpp': ['cppcheck', 'gcc', 'clangtidy'],
      \   'c': ['gcc', 'cppcheck'],
      \   'sh': ['shellcheck'],
      \   'python': ['flake8', 'pylint'],
      \}
let g:ale_linters_explicit = 1
let g:ale_sign_column_always = 1
let g:ale_disable_lsp = 1
let g:ale_completion_enabled = 0
let g:ale_set_highlights = 1
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 1
let g:ale_lint_on_enter = 0
let g:ale_lint_on_save = 0
let g:ale_cpp_gcc_options = '-Wall -Wextra -O2 -I. '. g:ale_cpp_std
let g:ale_cpp_cppcheck_options = '--inconclusive --enable=warning,style,performance,portability -'.g:ale_cpp_std
let g:ale_cpp_clangtidy_options = g:ale_cpp_std.' -I. '
" let g:ale_cpp_clangtidy_options = '-extra-arg="-Weverything -Wno-c++98-compat -Wno-c++98-compat-pedantic -Wno-pedantic -Wno-missing-prototypes -Wno-padded -Wno-old-style-cast -O2 '.g:ale_and_quickrun_cpp_compile_std.'"'
let g:ale_echo_msg_error_str = '❌'
let g:ale_echo_msg_warning_str = '⚡'
hi! clear SpellBad
hi! clear SpellCap
hi! clear SpellRare
hi! SpellBad gui=undercurl guisp=red
hi! SpellCap gui=undercurl guisp=yellow
hi! SpellRare gui=undercurl guisp=magenta

" ALE针对clang-tidy进行周期启动
let g:ale_cpp_clangtidy_executable = '/opt/bin/nop.sh'
let g:ale_clangtidy_period = get(g:, 'ale_clangtidy_period', 6)
let s:ale_lint_count = 0
function! ALE_Cnt()
  if s:ale_lint_count == 0
    let g:ale_cpp_clangtidy_executable = '/bin/clang-tidy'
  else
    let g:ale_cpp_clangtidy_executable = 'nop.sh'
  endif
  let s:ale_lint_count = (s:ale_lint_count + 1) % g:ale_clangtidy_period
endfunction
au InsertLeave *.cpp,*.hpp call ALE_Cnt()

let g:quickrun_compileflag_extension_regex = get(g:, 'quickrun_compileflag_extension_regex', [])
let g:quickrun_compileflag_extension_flass = get(g:, 'quickrun_compileflag_extension_flags', [])
function! ALE_CHOPT()
  let cnter=0
  for ext_qr_cf_grep in g:quickrun_compileflag_extension_regex
    if execute('g/'.ext_qr_cf_grep.'/echo 1') =~ 1
      let g:ale_cpp_gcc_options = g:ale_cpp_gcc_options.' '.g:quickrun_compileflag_extension_flags[cnter]
      let g:ale_cpp_clangtidy_options = g:ale_cpp_gcc_options.' '.g:quickrun_compileflag_extension_flags[cnter]
    endif
    let cnter+=1
  endfor
endfunction
au! InsertLeave *.cpp call ALE_CHOPT()

