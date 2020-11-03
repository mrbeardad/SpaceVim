let s:save_cpo = &cpo
set cpo&vim

if !exists('c_no_posix_struct')
  syntax keyword cPosixStruct ipc_perm
endif

if !exists('c_no_posix_type')
  syntax keyword cPosixConstant IPC_CREAT
  syntax keyword cPosixConstant IPC_EXCL
  syntax keyword cPosixConstant IPC_NOWAIT
  syntax keyword cPosixConstant IPC_PRIVATE
  syntax keyword cPosixConstant IPC_RMID
  syntax keyword cPosixConstant IPC_SET
  syntax keyword cPosixConstant IPC_STAT
endif

if !exists('c_no_posix_function')
  syntax keyword cPosixFunction ftok
endif

let &cpo = s:save_cpo
unlet s:save_cpo

