let s:save_cpo = &cpo
set cpo&vim

if !exists('c_no_posix_constant')
  syntax keyword cPosixConstant PROT_EXEC
  syntax keyword cPosixConstant PROT_NONE
  syntax keyword cPosixConstant PROT_READ
  syntax keyword cPosixConstant PROT_WRITE
  syntax keyword cPosixConstant MS_ASYNC
  syntax keyword cPosixConstant MS_INVALIDATE
  syntax keyword cPosixConstant MS_SYNC
  syntax keyword cPosixConstant MCL_CURRENT
  syntax keyword cPosixConstant MCL_FUTURE
  syntax keyword cPosixConstant MAP_FAILED
  syntax keyword cPosixConstant POSIX_MADV_DONTNEED
  syntax keyword cPosixConstant POSIX_MADV_NORMAL
  syntax keyword cPosixConstant POSIX_MADV_RANDOM
  syntax keyword cPosixConstant POSIX_MADV_SEQUENTIAL
  syntax keyword cPosixConstant POSIX_MADV_WILLNEED
  syntax keyword cPosixConstant MAP_FIXED
  syntax keyword cPosixConstant MAP_PRIVATE
  syntax keyword cPosixConstant MAP_SHARED
  syntax keyword cPosixConstant POSIX_TYPED_MEM_ALLOCATE
  syntax keyword cPosixConstant POSIX_TYPED_MEM_ALLOCATE_CONTIG
  syntax keyword cPosixConstant POSIX_TYPED_MEM_MAP_ALLOCATABLE
endif

if !exists('c_no_posix_struct')
  syntax keyword cPosixStruct posix_typed_mem_info
endif

if !exists('c_no_posix_function')
  syntax keyword cPosixFunction mlock
  syntax keyword cPosixFunction mlockall
  syntax keyword cPosixFunction mmap
  syntax keyword cPosixFunction mprotect
  syntax keyword cPosixFunction msync
  syntax keyword cPosixFunction munlock
  syntax keyword cPosixFunction munlockall
  syntax keyword cPosixFunction munmap
  syntax keyword cPosixFunction posix_madvise
  syntax keyword cPosixFunction posix_mem_offset
  syntax keyword cPosixFunction posix_typed_mem_get_info
  syntax keyword cPosixFunction posix_typed_mem_open
  syntax keyword cPosixFunction shm_open
  syntax keyword cPosixFunction shm_unlink
endif

let &cpo = s:save_cpo
unlet s:save_cpo

