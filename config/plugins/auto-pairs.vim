if !g:spacevim_autocomplete_parens
  finish
endif

if get(g:, 'AutoPairsFlyMode', 1) == 0
  function! s:replace_autopairs_map(char)
    let afterStr = strpart(getline('.'), col('.')-1)
    if afterStr =~ '^\s*'.a:char
      return a:char
    elseif afterStr =~ '^\s*$'
      let nextLineNum = getpos('.')[1] + 1
      let nextLine = getline(nextLineNum)
      while nextLineNum <= line('$') && nextLine =~ '^\s*$'
        let nextLineNum += 1
        let nextLine = getline(nextLineNum)
      endwhile
      if nextLine =~ '^\s*'.a:char
        return a:char
      else
        return AutoPairsInsert(a:char)
      endif
    else
      return AutoPairsInsert(a:char)
    endif
  endfunction

  function! s:disable_autopair_flymod()
    if b:autopairs_loaded < 2
      iunmap <buffer> }
      iunmap <buffer> ]
      iunmap <buffer> )
      iunmap <buffer> `
      iunmap <buffer> '
      iunmap <buffer> "
      inoremap <buffer> <silent> } <c-r>=<SID>replace_autopairs_map('}')<cr>
      inoremap <buffer> <silent> ] <c-r>=<SID>replace_autopairs_map(']')<cr>
      inoremap <buffer> <silent> ) <c-r>=<SID>replace_autopairs_map(')')<cr>
      inoremap <buffer> <silent> ` <c-r>=<SID>replace_autopairs_map('`')<cr>
      inoremap <buffer> <silent> ' <c-r>=<SID>replace_autopairs_map("'")<cr>
      inoremap <buffer> <silent> " <c-r>=<SID>replace_autopairs_map('"')<cr>
    endif
    let b:autopairs_loaded = 2
  endfunction

  augroup AutoPairs
    autocmd InsertEnter * call s:disable_autopair_flymod()
  augroup END
endif

if g:spacevim_autocomplete_method ==# 'ycm'
  let g:AutoPairsMapCR = 0
  let g:ycm_key_list_stop_completion = get(g:, 'ycm_key_list_stop_completion', [])
  call add(g:ycm_key_list_stop_completion, '<S-CR>')

  function! s:control_ycm_and_autopair_return()
    if expand('<cWORD>') ==# '{}' || expand('<cWORD>') ==# '[]' || expand('<cWORD>') ==# '()'
      return "\<CR>\<c-c>zz=ko"
    else
      let ret = substitute(substitute(execute('imap <s-cr>'),'^.*<SNR>','<SNR>', ''),"S-CR",'CR','')
      if ret =~ 'StopCompletion'
        exe 'return '. ret
      else
        return "\<cr>"
      endif
    endif
  endfunction
  inoremap <silent><cr> <c-r>=<SID>control_ycm_and_autopair_return()<cr>
endif
