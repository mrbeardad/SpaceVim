let s:save_cpo = &cpo
set cpo&vim

if !exists('c_no_posix_struct')
  syntax keyword cPosixStruct passwd
endif

if !exists('c_no_posix_function')
  syntax keyword cPosixFunction endpwent
  syntax keyword cPosixFunction getpwent
  syntax keyword cPosixFunction getpwnam
  syntax keyword cPosixFunction getpwnam_r
  syntax keyword cPosixFunction getpwuid
  syntax keyword cPosixFunction getpwuid_r
  syntax keyword cPosixFunction setpwent
endif

let &cpo = s:save_cpo
unlet s:save_cpo

