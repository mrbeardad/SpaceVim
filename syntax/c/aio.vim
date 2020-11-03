let s:save_cpo = &cpo
set cpo&vim

if !exists('c_no_posix_struct')
  syntax keyword cPosixStruct aiocb
endif

if !exists('c_no_posix_constant')
  syntax keyword cPosixConstant AIO_ALLDONE
  syntax keyword cPosixConstant AIO_CANCELED
  syntax keyword cPosixConstant AIO_NOTCANCELED
  syntax keyword cPosixConstant LIO_NOP
  syntax keyword cPosixConstant LIO_NOWAIT
  syntax keyword cPosixConstant LIO_READ
  syntax keyword cPosixConstant LIO_WAIT
  syntax keyword cPosixConstant LIO_WRITE
endif

if !exists('c_no_posix_function')
  syntax keyword cPosixFunction aio_cancel
  syntax keyword cPosixFunction aio_error
  syntax keyword cPosixFunction aio_fsync
  syntax keyword cPosixFunction aio_read
  syntax keyword cPosixFunction aio_return
  syntax keyword cPosixFunction aio_suspend
  syntax keyword cPosixFunction aio_write
  syntax keyword cPosixFunction lio_listio
endif

let &cpo = s:save_cpo
unlet s:save_cpo

