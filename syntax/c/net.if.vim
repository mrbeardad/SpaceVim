let s:save_cpo = &cpo
set cpo&vim

if !exists('c_no_posix_struct')
  syntax keyword cPosixStruct if_nameindex
endif

if !exists('c_no_posix_constant')
  syntax keyword cPosixConstant IF_NAMESIZE
endif

if !exists('c_no_posix_function')
  syntax keyword cPosixFunction if_freenameindex
  syntax keyword cPosixFunction if_indextoname
  syntax keyword cPosixFunction if_nameindex
  syntax keyword cPosixFunction if_nametoindex
endif

let &cpo = s:save_cpo
unlet s:save_cpo

