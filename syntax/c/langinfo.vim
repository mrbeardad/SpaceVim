let s:save_cpo = &cpo
set cpo&vim

if !exists('c_no_posix_constant')
  syntax keyword cPosixConstant CODESET
  syntax keyword cPosixConstant D_T_FMT
  syntax keyword cPosixConstant D_FMT
  syntax keyword cPosixConstant T_FMT
  syntax keyword cPosixConstant T_FMT_AMPM
  syntax keyword cPosixConstant AM_STR
  syntax keyword cPosixConstant PM_STR
  syntax keyword cPosixConstant DAY_1
  syntax keyword cPosixConstant DAY_2
  syntax keyword cPosixConstant DAY_3
  syntax keyword cPosixConstant DAY_4
  syntax keyword cPosixConstant DAY_5
  syntax keyword cPosixConstant DAY_6
  syntax keyword cPosixConstant DAY_7
  syntax keyword cPosixConstant ABDAY_1
  syntax keyword cPosixConstant ABDAY_2
  syntax keyword cPosixConstant ABDAY_3
  syntax keyword cPosixConstant ABDAY_4
  syntax keyword cPosixConstant ABDAY_5
  syntax keyword cPosixConstant ABDAY_6
  syntax keyword cPosixConstant ABDAY_7
  syntax keyword cPosixConstant MON_1
  syntax keyword cPosixConstant MON_2
  syntax keyword cPosixConstant MON_3
  syntax keyword cPosixConstant MON_4
  syntax keyword cPosixConstant MON_5
  syntax keyword cPosixConstant MON_6
  syntax keyword cPosixConstant MON_7
  syntax keyword cPosixConstant MON_8
  syntax keyword cPosixConstant MON_9
  syntax keyword cPosixConstant MON_10
  syntax keyword cPosixConstant MON_11
  syntax keyword cPosixConstant MON_12
  syntax keyword cPosixConstant ABMON_1
  syntax keyword cPosixConstant ABMON_2
  syntax keyword cPosixConstant ABMON_3
  syntax keyword cPosixConstant ABMON_4
  syntax keyword cPosixConstant ABMON_5
  syntax keyword cPosixConstant ABMON_6
  syntax keyword cPosixConstant ABMON_7
  syntax keyword cPosixConstant ABMON_8
  syntax keyword cPosixConstant ABMON_9
  syntax keyword cPosixConstant ABMON_10
  syntax keyword cPosixConstant ABMON_11
  syntax keyword cPosixConstant ABMON_12
  syntax keyword cPosixConstant ERA
  syntax keyword cPosixConstant ERA_D_FMT
  syntax keyword cPosixConstant ERA_D_T_FMT
  syntax keyword cPosixConstant ERA_T_FMT
  syntax keyword cPosixConstant ALT_DIGITS
  syntax keyword cPosixConstant RADIXCHAR
  syntax keyword cPosixConstant THOUSEP
  syntax keyword cPosixConstant YESEXPR
  syntax keyword cPosixConstant NOEXPR
  syntax keyword cPosixConstant CRNCYSTR
endif

if !exists('c_no_posix_function')
  syntax keyword cPosixFunction nl_langinfo
  syntax keyword cPosixFunction nl_langinfo_l
endif

let &cpo = s:save_cpo
unlet s:save_cpo

