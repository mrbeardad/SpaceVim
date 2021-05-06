"=============================================================================
" quickrun.vim --- code quickrun for SpaceVim
" Copyright (c) 2016-2020 Heachen Bear
" Author: Heachen Bear < mrbeardad@qq.com >
" URL: https://spacevim.org
" License: GPLv3
"=============================================================================

let s:TermBufnr = {}
let s:InputBufnr = {}

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
  return anyClosed
endfunction


function! s:open_termwin_quickrun() abort
  call s:close_term_and_input()
  let curTermBufnr = get(s:TermBufnr, bufnr(), -1)
  let curInputBufnr = get(s:InputBufnr, bufnr(), -1)
  let origBufnr = bufnr()

  " 删除之前term窗口
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
    return
  endif

  call s:try_open_term_with_input()
endfunction


function! s:toggle_termwin_automatically()
  if &buflisted ==# 0
    return
  endif

  call s:close_term_and_input()
  call s:try_open_term_with_input()
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
    let inputfile = expand('%:t') . '.input'
    let b:QuickrunCmdRedir = '< '.inputfile
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
  return py3eval('time.strftime("%y%m%d%H%M%S", time.localtime(os.path.getmtime("'.a:file.'")))')
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

function! s:parse_flags(str, srcfile, exefile)
  let tmp = substitute(a:str, '\\\@<!\${file}', a:srcfile, 'g')
  let tmp = substitute(tmp, '\\\@<!\${exeFile}', a:exefile, 'g')
  let tmp = substitute(tmp, '\\\@<!\${workspaceFolder}', fnamemodify(SpaceVim#plugins#projectmanager#current_root(), ':p:h'), 'g')
  return tmp
endfunction

" a:1 == 1 表示强制重新编译，a:1 == 2 表示启动调试进程，a:1 == 3 表示两者都
function! SpaceVim#plugins#quickrun#QuickRun(...)
  " 有些autocmd FileType启动太迟无法触发
  exe 'set ft='.&ft
  if &modified == 1 | write | endif
  let src_file_path = fnamemodify(expand('%:p'), ':.')
  let exe_file_path = './'.fnamemodify(expand('%:p'), ':.').'.exe'
  let qr_cl = s:parse_flags(b:QuickrunCompiler, src_file_path, exe_file_path)
  let qr_cf = s:parse_flags(b:QuickrunCompileFlag .' '. s:extend_compile_flags(), src_file_path, exe_file_path)
  let qr_cmd = s:parse_flags(b:QuickrunCmd, src_file_path, exe_file_path)
  let qr_args = s:parse_flags(b:QuickrunCmdArgs, src_file_path, exe_file_path)
  let qr_rd = s:parse_flags(b:QuickrunCmdRedir, src_file_path, exe_file_path)

  " neovim would close terminal automatically
  if has('nvim')
    let qr_end = "echo -e '\n\e[38;5;242mPress any keys to close terminal or press <ESC> to avoid close it ...'; exit;"
  else
    let qr_end = ''
  endif
  let qr_begin = 'set -e; trap "'.qr_end.'" 2;'

  " if need to compile
  if qr_cl !=# ''
    let qr_compile = 'echo -e "\e[1;32m[Compile] \e[34m' . qr_cl . '\e[0m ' . qr_cf . '";'
          \ . qr_cl .' '. qr_cf .';'
  else
    let qr_compile = ''
  endif

  " limit memory using by CGroups
  if (has('unix') || has('wsl'))
    if !isdirectory('/sys/fs/cgroup/memory/quickrun')
      call jobstart('sudo mkdir /sys/fs/cgroup/memory/quickrun')
    endif
    let qr_prepare = 'echo $$ | sudo tee /sys/fs/cgroup/memory/quickrun/cgroup.procs > /dev/null;'
          \ .'echo 500M | sudo tee /sys/fs/cgroup/memory/quickrun/memory.limit_in_bytes > /dev/null;'
          \ .'echo 500M | sudo tee /sys/fs/cgroup/memory/quickrun/memory.memsw.limit_in_bytes > /dev/null;'
  else
    let qr_prepare = ''
  endif

  let qr_running = 'echo "\e[1;32m[Running] \e[34m' . qr_cmd . '\e[0m ' . qr_args .' '. qr_rd .'";'
        \ .'echo -e "\n\e[31m--\e[34m--\e[35m--\e[33m--\e[32m--\e[36m--\e[37m--\e[36m--\e[32m--\e[33m--\e[35m--\e[34m--\e[31m--\e[34m--\e[35m--\e[33m--\e[32m--\e[36m--\e[37m--\e[36m--\e[32m--\e[33m--\e[35m--\e[34m--\e[31m--\e[34m--\e[35m--\e[33m--\e[32m--\e[36m--\e[37m--\e[36m--\e[32m--\e[33m--\e[m";'
        \ .'quickrun_time ' . qr_cmd .' '. qr_args .' '. qr_rd .';'
        \ .qr_end
  let qr_debug = s:parse_flags(b:QuickrunDebugCmd, src_file_path, exe_file_path)

  let debug_mode = get(a:, '1', 0) > 1 " 2 or 3
  let force_compile = get(a:, '1', 0) % 2 == 1 " 1 or 3
  " need compilation
  if force_compile == 1 || &modified == 1 || !filereadable(exe_file_path)
        \ || s:get_timestamp(expand('%:p').'.exe') < s:get_timestamp(expand('%:p'))
    let qr_prepare = qr_begin . qr_compile . qr_prepare
  else  " run directly
    let qr_prepare = qr_begin . qr_prepare . 'echo -e "\e[1;33m[Note]: Neither the buffer nor the file timestamp has changed. Rerunning last compiled program!\e[m";'
  endif

  let win = win_getid()
  call s:open_termwin_quickrun()
  if debug_mode
    if qr_debug =~# '^!'  " backgroud mode
      call termopen(qr_prepare
            \ .'echo -e "\e[1;33m[Debugging]\e[m";'.qr_end)
      call jobstart(substitute(qr_debug, '^!', '', ''))
    else  " terminal mode
      call termopen(qr_prepare
            \ .'echo -e "\e[1;33m[Debugging]\e[m";'.qr_end
            \ .qr_debug.'}')
    endif
  else
    call termopen(qr_prepare . qr_running)
  endif
  call win_gotoid(win)
endfunction

function! SpaceVim#plugins#quickrun#run_task(cmd, opts, isBackground) abort
  call s:open_termwin_quickrun()
  let cmd = split(a:cmd)[0]
  let args = substitute(a:cmd, '^\w*\s*', '', 'g')
  let env = ''
  if has_key(a:opts, 'cwd')
    let env = 'PWD='.a:opts.cwd
  endif

  if has('nvim')
    let qr_end = "echo -e '\n\e[38;5;242mPress any keys to close terminal or press <ESC> to avoid close it ...'; exit;"
  else
    let qr_end = ''
  endif
  let qr_begin = 'set -e; trap "'.qr_end.'" 2;'

  call termopen(qr_begin
        \ .'echo "\e[1;32m[Running] \e[34m' . cmd . '\e[0m ' . args. '";'
        \ .'echo -e "\n\e[31m--\e[34m--\e[35m--\e[33m--\e[32m--\e[36m--\e[37m--\e[36m--\e[32m--\e[33m--\e[35m--\e[34m--\e[31m--\e[34m--\e[35m--\e[33m--\e[32m--\e[36m--\e[37m--\e[36m--\e[32m--\e[33m--\e[35m--\e[34m--\e[31m--\e[34m--\e[35m--\e[33m--\e[32m--\e[36m--\e[37m--\e[36m--\e[32m--\e[33m--\e[m";'
        \ .'env '.env.' quickrun_time '. cmd .' '.args .';'
        \ .qr_end)
  wincmd p
endfunction

"==================================================================================================

" provide commands to change quickrun variables
function! s:key_binding(var, str, ...) abort
  " `cmd!` means modify it
  if exists('a:1') && a:1 ==# '!'
    call feedkeys(":".a:var.' '.eval('b:'.a:var))
  elseif a:str ==# ''
    exe 'let b:'. a:var
  else
    exe 'let b:'. a:var .' =  a:str'
  endif
endfunction

" initialize buffer variables
function! s:init_buffer(ft)
  let b:QuickrunCompiler = has_key(g:quickrun_default_flags[a:ft], 'compiler') ? g:quickrun_default_flags[a:ft].compiler : ''
  let b:QuickrunCompileFlag = has_key(g:quickrun_default_flags[a:ft], 'compileFlags') ? g:quickrun_default_flags[a:ft].compileFlags : ''
  let b:QuickrunDebugCmd = has_key(g:quickrun_default_flags[a:ft], 'debugCmd') ? g:quickrun_default_flags[a:ft].debugCmd : ''
  let b:QuickrunCmd = has_key(g:quickrun_default_flags[a:ft], 'cmd') ? g:quickrun_default_flags[a:ft].cmd : ''
  let b:QuickrunCmdArgs = has_key(g:quickrun_default_flags[a:ft], 'cmdArgs') ? g:quickrun_default_flags[a:ft].cmdArgs : ''
  let b:QuickrunCmdRedir = has_key(g:quickrun_default_flags[a:ft], 'cmdRedir') ? g:quickrun_default_flags[a:ft].cmdRedir : ''
  command! -buffer -bang -nargs=? -complete=file QuickrunCompiler    call s:key_binding('QuickrunCompiler', <q-args>, "<bang>")
  command! -buffer -bang -nargs=? -complete=file QuickrunCompileFlag call s:key_binding('QuickrunCompileFlag', <q-args>, "<bang>")
  command! -buffer -bang -nargs=? -complete=file QuickrunDebugCmd    call s:key_binding('QuickrunDebugCmd', <q-args>, "<bang>")
  command! -buffer -bang -nargs=? -complete=file QuickrunCmd         call s:key_binding('QuickrunCmd', <q-args>, "<bang>")
  command! -buffer -bang -nargs=? -complete=file QuickrunCmdArgs     call s:key_binding('QuickrunCmdArgs', <q-args>, "<bang>")
  command! -buffer -bang -nargs=? -complete=file QuickrunCmdRedir    call s:key_binding('QuickrunCmdRedir', <q-args>, "<bang>")
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
    nnoremap <silent> <F9> :call <SID>toggle_termwin_manually()<cr>

    if has('nvim')
      " au WinEnter * call s:term_enter()
      " au WinLeave * call s:term_leave()
      tnoremap <esc> <c-\><c-n>
    endif

    au BufLeave *.input if &modified == 1 | w | endif
    au TermEnter * setlocal list norelativenumber
  augroup END
endfunction

" more detail in autoload/SpaceVim/plugins/runner.vim and autoload/SpaceVim/mapping/space.vim
