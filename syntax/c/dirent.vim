let s:save_cpo = &cpo
set cpo&vim

if !exists('c_no_posix_type')
  syn keyword cPosixType DIR
endif

if !exists('c_no_posix_struct')
  syn keyword cPosixStruct dirent
endif

if !exists('c_no_posix_function')
  syntax keyword cPosixFunction alphasort
  syntax keyword cPosixFunction closedir
  syntax keyword cPosixFunction dirfd
  syntax keyword cPosixFunction fdopendir
  syntax keyword cPosixFunction opendir
  syntax keyword cPosixFunction readdir
  syntax keyword cPosixFunction readdir_r
  syntax keyword cPosixFunction rewinddir
  syntax keyword cPosixFunction scandir
  syntax keyword cPosixFunction seekdir
  syntax keyword cPosixFunction telldir
endif

let &cpo = s:save_cpo
unlet s:save_cpo

