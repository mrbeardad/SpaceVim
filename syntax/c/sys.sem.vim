let s:save_cpo = &cpo
set cpo&vim

if !exists('c_no_posix_constant')
  syntax keyword cPosixConstant SEM_UNDO
  syntax keyword cPosixConstant GETNCNT
  syntax keyword cPosixConstant GETPID
  syntax keyword cPosixConstant GETVAL
  syntax keyword cPosixConstant GETALL
  syntax keyword cPosixConstant GETZCNT
  syntax keyword cPosixConstant SETVAL
  syntax keyword cPosixConstant SETALL
endif

if !exists('c_no_posix_struct')
  syntax keyword cPosixStruct semid_ds
  syntax keyword cPosixStruct sembuf
endif

if !exists('c_no_posix_function')
  syntax keyword cPosixFunction semctl
  syntax keyword cPosixFunction semget
  syntax keyword cPosixFunction semop
endif

let &cpo = s:save_cpo
unlet s:save_cpo

