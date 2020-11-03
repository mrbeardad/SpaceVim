let s:save_cpo = &cpo
set cpo&vim

if !exists('c_no_posix_constant')
  syntax keyword cPosixConstant RTLD_LAZY
  syntax keyword cPosixConstant RTLD_NOW
  syntax keyword cPosixConstant RTLD_GLOBAL
  syntax keyword cPosixConstant RTLD_LOCAL
endif

if !exists('c_no_posix_function')
  syntax keyword cPosixFunction dlclose
  syntax keyword cPosixFunction dlerror
  syntax keyword cPosixFunction dlopen
  syntax keyword cPosixFunction dlsym
endif

let &cpo = s:save_cpo
unlet s:save_cpo

