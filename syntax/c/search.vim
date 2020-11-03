let s:save_cpo = &cpo
set cpo&vim

if !exists('c_no_posix_struct')
  syntax keyword cPosixStruct ENTRY
endif

if !exists('c_no_posix_enum')
  syntax keyword cPosixEnum ACTION;
  syntax keyword cPosixEnum VISIT;
endif

if !exists('c_no_posix_enum_constant')
  " enum ACTION
  syntax keyword cPosixEnumConstant FIND
  syntax keyword cPosixEnumConstant ENTER

  " enum VISIT
  syntax keyword cPosixEnumConstant preorder
  syntax keyword cPosixEnumConstant postorder
  syntax keyword cPosixEnumConstant endorder
  syntax keyword cPosixEnumConstant leaf
endif

if !exists('c_no_posix_function')
  syntax keyword cPosixFunction hcreate
  syntax keyword cPosixFunction hdestroy
  syntax keyword cPosixFunction hsearch
  syntax keyword cPosixFunction insque
  syntax keyword cPosixFunction lfind
  syntax keyword cPosixFunction lsearch
  syntax keyword cPosixFunction remque
  syntax keyword cPosixFunction tdelete
  syntax keyword cPosixFunction tfind
  syntax keyword cPosixFunction tsearch
  syntax keyword cPosixFunction twalk
endif

let &cpo = s:save_cpo
unlet s:save_cpo

