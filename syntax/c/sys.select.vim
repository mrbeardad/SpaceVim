let s:save_cpo = &cpo
set cpo&vim

if !exists('c_no_posix_struct')
  syntax keyword cPosixStruct timeval
  syntax keyword cPosixStruct fd_set
endif

if !exists('c_no_posix_constant')
  syntax keyword cPosixConstant FD_SETSIZE
endif

if !exists('c_no_posix_function')
  syntax keyword cPosixFunction FD_CLR
  syntax keyword cPosixFunction FD_ISSET
  syntax keyword cPosixFunction FD_SET
  syntax keyword cPosixFunction FD_ZERO
  syntax keyword cPosixFunction pselect
  syntax keyword cPosixFunction select
endif

let &cpo = s:save_cpo
unlet s:save_cpo

