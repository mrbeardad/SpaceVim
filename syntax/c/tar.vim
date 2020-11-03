let s:save_cpo = &cpo
set cpo&vim

if !exists('c_no_posix_constant')
  syntax keyword cPosixConstant TMAGIC
  syntax keyword cPosixConstant TMAGLEN
  syntax keyword cPosixConstant TVERSION
  syntax keyword cPosixConstant TVERSLEN
  syntax keyword cPosixConstant REGTYPE
  syntax keyword cPosixConstant AREGTYPE
  syntax keyword cPosixConstant LNKTYPE
  syntax keyword cPosixConstant SYMTYPE
  syntax keyword cPosixConstant CHRTYPE
  syntax keyword cPosixConstant BLKTYPE
  syntax keyword cPosixConstant DIRTYPE
  syntax keyword cPosixConstant FIFOTYPE
  syntax keyword cPosixConstant CONTTYPE
  syntax keyword cPosixConstant TSUID
  syntax keyword cPosixConstant TSGID
  syntax keyword cPosixConstant TSVTX
  syntax keyword cPosixConstant TUREAD
  syntax keyword cPosixConstant TUWRITE
  syntax keyword cPosixConstant TUEXEC
  syntax keyword cPosixConstant TGREAD
  syntax keyword cPosixConstant TGWRITE
  syntax keyword cPosixConstant TGEXEC
  syntax keyword cPosixConstant TOREAD
  syntax keyword cPosixConstant TOWRITE
  syntax keyword cPosixConstant TOEXEC
endif

let &cpo = s:save_cpo
unlet s:save_cpo

