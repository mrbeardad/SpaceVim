let s:save_cpo = &cpo
set cpo&vim

if !exists('c_no_posix_struct')
  syntax keyword cPosixStruct tms
endif

if !exists('c_no_posix_function')
  syntax keyword cPosixFunction times
endif

let &cpo = s:save_cpo
unlet s:save_cpo

