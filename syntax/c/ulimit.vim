let s:save_cpo = &cpo
set cpo&vim

if !exists('c_no_posix_constant')
  syntax keyword cPosixConstant UL_GETFSIZE
  syntax keyword cPosixConstant UL_SETFSIZE
endif

if !exists('c_no_posix_function')
  syntax keyword cPosixFunction ulimit
endif

let &cpo = s:save_cpo
unlet s:save_cpo

