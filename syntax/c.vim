let s:cpo_save = &cpo
set cpo&vim

if version >= 508 || !exists('did_c_syntax_posix_inits')
  if version < 508
    let did_c_syntax_posix_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif
  HiLink cPosixType Type
  HiLink cPosixEnum Type
  HiLink cPosixStruct Type
  HiLink cPosixVariable Identifier
  HiLink cPosixConstant Constant
  HiLink cPosixEnumConstant Constant
  HiLink cPosixFunction Function
  delcommand HiLink
endif

let &cpo = s:cpo_save
unlet s:cpo_save

