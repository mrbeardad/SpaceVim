"=============================================================================
" chinese.vim --- SpaceVim chinese layer
" Copyright (c) 2016-2020 Wang Shidong & Contributors
" Author: Wang Shidong < wsdjeg at 163.com >
" URL: https://spacevim.org
" License: GPLv3
"=============================================================================


function! SpaceVim#layers#chinese#plugins() abort
  let plugins = [
        \ ['yianwillis/vimcdoc'          , {'merged' : 0}],
        \ ['voldikss/vim-translator' , {'merged' : 0, 'on_cmd' : ['Translate', 'TranslateW', 'TranslateR', 'TranslateX']}],
        \ ['wsdjeg/ChineseLinter.vim'    , {'merged' : 0, 'on_cmd' : 'CheckChinese', 'on_ft' : ['markdown', 'text']}],
        \ ]
  if SpaceVim#layers#isLoaded('ctrlp')
    call add(plugins, ['vimcn/ctrlp.cnx', {'merged' : 0}])
  endif
  return plugins
endfunction

function! SpaceVim#layers#chinese#config() abort
  let g:translator_default_engines = ['bing', 'youdao']
  let g:_spacevim_mappings.t = {'name' : '+Translate'}
  call SpaceVim#mapping#def('nnoremap', '<Leader>tc', ':Translate<cr>', '', '', 'Translate in cmdline')
  call SpaceVim#mapping#def('vnoremap', '<Leader>tc', ':Translate<cr>', '', '', 'Translate in cmdline')
  call SpaceVim#mapping#def('nnoremap', '<Leader>tw', ':TranslateW<cr>', '', '', 'Translate in popwindow')
  call SpaceVim#mapping#def('vnoremap', '<Leader>tw', ':TranslateW<cr>', '', '', 'Translate in popwindow')
  call SpaceVim#mapping#def('nnoremap', '<Leader>tr', 'viw:<c-u>TranslateR<cr>', '', '', 'Translate and replace')
  call SpaceVim#mapping#def('vnoremap', '<Leader>tr', ':TranslateR<cr>', '', '', 'Translate and replace')
  call SpaceVim#mapping#def('nnoremap', '<Leader>tx', ':TranslateX<cr>', '', '', 'Translate content in clipboard')
  call SpaceVim#mapping#space#def('nnoremap', ['l', 'c']     , 'CheckChinese', 'Check with ChineseLinter', 1)
  " do not load vimcdoc plugin 
  let g:loaded_vimcdoc = 1
endfunction
