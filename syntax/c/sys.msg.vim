let s:save_cpo = &cpo
set cpo&vim

if !exists('c_no_posix_type')
  syntax keyword cPosixType msgqnum_t
  syntax keyword cPosixType msglen_t
endif

if !exists('c_no_posix_constant')
  syntax keyword cPosixConstant MSG_NOERROR
endif

if !exists('c_no_posix_struct')
  syntax keyword cPosixStruct msqid_ds
endif

if !exists('c_no_posix_function')
  syntax keyword cPosixFunction msgctl
  syntax keyword cPosixFunction msgget
  syntax keyword cPosixFunction msgrcv
  syntax keyword cPosixFunction msgsnd
endif

let &cpo = s:save_cpo
unlet s:save_cpo

