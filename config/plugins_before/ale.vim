scriptencoding utf-8
let g:ale_sign_error = get(g:, 'spacevim_error_symbol', '✖')
let g:ale_sign_warning = get(g:,'spacevim_warning_symbol', '➤')
let g:ale_sign_info = get(g:,'spacevim_info_symbol', '🛈')
let g:ale_echo_msg_format = get(g:, 'ale_echo_msg_format', '%severity%: %linter%: %s')
let g:ale_lint_on_save = get(g:, 'spacevim_lint_on_save', 1)

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

let g:ale_cpp_clangtidy_executable = '/opt/bin/nop.sh'
let s:ale_lint_count = 0
let g:ale_clangtidy_period = get(g:, 'ale_clangtidy_period', 6)
function! ALE_Cnt()
  if s:ale_lint_count == 0
    let g:ale_cpp_clangtidy_executable = '/bin/clang-tidy'
  else
    let g:ale_cpp_clangtidy_executable = 'nop.sh'
  endif
  let s:ale_lint_count = (s:ale_lint_count + 1) % g:ale_clangtidy_period
endfunction
au InsertLeave *.cpp call ALE_Cnt()
