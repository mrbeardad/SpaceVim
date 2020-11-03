let s:save_cpo = &cpo
set cpo&vim

if !exists('c_no_posix_struct')
  syntax keyword cPosixStruct utsname
endif

if !exists('c_no_posix_function')
  syntax keyword cPosixFunction uname
endif

let &cpo = s:save_cpo
unlet s:save_cpo

