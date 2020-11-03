let s:save_cpo = &cpo
set cpo&vim

if !exists('c_no_posix_struct')
  syntax keyword cPosixStruct glob_t
endif

if !exists('c_no_posix_constant')
  syntax keyword cPosixConstant GLOB_APPEND
  syntax keyword cPosixConstant GLOB_DOOFFS
  syntax keyword cPosixConstant GLOB_ERR
  syntax keyword cPosixConstant GLOB_MARK
  syntax keyword cPosixConstant GLOB_NOCHECK
  syntax keyword cPosixConstant GLOB_NOESCAPE
  syntax keyword cPosixConstant GLOB_NOSORT
  syntax keyword cPosixConstant GLOB_ABORTED
  syntax keyword cPosixConstant GLOB_NOMATCH
  syntax keyword cPosixConstant GLOB_NOSPACE
endif

if !exists('c_no_posix_function')
  syntax keyword cPosixFunction glob
  syntax keyword cPosixFunction globfree
endif

let &cpo = s:save_cpo
unlet s:save_cpo

