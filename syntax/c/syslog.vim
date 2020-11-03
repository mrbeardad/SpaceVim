let s:save_cpo = &cpo
set cpo&vim

if !exists('c_no_posix_constant')
  syntax keyword cPosixConstant LOG_PID
  syntax keyword cPosixConstant LOG_CONS
  syntax keyword cPosixConstant LOG_NDELAY
  syntax keyword cPosixConstant LOG_ODELAY
  syntax keyword cPosixConstant LOG_NOWAIT
  syntax keyword cPosixConstant LOG_KERN
  syntax keyword cPosixConstant LOG_USER
  syntax keyword cPosixConstant LOG_MAIL
  syntax keyword cPosixConstant LOG_NEWS
  syntax keyword cPosixConstant LOG_UUCP
  syntax keyword cPosixConstant LOG_DAEMON
  syntax keyword cPosixConstant LOG_AUTH
  syntax keyword cPosixConstant LOG_CRON
  syntax keyword cPosixConstant LOG_LPR
  syntax keyword cPosixConstant LOG_LOCAL0
  syntax keyword cPosixConstant LOG_LOCAL1
  syntax keyword cPosixConstant LOG_LOCAL2
  syntax keyword cPosixConstant LOG_LOCAL3
  syntax keyword cPosixConstant LOG_LOCAL4
  syntax keyword cPosixConstant LOG_LOCAL5
  syntax keyword cPosixConstant LOG_LOCAL6
  syntax keyword cPosixConstant LOG_LOCAL7
  syntax keyword cPosixConstant LOG_EMERG
  syntax keyword cPosixConstant LOG_ALERT
  syntax keyword cPosixConstant LOG_CRIT
  syntax keyword cPosixConstant LOG_ERR
  syntax keyword cPosixConstant LOG_WARNING
  syntax keyword cPosixConstant LOG_NOTICE
  syntax keyword cPosixConstant LOG_INFO
  syntax keyword cPosixConstant LOG_DEBUG
endif

if !exists('c_no_posix_function')
  syntax keyword cPosixFunction closelog
  syntax keyword cPosixFunction openlog
  syntax keyword cPosixFunction setlogmask
  syntax keyword cPosixFunction syslog
  syntax keyword cPosixFunction LOG_MASK
endif

let &cpo = s:save_cpo
unlet s:save_cpo

