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

" ALE针对clang-tidy进行周期启动
let g:ale_clangtidy_executable = get(g:, 'ale_cpp_clangtidy_executable', 'clang-tidy')
let g:ale_cpp_clangtidy_executable = g:ale_clangtidy_executable
let g:ale_clangtidy_period = get(g:, 'ale_clangtidy_period', 6)
let g:ale_lint_count = 0
function! ALE_Cnt()
  if g:ale_lint_count == 0
    let g:ale_cpp_clangtidy_executable = g:ale_clangtidy_executable
  else
    let g:ale_cpp_clangtidy_executable = 'echo'
  endif
  let g:ale_lint_count = (g:ale_lint_count + 1) % g:ale_clangtidy_period
endfunction

let g:quickrun_compileflag_extension_regex = get(g:, 'quickrun_compileflag_extension_regex', [])
let g:quickrun_compileflag_extension_flass = get(g:, 'quickrun_compileflag_extension_flags', [])
function! ALE_CHOPT()
  let cnter=0
  for ext_qr_cf_grep in g:quickrun_compileflag_extension_regex
    if execute('g/'.ext_qr_cf_grep.'/echo 1') =~# '1'
      let g:ale_cpp_cc_options = g:ale_cpp_cc_options.' '.g:quickrun_compileflag_extension_flags[cnter]
      let g:ale_cpp_clangtidy_options = g:ale_cpp_clangtidy_options.' '.g:quickrun_compileflag_extension_flags[cnter]
    endif
    let cnter+=1
  endfor
endfunction
au! InsertLeave *.cpp,*.hpp call ALE_CHOPT() | call ALE_Cnt()

