let s:save_cpo = &cpo
set cpo&vim

if !exists('c_no_posix_struct')
  syntax keyword cPosixStruct wordexp_t
endif

if !exists('c_no_posix_constant')
  syntax keyword cPosixConstant WRDE_APPEND
  syntax keyword cPosixConstant WRDE_DOOFFS
  syntax keyword cPosixConstant WRDE_NOCMD
  syntax keyword cPosixConstant WRDE_REUSE
  syntax keyword cPosixConstant WRDE_SHOWERR
  syntax keyword cPosixConstant WRDE_UNDEF
  syntax keyword cPosixConstant WRDE_BADCHAR
  syntax keyword cPosixConstant WRDE_BADVAL
  syntax keyword cPosixConstant WRDE_CMDSUB
  syntax keyword cPosixConstant WRDE_NOSPACE
  syntax keyword cPosixConstant WRDE_SYNTAX
endif

if !exists('c_no_posix_function')
  syntax keyword cPosixFunction wordexp
  syntax keyword cPosixFunction wordfree
endif

let &cpo = s:save_cpo
unlet s:save_cpo

