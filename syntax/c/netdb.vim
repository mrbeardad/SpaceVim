let s:save_cpo = &cpo
set cpo&vim

if !exists('c_no_posix_struct')
  syntax keyword cPosixStruct hostent
  syntax keyword cPosixStruct netent
  syntax keyword cPosixStruct protoent
  syntax keyword cPosixStruct servent
  syntax keyword cPosixStruct addrinfo
endif

if !exists('c_no_posix_constant')
  syntax keyword cPosixConstant AI_PASSIVE
  syntax keyword cPosixConstant AI_CANONNAME
  syntax keyword cPosixConstant AI_NUMERICHOST
  syntax keyword cPosixConstant AI_NUMERICSERV
  syntax keyword cPosixConstant AI_V4MAPPED
  syntax keyword cPosixConstant AI_ALL
  syntax keyword cPosixConstant AI_ADDRCONFIG
  syntax keyword cPosixConstant NI_NOFQDN
  syntax keyword cPosixConstant NI_NUMERICHOST
  syntax keyword cPosixConstant NI_NAMEREQD
  syntax keyword cPosixConstant NI_NUMERICSERV
  syntax keyword cPosixConstant NI_NUMERICSCOPE
  syntax keyword cPosixConstant NI_DGRAM
  syntax keyword cPosixConstant IPPORT_RESERVED
  syntax keyword cPosixConstant EAI_AGAIN
  syntax keyword cPosixConstant EAI_BADFLAGS
  syntax keyword cPosixConstant EAI_FAIL
  syntax keyword cPosixConstant EAI_FAMILY
  syntax keyword cPosixConstant EAI_MEMORY
  syntax keyword cPosixConstant EAI_NONAME
  syntax keyword cPosixConstant NI_NAMEREQD
  syntax keyword cPosixConstant EAI_SERVICE
  syntax keyword cPosixConstant EAI_SOCKTYPE
  syntax keyword cPosixConstant EAI_SYSTEM
  syntax keyword cPosixConstant EAI_OVERFLOW
endif

if !exists('c_no_posix_function')
  syntax keyword cPosixFunction endhostent
  syntax keyword cPosixFunction endnetent
  syntax keyword cPosixFunction endprotoent
  syntax keyword cPosixFunction endservent
  syntax keyword cPosixFunction freeaddrinfo
  syntax keyword cPosixFunction gai_strerror
  syntax keyword cPosixFunction getaddrinfo
  syntax keyword cPosixFunction gethostent
  syntax keyword cPosixFunction getnameinfo
  syntax keyword cPosixFunction getnetbyaddr
  syntax keyword cPosixFunction getnetbyname
  syntax keyword cPosixFunction getnetent
  syntax keyword cPosixFunction getprotobyname
  syntax keyword cPosixFunction getprotobynumber
  syntax keyword cPosixFunction getprotoent
  syntax keyword cPosixFunction getservbyname
  syntax keyword cPosixFunction getservbyport
  syntax keyword cPosixFunction getservent
  syntax keyword cPosixFunction sethostent
  syntax keyword cPosixFunction setnetent
  syntax keyword cPosixFunction setprotoent
  syntax keyword cPosixFunction setservent
endif

let &cpo = s:save_cpo
unlet s:save_cpo

