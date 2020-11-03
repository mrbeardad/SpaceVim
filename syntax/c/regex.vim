let s:save_cpo = &cpo
set cpo&vim

if !exists('c_no_posix_struct')
  syntax keyword cPosixStruct regex_t
  syntax keyword cPosixStruct regmatch_t
endif

if !exists('c_no_posix_type')
  syntax keyword cPosixType regoff_t
endif

if !exists('c_no_posix_constant')
  syntax keyword cPosixConstant REG_EXTENDED
  syntax keyword cPosixConstant REG_ICASE
  syntax keyword cPosixConstant REG_NOSUB
  syntax keyword cPosixConstant REG_NEWLINE
  syntax keyword cPosixConstant REG_NOTBOL
  syntax keyword cPosixConstant REG_NOTEOL
  syntax keyword cPosixConstant REG_NOMATCH
  syntax keyword cPosixConstant REG_BADPAT
  syntax keyword cPosixConstant REG_ECOLLATE
  syntax keyword cPosixConstant REG_ECTYPE
  syntax keyword cPosixConstant REG_EESCAPE
  syntax keyword cPosixConstant REG_ESUBREG
  syntax keyword cPosixConstant REG_EBRACK
  syntax keyword cPosixConstant REG_EPAREN
  syntax keyword cPosixConstant REG_EBRACE
  syntax keyword cPosixConstant REG_BADBR
  syntax keyword cPosixConstant REG_ERANGE
  syntax keyword cPosixConstant REG_ESPACE
  syntax keyword cPosixConstant REG_BADRPT
endif

if !exists('c_no_posix_function')
  syntax keyword cPosixFunction regcomp
  syntax keyword cPosixFunction regerror
  syntax keyword cPosixFunction regexec
  syntax keyword cPosixFunction regfree
endif

let &cpo = s:save_cpo
unlet s:save_cpo

