let s:save_cpo = &cpo
set cpo&vim

if !exists('c_no_posix_struct')
  syntax keyword cPosixStruct statvfs
endif

if !exists('c_no_posix_constant')
  syntax keyword cPosixConstant ST_RDONLY
  syntax keyword cPosixConstant ST_NOSUID
endif

if !exists('c_no_posix_function')
  syntax keyword cPosixFunction fstatvfs
  syntax keyword cPosixFunction statvfs
endif

let &cpo = s:save_cpo
unlet s:save_cpo

