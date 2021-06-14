"=============================================================================
" quickrun.vim --- code quickrun for SpaceVim
" Copyright (c) 2016-2020 Heachen Bear
" Author: Heachen Bear < mrbeardad@qq.com >
" URL: https://spacevim.org
" License: GPLv3
"=============================================================================

let s:TermBufnr = {}
let s:InputBufnr = {}
let s:IsTermOpend = {}

function! s:close_term_and_input() abort
  let terms = values(s:TermBufnr)
  let inputs = values(s:InputBufnr)
  let winLayout = split(substitute(string(winlayout()), '\D', ' ', 'g'))

  let anyClosed = 0
  for winid in winLayout
    let bufnr = winbufnr(winid)
    if index(terms, bufnr) != -1 || index(inputs, bufnr) != -1
      exe win_id2win(winid).'close'
      let anyClosed = 1
    endif
  endfor
  let &l:statusline = SpaceVim#layers#core#statusline#get(1)  " close命令导致状态栏失焦
  return anyClosed
endfunction


function! s:open_termwin_quickrun() abort
  call s:close_term_and_input()
  let curTermBufnr = get(s:TermBufnr, bufnr(), -1)
  let curInputBufnr = get(s:InputBufnr, bufnr(), -1)
  let origBufnr = bufnr()

  " 销毁之前term窗口
  if curTermBufnr != -1 && bufexists(curTermBufnr)
    execute 'bw! ' . curTermBufnr
  endif
  " 开启新term窗口
  belowright 11 split __quickrun__
  setlocal buftype=nofile
        \ nobuflisted
        \ nomodifiable
        \ noim
        \ noswapfile
        \ nospell
        \ winfixheight
  let s:TermBufnr[origBufnr] = bufnr()
  let s:IsTermOpend[origBufnr] = 1

  " 开启input窗口并跳回term窗口
  if curInputBufnr != -1 && bufexists(curInputBufnr)
    silent belowright vert 30 split +exe\ 'b\ '.curInputBufnr
    setl winfixheight
    winc p
  endif
endfunction

function! s:try_open_term_with_input() abort
  let curTermBufnr = get(s:TermBufnr, bufnr(), -1)
  let curInputBufnr = get(s:InputBufnr, bufnr(), -1)
  let origBufnr = bufnr()

  if curTermBufnr != -1 && bufexists(curTermBufnr)
    belowright 11 split +exe\ 'b\ '.curTermBufnr
    setl winfixheight
    if curInputBufnr != -1 && bufexists(curInputBufnr)
      silent belowright vert 30 split +exe\ 'b\ '.curInputBufnr
      setl winfixheight
    endif
  endif

  call win_gotoid(bufwinid(origBufnr))
endfunction


function! s:toggle_termwin_manually() abort
  let isOpend = s:close_term_and_input()

  if isOpend
    let s:IsTermOpend[bufnr()] = 0
    return
  endif

  call s:try_open_term_with_input()
  let s:IsTermOpend[bufnr()] = 1
endfunction


function! s:toggle_termwin_automatically()
  if &buflisted ==# 0
    return
  endif

  call s:close_term_and_input()
  if get(s:IsTermOpend, bufnr(), 0) == 1
    call s:try_open_term_with_input()
  endif
endfunction


function! SpaceVim#plugins#quickrun#OpenInputWin()
  let curTermBufnr = get(s:TermBufnr, bufnr(), -1)
  let curInputBufnr = get(s:InputBufnr, bufnr(), -1)
  let origBufnr = bufnr()

  let tagWinId = bufwinid(curInputBufnr)
  if tagWinId != -1
    call win_gotoid(tagWinId)
    return
  endif

  call s:close_term_and_input()

  if curInputBufnr == -1
    let inputfile = expand('%:p') . '.input'
    let b:QuickrunRedir = '< '.inputfile
    execute 'silent belowright 11 split ' . inputfile
    let s:InputBufnr[origBufnr] = bufnr()
    setlocal ft=Input
        \ nobuflisted
        \ noswapfile
        \ nospell
        \ winfixheight
  else
    silent belowright 11 split +exe\ 'b\ '.curInputBufnr
  endif

  if curTermBufnr != -1
    silent belowright vert 30 split
    winc p
    exe 'b '.curTermBufnr
    winc p
  endif

  if !filereadable(inputfile)
    w
  endif
endfunction


function! s:get_timestamp(file)
  return py3eval('os.path.getmtime("'.a:file.'")')
endfunction

" add extended compile flags
function! s:extend_compile_flags()
  let regex = has_key(g:quickrun_default_flags[&ft], 'extRegex') ? g:quickrun_default_flags[&ft].extRegex : []
  let flags = has_key(g:quickrun_default_flags[&ft], 'extFlags') ? g:quickrun_default_flags[&ft].extFlags : []
  let ret = ''
  let idx = 0
  for thisRegex in regex
    if search(thisRegex, 'wn') != 0
      let ret = ret . ' ' . flags[idx]
    endif
    let idx += 1
  endfor
  return ret
endfunction

let s:FILE = SpaceVim#api#import('file')
let s:variables = {}
function! s:init_variables() abort
  let s:variables.workspaceFolder = s:FILE.unify_path(SpaceVim#plugins#projectmanager#current_root())
  let s:variables.workspaceFolderBasename = fnamemodify(s:variables.workspaceFolder, ':t')
  let s:variables.file = s:FILE.unify_path(expand('%:p'))
  let s:variables.relativeFile = s:FILE.unify_path(expand('%'), ':.')
  let s:variables.relativeFileDirname = s:FILE.unify_path(expand('%'), ':h')
  let s:variables.fileBasename = expand('%:t')
  let s:variables.fileBasenameNoExtension = expand('%:t:r')
  let s:variables.fileDirname = s:FILE.unify_path(expand('%:p:h'))
  let s:variables.fileExtname = expand('%:e')
  let s:variables.lineNumber = line('.')
  let s:variables.selectedText = ''
  let s:variables.execPath = s:variables.file.'.exe'
endfunction

function! s:parse_flags(str)
  let str = a:str
  for key in keys(s:variables)
    let str = substitute(str, '\\\@<!\${' . key . '}', s:variables[key], 'g')
  endfor
  return str
endfunction

" a:1 == 1 表示强制重新编译
function! SpaceVim#plugins#quickrun#QuickRun(...)
  if &modified == 1 | write | endif
  call s:init_variables()
  let qr_compile = s:parse_flags(b:QuickrunCompileCmd) . ' ' . s:extend_compile_flags()
  let qr_compile = qr_compile =~# '^ *$' ? '' : qr_compile
  let qr_cmdrun = s:parse_flags(b:QuickrunRunCmd) . ' ' . s:parse_flags(b:QuickrunRedir)

  " compilation is not necessary
  if filereadable(s:variables.execPath) && s:get_timestamp(s:variables.execPath) >= s:get_timestamp(s:variables.file)
        \ && !exists('a:1') && &modified == 0
    let qr_compile = '-'
  endif

  let win = win_getid()
  call s:open_termwin_quickrun()
  call termopen(g:_spacevim_root_dir.'custom/quickrun.sh "'.qr_compile.'" "'.qr_cmdrun.'"')
  call win_gotoid(win)
endfunction

"==================================================================================================

" provide commands to change quickrun variables
function! s:key_binding(var, str, ...) abort
  " `cmd!` means modify it
  if exists('a:1') && a:1 ==# '!'
    call feedkeys(':'.a:var.' '.eval('b:'.a:var))
  elseif a:str ==# ''
    exe 'let b:'. a:var
  else
    exe 'let b:'. a:var .' =  a:str'
  endif
endfunction

" initialize buffer variables
function! s:init_buffer(ft)
  let b:QuickrunCompileCmd = get(g:quickrun_default_flags[a:ft], 'compileCmd', '')
  let b:QuickrunRunCmd = get(g:quickrun_default_flags[a:ft], 'runCmd', '')
  let b:QuickrunRedir = get(g:quickrun_default_flags[a:ft], 'redir', '')
  command! -buffer -bang -nargs=? -complete=file QuickrunCompileCmd  call s:key_binding('QuickrunCompileCmd', <q-args>, "<bang>")
  command! -buffer -bang -nargs=? -complete=file QuickrunRunCmd      call s:key_binding('QuickrunRunCmd', <q-args>, "<bang>")
  command! -buffer -bang -nargs=? -complete=file QuickrunRedir       call s:key_binding('QuickrunRedir', <q-args>, "<bang>")
endfunction

function! s:term_enter()
  if buffer_name() =~# 'term://'
    call feedkeys("\<c-\>\<c-n>:call setpos('.', get(b:, 'quickrun_term_pos', [0, 1, 1, 0, 1]))\<cr>:\<cr>")
  endif
endfunction
function! s:term_leave()
  if buffer_name() =~# 'term://'
    let b:quickrun_term_pos = getcurpos()
  endif
endfunction

let s:already_loaded = 0
" plugin entry function
function! SpaceVim#plugins#quickrun#prepare()
  " load only once
  if s:already_loaded == 1
    return
  else
    let s:already_loaded = 1
  endif

  " import required python modules
  py3 import os
  py3 import time
  py3 import datetime

  " set autocmds
  augroup Quickrun
    for thisFT in keys(g:quickrun_default_flags)
      exe 'autocmd FileType '.thisFT.' call s:init_buffer(&ft)'
    endfor

    autocmd BufEnter * call s:toggle_termwin_automatically()
    nnoremap <silent> <F7> :call <SID>toggle_termwin_manually()<cr>

    if has('nvim')
      " au WinEnter * call s:term_enter()
      " au WinLeave * call s:term_leave()
      tnoremap <esc> <c-\><c-n>
    endif

    au BufLeave *.input if &modified == 1 | w | endif
    au TermEnter * setlocal list
  augroup END
endfunction

" more detail in autoload/SpaceVim/plugins/runner.vim and autoload/SpaceVim/mapping/space.vim
