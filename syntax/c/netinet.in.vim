let s:save_cpo = &cpo
set cpo&vim

if !exists('c_no_posix_type')
  syntax keyword cPosixType in_port_t
  syntax keyword cPosixType in_addr_t
endif

if !exists('c_no_posix_struct')
  syntax keyword cPosixStruct in_addr
  syntax keyword cPosixStruct sockaddr_in
  syntax keyword cPosixStruct in6_addr
  syntax keyword cPosixStruct sockaddr_in6
  syntax keyword cPosixStruct ipv6_mreq
endif

if !exists('c_no_posix_variable')
  syntax keyword cPosixVariable in6addr_any
endif

if !exists('c_no_posix_constant')
  syntax keyword cPosixConstant IPPROTO_IP
  syntax keyword cPosixConstant IPPROTO_IPV6
  syntax keyword cPosixConstant IPPROTO_ICMP
  syntax keyword cPosixConstant IPPROTO_RAW
  syntax keyword cPosixConstant IPPROTO_TCP
  syntax keyword cPosixConstant IPPROTO_UDP
  syntax keyword cPosixConstant INADDR_ANY
  syntax keyword cPosixConstant INADDR_BROADCAST
  syntax keyword cPosixConstant INET_ADDRSTRLEN
  syntax keyword cPosixConstant INET6_ADDRSTRLEN
  syntax keyword cPosixConstant IPV6_JOIN_GROUP
  syntax keyword cPosixConstant IPV6_LEAVE_GROUP
  syntax keyword cPosixConstant IPV6_MULTICAST_HOPS
  syntax keyword cPosixConstant IPV6_MULTICAST_IF
  syntax keyword cPosixConstant IPV6_MULTICAST_LOOP
  syntax keyword cPosixConstant IPV6_UNICAST_HOPS
  syntax keyword cPosixConstant IPV6_V6ONLY
  syntax keyword cPosixConstant IN6_IS_ADDR_UNSPECIFIED
  syntax keyword cPosixConstant IN6_IS_ADDR_LOOPBACK
  syntax keyword cPosixConstant IN6_IS_ADDR_MULTICAST
  syntax keyword cPosixConstant IN6_IS_ADDR_LINKLOCAL
  syntax keyword cPosixConstant IN6_IS_ADDR_SITELOCAL
  syntax keyword cPosixConstant IN6_IS_ADDR_V4MAPPED
  syntax keyword cPosixConstant IN6_IS_ADDR_V4COMPAT
  syntax keyword cPosixConstant IN6_IS_ADDR_MC_NODELOCAL
  syntax keyword cPosixConstant IN6_IS_ADDR_MC_LINKLOCAL
  syntax keyword cPosixConstant IN6_IS_ADDR_MC_SITELOCAL
  syntax keyword cPosixConstant IN6_IS_ADDR_MC_ORGLOCAL
  syntax keyword cPosixConstant IN6_IS_ADDR_MC_GLOBAL
endif

let &cpo = s:save_cpo
unlet s:save_cpo

