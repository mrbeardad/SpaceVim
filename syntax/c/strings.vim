let s:save_cpo = &cpo
set cpo&vim

if !exists('c_no_posix_function')
  syntax keyword cPosixFunction ffs
  syntax keyword cPosixFunction strcasecmp
  syntax keyword cPosixFunction strcasecmp_l
  syntax keyword cPosixFunction strncasecmp
  syntax keyword cPosixFunction strncasecmp_l
endif

let &cpo = s:save_cpo
unlet s:save_cpo

