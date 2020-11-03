let s:save_cpo = &cpo
set cpo&vim

if !exists('c_no_posix_constant')
  syntax keyword cPosixConstant SHM_RDONLY
  syntax keyword cPosixConstant SHM_RND
  syntax keyword cPosixConstant SHMLBA
endif

if !exists('c_no_posix_type')
  syntax keyword cPosixType shmatt_t
endif

if !exists('c_no_posix_struct')
  syntax keyword cPosixStruct shmid_ds
endif

if !exists('c_no_posix_function')
  syntax keyword cPosixFunction shmat
  syntax keyword cPosixFunction shmctl
  syntax keyword cPosixFunction shmdt
  syntax keyword cPosixFunction shmget
endif

let &cpo = s:save_cpo
unlet s:save_cpo

