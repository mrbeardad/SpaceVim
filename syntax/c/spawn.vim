let s:save_cpo = &cpo
set cpo&vim

if !exists('c_no_posix_type')
  syntax keyword cPosixType posix_spawnattr_t
  syntax keyword cPosixType posix_spawn_file_actions_t
endif

if !exists('c_no_posix_constant')
  syntax keyword cPosixConstant POSIX_SPAWN_RESETIDS
  syntax keyword cPosixConstant POSIX_SPAWN_SETPGROUP
  syntax keyword cPosixConstant POSIX_SPAWN_SETSCHEDPARAM
  syntax keyword cPosixConstant POSIX_SPAWN_SETSCHEDULER
  syntax keyword cPosixConstant POSIX_SPAWN_SETSIGDEF
  syntax keyword cPosixConstant POSIX_SPAWN_SETSIGMASK
endif

if !exists('c_no_posix_function')
  syntax keyword cPosixFunction posix_spawn
  syntax keyword cPosixFunction posix_spawn_file_actions_addclose
  syntax keyword cPosixFunction posix_spawn_file_actions_adddup2
  syntax keyword cPosixFunction posix_spawn_file_actions_addopen
  syntax keyword cPosixFunction posix_spawn_file_actions_destroy
  syntax keyword cPosixFunction posix_spawn_file_actions_init
  syntax keyword cPosixFunction posix_spawnattr_destroy
  syntax keyword cPosixFunction posix_spawnattr_getflags
  syntax keyword cPosixFunction posix_spawnattr_getpgroup
  syntax keyword cPosixFunction posix_spawnattr_getschedparam
  syntax keyword cPosixFunction posix_spawnattr_getschedpolicy
  syntax keyword cPosixFunction posix_spawnattr_getsigdefault
  syntax keyword cPosixFunction posix_spawnattr_getsigmask
  syntax keyword cPosixFunction posix_spawnattr_init
  syntax keyword cPosixFunction posix_spawnattr_setflags
  syntax keyword cPosixFunction posix_spawnattr_setpgroup
  syntax keyword cPosixFunction posix_spawnattr_setschedparam
  syntax keyword cPosixFunction posix_spawnattr_setschedpolicy
  syntax keyword cPosixFunction posix_spawnattr_setsigdefault
  syntax keyword cPosixFunction posix_spawnattr_setsigmask
  syntax keyword cPosixFunction posix_spawnp
endif

let &cpo = s:save_cpo
unlet s:save_cpo

