let s:save_cpo = &cpo
set cpo&vim

if !exists('c_no_posix_constant')
  syntax keyword cPosixConstant PRIO_PROCESS
  syntax keyword cPosixConstant PRIO_PGRP
  syntax keyword cPosixConstant PRIO_USER
  syntax keyword cPosixConstant RLIM_INFINITY
  syntax keyword cPosixConstant RLIM_SAVED_MAX
  syntax keyword cPosixConstant RLIM_SAVED_CUR
  syntax keyword cPosixConstant RUSAGE_SELF
  syntax keyword cPosixConstant RUSAGE_CHILDREN
  syntax keyword cPosixConstant RLIMIT_CORE
  syntax keyword cPosixConstant RLIMIT_CPU
  syntax keyword cPosixConstant RLIMIT_DATA
  syntax keyword cPosixConstant RLIMIT_FSIZE
  syntax keyword cPosixConstant RLIMIT_NOFILE
  syntax keyword cPosixConstant RLIMIT_STACK
  syntax keyword cPosixConstant RLIMIT_AS
endif

if !exists('c_no_posix_type')
  syntax keyword cPosixType rlim_t
endif

if !exists('c_no_posix_struct')
  syntax keyword cPosixStruct rlimit
  syntax keyword cPosixStruct rusage
endif

if !exists('c_no_posix_function')
  syntax keyword cPosixFunction getpriority
  syntax keyword cPosixFunction getrlimit
  syntax keyword cPosixFunction getrusage
  syntax keyword cPosixFunction setpriority
  syntax keyword cPosixFunction setrlimit
endif

let &cpo = s:save_cpo
unlet s:save_cpo

