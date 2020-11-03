let s:save_cpo = &cpo
set cpo&vim

if !exists('c_no_posix_struct')
  syntax keyword cPosixStruct stat
endif

if !exists('c_no_posix_constant')
  syntax keyword cPosixConstant S_IFMT
  syntax keyword cPosixConstant S_IFBLK
  syntax keyword cPosixConstant S_IFCHR
  syntax keyword cPosixConstant S_IFIFO
  syntax keyword cPosixConstant S_IFREG
  syntax keyword cPosixConstant S_IFDIR
  syntax keyword cPosixConstant S_IFLNK
  syntax keyword cPosixConstant S_IFSOCK
  syntax keyword cPosixConstant S_IRWXU
  syntax keyword cPosixConstant S_IRUSR
  syntax keyword cPosixConstant S_IWUSR
  syntax keyword cPosixConstant S_IXUSR
  syntax keyword cPosixConstant S_IRWXG
  syntax keyword cPosixConstant S_IRGRP
  syntax keyword cPosixConstant S_IWGRP
  syntax keyword cPosixConstant S_IXGRP
  syntax keyword cPosixConstant S_IRWXO
  syntax keyword cPosixConstant S_IROTH
  syntax keyword cPosixConstant S_IWOTH
  syntax keyword cPosixConstant S_IXOTH
  syntax keyword cPosixConstant S_ISUID
  syntax keyword cPosixConstant S_ISGID
  syntax keyword cPosixConstant S_ISVTX
  syntax keyword cPosixConstant UTIME_NOW
  syntax keyword cPosixConstant UTIME_OMIT
endif

if !exists('c_no_posix_function')
  syntax keyword cPosixFunction chmod
  syntax keyword cPosixFunction fchmod
  syntax keyword cPosixFunction fchmodat
  syntax keyword cPosixFunction fstat
  syntax keyword cPosixFunction fstatat
  syntax keyword cPosixFunction futimens
  syntax keyword cPosixFunction lstat
  syntax keyword cPosixFunction mkdir
  syntax keyword cPosixFunction mkdirat
  syntax keyword cPosixFunction mkfifo
  syntax keyword cPosixFunction mkfifoat
  syntax keyword cPosixFunction mknod
  syntax keyword cPosixFunction mknodat
  syntax keyword cPosixFunction stat
  syntax keyword cPosixFunction umask
  syntax keyword cPosixFunction utimensat
  syntax keyword cPosixFunction S_ISBLK
  syntax keyword cPosixFunction S_ISCHR
  syntax keyword cPosixFunction S_ISDIR
  syntax keyword cPosixFunction S_ISFIFO
  syntax keyword cPosixFunction S_ISREG
  syntax keyword cPosixFunction S_ISLNK
  syntax keyword cPosixFunction S_ISSOCK
  syntax keyword cPosixFunction S_TYPEISMQ
  syntax keyword cPosixFunction S_TYPEISSEM
  syntax keyword cPosixFunction S_TYPEISSHM
  syntax keyword cPosixFunction S_TYPEISTMO
endif

let &cpo = s:save_cpo
unlet s:save_cpo

