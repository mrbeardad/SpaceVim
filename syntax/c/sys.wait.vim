let s:save_cpo = &cpo
set cpo&vim

if !exists('c_no_posix_constant')
  syntax keyword cPosixConstant WCONTINUED
  syntax keyword cPosixConstant WNOHANG
  syntax keyword cPosixConstant WUNTRACED
  syntax keyword cPosixConstant WEXITED
  syntax keyword cPosixConstant WNOWAIT
  syntax keyword cPosixConstant WSTOPPED
endif

if !exists('c_no_posix_enum')
  syntax keyword cPosixEnum idtype_t
endif

if !exists('c_no_posix_enum_constant')
  " enum idtype_t
  syntax keyword cPosixEnumConstant P_ALL
  syntax keyword cPosixEnumConstant P_GID
  syntax keyword cPosixEnumConstant P_PID
endif

if !exists('c_no_posix_function')
  syntax keyword cPosixFunction wait
  syntax keyword cPosixFunction waitid
  syntax keyword cPosixFunction waitpid
  syntax keyword cPosixFunction WEXITSTATUS
  syntax keyword cPosixFunction WIFCONTINUED
  syntax keyword cPosixFunction WIFEXITED
  syntax keyword cPosixFunction WIFSIGNALED
  syntax keyword cPosixFunction WIFSTOPPED
  syntax keyword cPosixFunction WSTOPSIG
  syntax keyword cPosixFunction WTERMSIG
endif

let &cpo = s:save_cpo
unlet s:save_cpo

