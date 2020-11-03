let s:save_cpo = &cpo
set cpo&vim

if !exists('c_no_posix_struct')
  syntax keyword cPosixStruct utmpx
endif

if !exists('c_no_posix_constant')
  syntax keyword cPosixConstant EMPTY
  syntax keyword cPosixConstant BOOT_TIME
  syntax keyword cPosixConstant OLD_TIME
  syntax keyword cPosixConstant NEW_TIME
  syntax keyword cPosixConstant USER_PROCESS
  syntax keyword cPosixConstant INIT_PROCESS
  syntax keyword cPosixConstant LOGIN_PROCESS
  syntax keyword cPosixConstant DEAD_PROCESS
endif

if !exists('c_no_posix_function')
  syntax keyword cPosixFunction endutxent
  syntax keyword cPosixFunction getutxent
  syntax keyword cPosixFunction getutxid
  syntax keyword cPosixFunction getutxline
  syntax keyword cPosixFunction pututxline
  syntax keyword cPosixFunction setutxent
endif

let &cpo = s:save_cpo
unlet s:save_cpo

