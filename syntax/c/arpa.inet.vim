let s:save_cpo = &cpo
set cpo&vim

if !exists('c_no_posix_function')
  syntax keyword cPosixFunction htonl
  syntax keyword cPosixFunction htons
  syntax keyword cPosixFunction ntohl
  syntax keyword cPosixFunction ntohs
  syntax keyword cPosixFunction inet_addr
  syntax keyword cPosixFunction inet_ntoa
  syntax keyword cPosixFunction inet_ntop
  syntax keyword cPosixFunction inet_pton
endif

let &cpo = s:save_cpo
unlet s:save_cpo

