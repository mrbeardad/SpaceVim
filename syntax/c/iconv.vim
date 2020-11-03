let s:save_cpo = &cpo
set cpo&vim

if !exists('c_no_posix_type')
  syntax keyword cPosixType iconv_t
endif

if !exists('c_no_posix_function')
  syntax keyword cPosixFunction iconv
  syntax keyword cPosixFunction iconv_close
  syntax keyword cPosixFunction iconv_open
endif

let &cpo = s:save_cpo
unlet s:save_cpo

