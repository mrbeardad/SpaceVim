let s:save_cpo = &cpo
set cpo&vim

if !exists('c_no_posix_struct')
  syntax keyword cPosixStruct iovec
endif

if !exists('c_no_posix_function')
  syntax keyword cPosixFunction readv
  syntax keyword cPosixFunction writev
endif

let &cpo = s:save_cpo
unlet s:save_cpo

