if exists('g:loaded_sort_include')
  finish
endif

let g:loaded_sort_include = 1

let s:save_cpo = &cpo
set cpo&vim

command! SortInclude call sort_include#sort()

let &cpo = s:save_cpo
unlet s:save_cpo
