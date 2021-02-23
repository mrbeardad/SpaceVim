"=============================================================================
" tools.vim --- SpaceVim tools layer
" Copyright (c) 2016-2020 Wang Shidong & Contributors
" Author: Wang Shidong < wsdjeg at 163.com >
" URL: https://spacevim.org
" License: GPLv3
"=============================================================================

let s:CMP = SpaceVim#api#import('vim#compatible')

function! SpaceVim#layers#tools#plugins() abort
  let plugins = []
  call add(plugins, ['tpope/vim-scriptease',             { 'merged' : 0}])
  call add(plugins, ['lymslive/vimloo',                  { 'merged' : 0}])
  call add(plugins, ['lymslive/vnote',                   { 'depends' : 'vimloo', 'on_cmd' : ['NoteBook','NoteNew','NoteEdit', 'NoteList', 'NoteConfig', 'NoteIndex', 'NoteImport']}])
  call add(plugins, ['luochen1990/rainbow',              { 'merged' : 0}])
  call add(plugins, ['mbbill/fencview',                  { 'on_cmd' : 'FencAutoDetect'}])
  call add(plugins, ['mbbill/undotree',                  { 'on_cmd' : 'UndotreeToggle'}])
  call add(plugins, ['wsdjeg/vim-cheat',                 { 'on_cmd' : 'Cheat'}])
  call add(plugins, ['wsdjeg/Mysql.vim',                 { 'on_cmd' : 'SQLGetConnection'}])
  call add(plugins, ['wsdjeg/SourceCounter.vim',         { 'on_cmd' : 'SourceCounter'}])
  call add(plugins, ['itchyny/calendar.vim',             { 'on_cmd' : 'Calendar'}])
  call add(plugins, ['junegunn/limelight.vim',           { 'on_cmd' : 'Limelight'}])
  call add(plugins, ['junegunn/goyo.vim',                { 'on_cmd' : 'Goyo', 'loadconf' : 1}])
  call add(plugins, ['MattesGroeger/vim-bookmarks',      { 'on_cmd' :
        \ [
        \ 'BookmarkShowAll',
        \ 'BookmarkToggle',
        \ 'BookmarkAnnotate',
        \ 'BookmarkNext',
        \ 'BookmarkPrev',
        \ 'BookmarkClear',
        \ 'BookmarkClearAll'
        \ ],
        \ 'loadconf_before' : 1}])
  if s:CMP.has('python')
    call add(plugins, ['gregsexton/VimCalc', {'on_cmd' : 'Calc'}])
  elseif s:CMP.has('python3')
    call add(plugins, ['fedorenchik/VimCalc3', {'on_cmd' : 'Calc'}])
  endif

  return plugins
endfunction

function! SpaceVim#layers#tools#config() abort
  let g:better_whitespace_filetypes_blacklist = ['diff', 'gitcommit', 'unite', 'qf', 'help', 'markdown', 'leaderGuide']
  call SpaceVim#mapping#space#def('nnoremap', ['a', 'l'], 'Calendar', 'vim-calendar', 1)
  call SpaceVim#mapping#space#def('nnoremap', ['e', 'a'], 'FencAutoDetect',
        \ 'auto-detect-file-encoding', 1)
  call SpaceVim#mapping#space#def('nnoremap', ['a', 'c'], 'Calc', 'vim-calculator', 1)
  call SpaceVim#mapping#space#def('nnoremap', ['w', 'c'],
        \ 'Goyo', 'centered-buffer-mode', 1)
  call SpaceVim#mapping#space#def('nnoremap', ['w', 'C'],
        \ 'ChooseWin | Goyo', 'choose-window-centered-buffer-mode', 1)

  " bootmark key binding
  call SpaceVim#mapping#space#def('nnoremap', ['m', 'm'], 'BookmarkToggle', 'BookmarkToggle', 1)
  call SpaceVim#mapping#space#def('nnoremap', ['m', 'i'], 'BookmarkAnnotate', 'BookmarkAnnotate', 1)
  call SpaceVim#mapping#space#def('nnoremap', ['m', 'l'], 'BookmarkShowAll', 'BookmarkShowAll', 1)
  call SpaceVim#mapping#space#def('nnoremap', ['m', 'n'], 'BookmarkNext', 'BookmarkNext', 1)
  call SpaceVim#mapping#space#def('nnoremap', ['m', 'b'], 'BookmarkPrev', 'BookmarkPrev', 1)
  call SpaceVim#mapping#space#def('nnoremap', ['m', 'c'], 'BookmarkClear', 'BookmarkClear', 1)
  call SpaceVim#mapping#space#def('nnoremap', ['m', 'C'], 'BookmarkClearAll', 'BookmarkClearAll', 1)
  let g:bookmark_sign = ' '
  let g:bookmark_annotation_sign = ' '
  let g:bookmark_auto_save_file = g:spacevim_data_dir.'SpaceVim/vim_bookmarks'
  let g:bookmark_auto_close = 1
  let g:bookmark_no_default_key_mappings = 1
  call SpaceVim#mapping#space#def('nnoremap', ['a', 'R'],
        \ 'Goyo', 'read-mode', 1)
  nnoremap <silent> <F5> :UndotreeToggle<CR>
  if maparg('<C-_>', 'v') ==# ''
    vnoremap <silent> <C-_> <Esc>:Ydv<CR>
  endif
  if maparg('<C-_>', 'n') ==# ''
    nnoremap <silent> <C-_> <Esc>:Ydc<CR>
  endif
endfunction

" vim:set et sw=2 cc=80:
