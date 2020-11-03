let s:save_cpo = &cpo
set cpo&vim

if !exists('c_no_posix_type')
  syntax keyword cPosixType socklen_t
  syntax keyword cPosixType sa_family_t
endif

if !exists('c_no_posix_constant')
  syntax keyword cPosixConstant SOCK_DGRAM
  syntax keyword cPosixConstant SOCK_RAW
  syntax keyword cPosixConstant SOCK_SEQPACKET
  syntax keyword cPosixConstant SOCK_STREAM
  syntax keyword cPosixConstant SOL_SOCKET
  syntax keyword cPosixConstant SO_ACCEPTCONN
  syntax keyword cPosixConstant SO_BROADCAST
  syntax keyword cPosixConstant SO_DEBUG
  syntax keyword cPosixConstant SO_DONTROUTE
  syntax keyword cPosixConstant SO_ERROR
  syntax keyword cPosixConstant SO_KEEPALIVE
  syntax keyword cPosixConstant SO_LINGER
  syntax keyword cPosixConstant SO_OOBINLINE
  syntax keyword cPosixConstant SO_RCVBUF
  syntax keyword cPosixConstant SO_RCVLOWAT
  syntax keyword cPosixConstant SO_RCVTIMEO
  syntax keyword cPosixConstant SO_REUSEADDR
  syntax keyword cPosixConstant SO_SNDBUF
  syntax keyword cPosixConstant SO_SNDLOWAT
  syntax keyword cPosixConstant SO_SNDTIMEO
  syntax keyword cPosixConstant SO_TYPE
  syntax keyword cPosixConstant SOMAXCONN
  syntax keyword cPosixConstant AF_INET
  syntax keyword cPosixConstant AF_INET6
  syntax keyword cPosixConstant AF_UNIX
  syntax keyword cPosixConstant AF_UNSPEC
  syntax keyword cPosixConstant SHUT_RD
  syntax keyword cPosixConstant SHUT_RDWR
  syntax keyword cPosixConstant SHUT_WR
  syntax keyword cPosixConstant MSG_CTRUNC
  syntax keyword cPosixConstant MSG_DONTROUTE
  syntax keyword cPosixConstant MSG_EOR
  syntax keyword cPosixConstant MSG_OOB
  syntax keyword cPosixConstant MSG_NOSIGNAL
  syntax keyword cPosixConstant MSG_PEEK
  syntax keyword cPosixConstant MSG_TRUNC
  syntax keyword cPosixConstant MSG_WAITALL
endif

if !exists('c_no_posix_struct')
  syntax keyword cPosixStruct sockaddr
  syntax keyword cPosixStruct sockaddr_storage
  syntax keyword cPosixStruct msghdr
  syntax keyword cPosixStruct cmsghdr
  syntax keyword cPosixStruct linger
endif

if !exists('c_no_posix_function')
  syntax keyword cPosixFunction accept
  syntax keyword cPosixFunction bind
  syntax keyword cPosixFunction connect
  syntax keyword cPosixFunction getpeername
  syntax keyword cPosixFunction getsockname
  syntax keyword cPosixFunction getsockopt
  syntax keyword cPosixFunction listen
  syntax keyword cPosixFunction recv
  syntax keyword cPosixFunction recvfrom
  syntax keyword cPosixFunction recvmsg
  syntax keyword cPosixFunction send
  syntax keyword cPosixFunction sendmsg
  syntax keyword cPosixFunction sendto
  syntax keyword cPosixFunction setsockopt
  syntax keyword cPosixFunction shutdown
  syntax keyword cPosixFunction sockatmark
  syntax keyword cPosixFunction socket
  syntax keyword cPosixFunction socketpair
  syntax keyword cPosixFunction CMSG_DATA
  syntax keyword cPosixFunction CMSG_NXTHDR
  syntax keyword cPosixFunction CMSG_FIRSTHDR
endif

let &cpo = s:save_cpo
unlet s:save_cpo

