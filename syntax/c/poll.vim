let s:save_cpo = &cpo
set cpo&vim

if !exists('c_no_posix_struct')
  syntax keyword cPosixStruct pollfd
endif

if !exists('c_no_posix_type')
  syntax keyword cPosixType nfds_t
endif

if !exists('c_no_posix_constant')
  syntax keyword cPosixConstant POLLINData
  syntax keyword cPosixConstant POLLRDNORMNormal
  syntax keyword cPosixConstant POLLRDBANDPriority
  syntax keyword cPosixConstant POLLPRIHigh
  syntax keyword cPosixConstant POLLOUTNormal
  syntax keyword cPosixConstant POLLWRNORMEquivalent
  syntax keyword cPosixConstant POLLWRBANDPriority
  syntax keyword cPosixConstant POLLERRAn
  syntax keyword cPosixConstant POLLHUPDevice
  syntax keyword cPosixConstant POLLNVALInvalid
endif

if !exists('c_no_posix_function')
  syntax keyword cPosixFunction poll
endif

let &cpo = s:save_cpo
unlet s:save_cpo

