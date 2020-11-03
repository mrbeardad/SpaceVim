let s:save_cpo = &cpo
set cpo&vim

if !exists('c_no_posix_constant')
  syntax keyword cPosixConstant FNM_NOMATCH
  syntax keyword cPosixConstant FNM_PATHNAME
  syntax keyword cPosixConstant FNM_PERIOD
  syntax keyword cPosixConstant FNM_NOESCAPE
endif

if !exists('c_no_posix_function')
  syntax keyword cPosixFunction fnmatch
endif

let &cpo = s:save_cpo
unlet s:save_cpo

