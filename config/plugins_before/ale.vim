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

function! ALE_CHOPT()
  let src_file_path = expand('%:p')
  if !filereadable(src_file_path)
    return
  endif
  let exe_file_path = g:QuickRun_Tempdir . expand('%:t') .'.'. py3eval('time.strftime("%M:%H:%S", time.localtime(os.path.getmtime("'.expand('%:p').'")))').'.exe'
  let qr_cf = SpaceVim#plugins#quickrun#parse_flags(SpaceVim#plugins#quickrun#extend_compile_arguments(g:quickrun_default_flags[&ft].extRegex, g:quickrun_default_flags[&ft].extFlags), src_file_path, exe_file_path)
  let g:ale_cpp_cc_options = g:ale_cpp_cc_options.' '.qr_cf
  let g:ale_cpp_clangtidy_options = g:ale_cpp_clangtidy_options.' '.qr_cf
endfunction
au! InsertLeave *.cpp,*.hpp call ALE_CHOPT() | call ALE_Cnt()

