let s:save_cpo = &cpo
set cpo&vim

if !exists('c_no_posix_constant')
  syn keyword cPosixConstant C_IRUSR
  syn keyword cPosixConstant C_IWUSR
  syn keyword cPosixConstant C_IXUSR
  syn keyword cPosixConstant C_IRGRP
  syn keyword cPosixConstant C_IWGRP
  syn keyword cPosixConstant C_IXGRP
  syn keyword cPosixConstant C_IROTH
  syn keyword cPosixConstant C_IWOTH
  syn keyword cPosixConstant C_IXOTH
  syn keyword cPosixConstant C_ISUID
  syn keyword cPosixConstant C_ISGID
  syn keyword cPosixConstant C_ISVTX
  syn keyword cPosixConstant C_ISDIR
  syn keyword cPosixConstant C_ISFIFO
  syn keyword cPosixConstant C_ISREG
  syn keyword cPosixConstant C_ISBLK
  syn keyword cPosixConstant C_ISCHR
  syn keyword cPosixConstant C_ISCTG
  syn keyword cPosixConstant C_ISLNK
  syn keyword cPosixConstant C_ISSOCK
  syn keyword cPosixConstant MAGIC
endif

let &cpo = s:save_cpo
unlet s:save_cpo

