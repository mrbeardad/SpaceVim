let s:save_cpo = &cpo
set cpo&vim

if !exists('c_no_posix_constant')
  syntax keyword cPosixConstant F_DUPFD
  syntax keyword cPosixConstant F_DUPFD_CLOEXEC
  syntax keyword cPosixConstant F_GETFD
  syntax keyword cPosixConstant F_SETFD
  syntax keyword cPosixConstant F_GETFL
  syntax keyword cPosixConstant F_SETFL
  syntax keyword cPosixConstant F_GETLK
  syntax keyword cPosixConstant F_SETLK
  syntax keyword cPosixConstant F_SETLKW
  syntax keyword cPosixConstant F_GETOWN
  syntax keyword cPosixConstant F_SETOWN
  syntax keyword cPosixConstant FD_CLOEXEC
  syntax keyword cPosixConstant F_RDLCK
  syntax keyword cPosixConstant F_UNLCK
  syntax keyword cPosixConstant F_WRLCK
  syntax keyword cPosixConstant O_CLOEXEC
  syntax keyword cPosixConstant O_CREAT
  syntax keyword cPosixConstant O_DIRECTORY
  syntax keyword cPosixConstant O_EXCL
  syntax keyword cPosixConstant O_NOCTTY
  syntax keyword cPosixConstant O_NOFOLLOW
  syntax keyword cPosixConstant O_TRUNC
  syntax keyword cPosixConstant O_TTY_INIT
  syntax keyword cPosixConstant O_APPEND
  syntax keyword cPosixConstant O_DSYNC
  syntax keyword cPosixConstant O_NONBLOCK
  syntax keyword cPosixConstant O_RSYNC
  syntax keyword cPosixConstant O_SYNC
  syntax keyword cPosixConstant O_ACCMODE
  syntax keyword cPosixConstant O_EXEC
  syntax keyword cPosixConstant O_RDONLY
  syntax keyword cPosixConstant O_RDWR
  syntax keyword cPosixConstant O_SEARCH
  syntax keyword cPosixConstant O_WRONLY
  syntax keyword cPosixConstant AT_FDCWD
  syntax keyword cPosixConstant AT_EACCESS
  syntax keyword cPosixConstant AT_SYMLINK_NOFOLLOW
  syntax keyword cPosixConstant AT_SYMLINK_FOLLOW
  syntax keyword cPosixConstant AT_REMOVEDIR
  syntax keyword cPosixConstant POSIX_FADV_DONTNEED
  syntax keyword cPosixConstant POSIX_FADV_NOREUSE
  syntax keyword cPosixConstant POSIX_FADV_NORMAL
  syntax keyword cPosixConstant POSIX_FADV_RANDOM
  syntax keyword cPosixConstant POSIX_FADV_SEQUENTIAL
  syntax keyword cPosixConstant POSIX_FADV_WILLNEED
endif

if !exists('c_no_posix_struct')
  syntax keyword cPosixStruct flock
endif

if !exists('c_no_posix_function')
  syntax keyword cPosixFunction creat
  syntax keyword cPosixFunction fcntl
  syntax keyword cPosixFunction open
  syntax keyword cPosixFunction openat
  syntax keyword cPosixFunction posix_fadvise
  syntax keyword cPosixFunction posix_fallocate
endif

let &cpo = s:save_cpo
unlet s:save_cpo

