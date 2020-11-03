let s:save_cpo = &cpo
set cpo&vim

if !exists('c_no_posix_type')
  syntax keyword cPosixType nl_catd
  syntax keyword cPosixType nl_item
endif

if !exists('c_no_posix_constant')
  syntax keyword cPosixConstant NL_SETD
  syntax keyword cPosixConstant NL_CAT_LOCALE
endif

if !exists('c_no_posix_function')
  syntax keyword cPosixFunction catclose
  syntax keyword cPosixFunction catgets
  syntax keyword cPosixFunction catopen
endif

let &cpo = s:save_cpo
unlet s:save_cpo

