let s:save_cpo = &cpo
set cpo&vim

if !exists('c_no_posix_constant')
  syntax keyword cPosixConstant MM_HARD
  syntax keyword cPosixConstant MM_SOFT
  syntax keyword cPosixConstant MM_FIRM
  syntax keyword cPosixConstant MM_APPL
  syntax keyword cPosixConstant MM_UTIL
  syntax keyword cPosixConstant MM_OPSYS
  syntax keyword cPosixConstant MM_RECOVER
  syntax keyword cPosixConstant MM_NRECOV
  syntax keyword cPosixConstant MM_HALT
  syntax keyword cPosixConstant MM_ERROR
  syntax keyword cPosixConstant MM_WARNING
  syntax keyword cPosixConstant MM_INFO
  syntax keyword cPosixConstant MM_NOSEV
  syntax keyword cPosixConstant MM_PRINT
  syntax keyword cPosixConstant MM_CONSOLE
  syntax keyword cPosixConstant MM_NULLLBL
  syntax keyword cPosixConstant MM_NULLSEV
  syntax keyword cPosixConstant MM_NULLMC
  syntax keyword cPosixConstant MM_NULLTXT
  syntax keyword cPosixConstant MM_NULLACT
  syntax keyword cPosixConstant MM_NULLTAG
  syntax keyword cPosixConstant MM_OK
  syntax keyword cPosixConstant MM_NOTOK
  syntax keyword cPosixConstant MM_NOMSG
  syntax keyword cPosixConstant MM_NOCON
endif

if !exists('c_no_posix_function')
  syntax keyword cPosixFunction fmtmsg
endif

let &cpo = s:save_cpo
unlet s:save_cpo

