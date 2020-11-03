let s:save_cpo = &cpo
set cpo&vim

if !exists('c_no_posix_struct')
  syntax keyword cPosixStruct sched_param
endif

if !exists('c_no_posix_constant')
  syntax keyword cPosixConstant SCHED_FIFO
  syntax keyword cPosixConstant SCHED_RR
  syntax keyword cPosixConstant SCHED_SPORADIC
  syntax keyword cPosixConstant SCHED_OTHER
endif

if !exists('c_no_posix_function')
  syntax keyword cPosixFunction sched_get_priority_max
  syntax keyword cPosixFunction sched_get_priority_min
  syntax keyword cPosixFunction sched_getparam
  syntax keyword cPosixFunction sched_getscheduler
  syntax keyword cPosixFunction sched_rr_get_interval
  syntax keyword cPosixFunction sched_setparam
  syntax keyword cPosixFunction sched_setscheduler
  syntax keyword cPosixFunction sched_yield
endif

let &cpo = s:save_cpo
unlet s:save_cpo

