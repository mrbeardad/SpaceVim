let s:save_cpo = &cpo
set cpo&vim

if !exists('c_no_posix_struct')
  syntax keyword cPosixStruct FTW
endif

if !exists('c_no_posix_constant')
  syntax keyword cPosixConstant FTW_F
  syntax keyword cPosixConstant FTW_D
  syntax keyword cPosixConstant FTW_DNR
  syntax keyword cPosixConstant FTW_DP
  syntax keyword cPosixConstant FTW_NS
  syntax keyword cPosixConstant FTW_SL
  syntax keyword cPosixConstant FTW_SLN
  syntax keyword cPosixConstant FTW_PHYS
  syntax keyword cPosixConstant FTW_MOUNT
  syntax keyword cPosixConstant FTW_DEPTH
  syntax keyword cPosixConstant FTW_CHDIR
endif

if !exists('c_no_posix_function')
  syntax keyword cPosixFunction ftw
  syntax keyword cPosixFunction nftw
endif

let &cpo = s:save_cpo
unlet s:save_cpo

