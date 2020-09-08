hi def link mkdHeading      Delimiter
" syn include @tex syntax/tex.vim
" syn region mkdMath start="\\\@<!\$" end="\$" skip="\\\$" contains=@tex keepend oneline
" syn region mkdMath start="\\\@<!\$\$" end="\$\$" skip="\\\$" contains=@tex keepend oneline
" if exists('b:current_syntax')
  " unlet b:current_syntax
" endif
