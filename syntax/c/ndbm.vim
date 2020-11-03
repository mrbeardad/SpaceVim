let s:save_cpo = &cpo
set cpo&vim

if !exists('c_no_posix_type')
  syntax keyword cPosixType mqd_t
endif

if !exists('c_no_posix_struct')
  syntax keyword cPosixStruct mq_attr
endif

if !exists('c_no_posix_constant')
  syntax keyword cPosixConstant DBM_INSERT
  syntax keyword cPosixConstant DBM_REPLACE
endif

if !exists('c_no_posix_function')
  syntax keyword cPosixFunction mq_close
  syntax keyword cPosixFunction mq_getattr
  syntax keyword cPosixFunction mq_notify
  syntax keyword cPosixFunction mq_open
  syntax keyword cPosixFunction mq_receive
  syntax keyword cPosixFunction mq_send
  syntax keyword cPosixFunction mq_setattr
  syntax keyword cPosixFunction mq_timedreceive
  syntax keyword cPosixFunction mq_timedsend
  syntax keyword cPosixFunction mq_unlink
endif

let &cpo = s:save_cpo
unlet s:save_cpo

