let s:save_cpo = &cpo
set cpo&vim

if !exists('c_no_posix_struct')
  syntax keyword cPosixStruct timeval
  syntax keyword cPosixStruct itimerval
endif

if !exists('c_no_posix_constant')
  syntax keyword cPosixConstant ITIMER_REAL
  syntax keyword cPosixConstant ITIMER_VIRTUAL
  syntax keyword cPosixConstant ITIMER_PROF
endif

if !exists('c_no_posix_function')
  syntax keyword cPosixFunction getitimer
  syntax keyword cPosixFunction gettimeofday
  syntax keyword cPosixFunction setitimer
  syntax keyword cPosixFunction select
  syntax keyword cPosixFunction utimes
endif

let &cpo = s:save_cpo
unlet s:save_cpo

