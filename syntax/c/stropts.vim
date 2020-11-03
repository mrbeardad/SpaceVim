let s:save_cpo = &cpo
set cpo&vim

if !exists('c_no_posix_struct')
  syntax keyword cPosixStruct bandinfo
  syntax keyword cPosixStruct strpeek
  syntax keyword cPosixStruct strbuf
  syntax keyword cPosixStruct strfdinsert
  syntax keyword cPosixStruct strioctl
  syntax keyword cPosixStruct strrecvfd
  syntax keyword cPosixStruct str_list
  syntax keyword cPosixStruct str_mlist
endif

if !exists('c_no_posix_type')
  syntax keyword cPosixType t_scalar_t
  syntax keyword cPosixType t_uscalar_t
endif

if !exists('c_no_posix_constant')
  syntax keyword cPosixConstant I_ATMARK
  syntax keyword cPosixConstant I_CANPUT
  syntax keyword cPosixConstant I_CKBAND
  syntax keyword cPosixConstant I_FDINSERT
  syntax keyword cPosixConstant I_FIND
  syntax keyword cPosixConstant I_FLUSH
  syntax keyword cPosixConstant I_FLUSHBAND
  syntax keyword cPosixConstant I_GETBAND
  syntax keyword cPosixConstant I_GETCLTIME
  syntax keyword cPosixConstant I_GETSIG
  syntax keyword cPosixConstant I_GRDOPT
  syntax keyword cPosixConstant I_GWROPT
  syntax keyword cPosixConstant I_LINK
  syntax keyword cPosixConstant I_LIST
  syntax keyword cPosixConstant I_LOOK
  syntax keyword cPosixConstant I_NREAD
  syntax keyword cPosixConstant I_PEEK
  syntax keyword cPosixConstant I_PLINK
  syntax keyword cPosixConstant I_POP
  syntax keyword cPosixConstant I_PUNLINK
  syntax keyword cPosixConstant I_PUSH
  syntax keyword cPosixConstant I_RECVFD
  syntax keyword cPosixConstant I_SENDFD
  syntax keyword cPosixConstant I_SETCLTIME
  syntax keyword cPosixConstant I_SETSIG
  syntax keyword cPosixConstant I_SRDOPT
  syntax keyword cPosixConstant I_STR
  syntax keyword cPosixConstant I_SWROPT
  syntax keyword cPosixConstant I_UNLINK
  syntax keyword cPosixConstant FMNAMESZ
  syntax keyword cPosixConstant FLUSHR
  syntax keyword cPosixConstant FLUSHRW
  syntax keyword cPosixConstant FLUSHW
  syntax keyword cPosixConstant S_BANDURG
  syntax keyword cPosixConstant S_ERROR
  syntax keyword cPosixConstant S_HANGUP
  syntax keyword cPosixConstant S_HIPRI
  syntax keyword cPosixConstant S_INPUT
  syntax keyword cPosixConstant S_MSG
  syntax keyword cPosixConstant S_OUTPUT
  syntax keyword cPosixConstant S_RDBAND
  syntax keyword cPosixConstant S_RDNORM
  syntax keyword cPosixConstant S_WRBAND
  syntax keyword cPosixConstant S_WRNORM
  syntax keyword cPosixConstant RS_HIPRI
  syntax keyword cPosixConstant RMSGD
  syntax keyword cPosixConstant RMSGN
  syntax keyword cPosixConstant RNORM
  syntax keyword cPosixConstant RPROTDAT
  syntax keyword cPosixConstant RPROTDIS
  syntax keyword cPosixConstant RPROTNORM
  syntax keyword cPosixConstant SNDZERO
  syntax keyword cPosixConstant ANYMARK
  syntax keyword cPosixConstant LASTMARK
  syntax keyword cPosixConstant MUXID_ALL
  syntax keyword cPosixConstant MORECTL
  syntax keyword cPosixConstant MOREDATA
  syntax keyword cPosixConstant MSG_ANY
  syntax keyword cPosixConstant MSG_BAND
  syntax keyword cPosixConstant MSG_HIPRI
endif

if !exists('c_no_posix_function')
  syntax keyword cPosixFunction fattach
  syntax keyword cPosixFunction fdetach
  syntax keyword cPosixFunction getmsg
  syntax keyword cPosixFunction getpmsg
  syntax keyword cPosixFunction ioctl
  syntax keyword cPosixFunction isastream
  syntax keyword cPosixFunction putmsg
  syntax keyword cPosixFunction putpmsg
endif

let &cpo = s:save_cpo
unlet s:save_cpo

