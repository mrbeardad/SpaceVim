let s:save_cpo = &cpo
set cpo&vim

if !exists('c_no_posix_struct')
  syntax keyword cPosixStruct sem_t
endif

if !exists('c_no_posix_constant')
  syntax keyword cPosixConstant SEM_FAILED
endif

if !exists('c_no_posix_function')
  syntax keyword cPosixFunction sem_close
  syntax keyword cPosixFunction sem_destroy
  syntax keyword cPosixFunction sem_getvalue
  syntax keyword cPosixFunction sem_init
  syntax keyword cPosixFunction sem_open
  syntax keyword cPosixFunction sem_post
  syntax keyword cPosixFunction sem_timedwait
  syntax keyword cPosixFunction sem_trywait
  syntax keyword cPosixFunction sem_unlink
  syntax keyword cPosixFunction sem_wait
endif

let &cpo = s:save_cpo
unlet s:save_cpo

