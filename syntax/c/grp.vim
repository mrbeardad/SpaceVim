let s:save_cpo = &cpo
set cpo&vim

if !exists('c_no_posix_struct')
  syntax keyword cPosixStruct group
endif

if !exists('c_no_posix_function')
  syntax keyword cPosixFunction endgrent
  syntax keyword cPosixFunction getgrent
  syntax keyword cPosixFunction getgrgid
  syntax keyword cPosixFunction getgrgid_r
  syntax keyword cPosixFunction getgrnam
  syntax keyword cPosixFunction getgrnam_r
  syntax keyword cPosixFunction setgrent
endif

let &cpo = s:save_cpo
unlet s:save_cpo

