"=============================================================================
" quickrun.vim --- code quickrun for SpaceVim
" Copyright (c) 2016-2020 Heachen Bear
" Author: Heachen Bear < mrbeardad@qq.com >
" URL: https://spacevim.org
" License: GPLv3
"=============================================================================

function! s:open_termwin() abort
  if s:bufnr != 0 && bufexists(s:bufnr)
    execute 'bd! ' . s:bufnr
  endif
  if execute('echo winlayout()') =~# s:last_input_winid
    exe 'bd '.winbufnr(s:last_input_winid)
    let inputFile = expand('%:t')
  endif
  belowright 10 split __quickrun__
  setlocal buftype=nofile bufhidden=wipe nobuflisted list nomodifiable noim
        \ noswapfile
        \ nowrap
        \ cursorline
        \ nospell
        \ nomodifiable
        \ winfixheight
  if exists('inputFile')
    exe 'silent belowright vert 30 split ' . inputFile . '.input'
    setlocal nobuflisted ft=Input
        \ noswapfile
        \ nowrap
        \ cursorline
        \ nospell
        \ nu
        \ norelativenumber
        \ winfixheight
    let s:last_input_winid = win_getid()
    winc p 
  endif
endfunction

function! s:get_timestamp(file)
  return py3eval('time.strftime("%M:%S:%H", time.localtime(os.path.getmtime("'.expand('%:p').'")))')
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
  if &modified == 1 | write | endif
  let src_file_path = expand('%:p')
  let exe_file_path = g:QuickrunTmpdir . expand('%:t') .'.'. s:get_timestamp(src_file_path).'.exe'
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

  if force_compile == 1 || &modified == 1 || !filereadable(exe_file_path) " need compilation
    let qr_prepare = qr_begin . qr_compile . qr_prepare
  else  " run directly
    let qr_prepare = qr_begin . qr_prepare . 'echo -e "\e[1;33m[Note]: Neither the buffer nor the file timestamp has changed. Rerunning last compiled program!\e[m";'
  endif

  let win = win_getid()
  call s:open_termwin()
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
  let s:bufnr = bufnr('%')
  call win_gotoid(win)
endfunction

function! SpaceVim#plugins#quickrun#run_task(cmd, opts, isBackground) abort
  call s:open_termwin()
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
  let s:bufnr = bufnr('%')
  wincmd p
endfunction

let s:last_input_winid = -1
function! SpaceVim#plugins#quickrun#OpenInputWin()
  let inputfile = expand('%:t') . '.input'
  let b:QuickrunCmdRedir = '< '.inputfile
  if execute('echo winlayout()') =~# s:last_input_winid
    exe 'bd '.winbufnr(s:last_input_winid)
  endif

  let termWinNr = win_findbuf(s:bufnr)
  if termWinNr != []
    call win_gotoid(termWinNr[0])
    exe 'silent belowright vert 30 split ' . inputfile
  else
    exe 'silent belowright 10 split ' . inputfile
  endif

  setlocal nobuflisted ft=Input
      \ noswapfile
      \ nowrap
      \ cursorline
      \ nospell
      \ nu
      \ norelativenumber
      \ winfixheight
  let s:last_input_winid = win_getid()
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
  py3 import tempfile

  " build temporary directory
  let s:bufnr = 0
  let g:QuickrunTmpdir = get(g:,'QuickrunTmpdir',py3eval('tempfile.gettempdir()') . '/Quickrun/')
  if !isdirectory(g:QuickrunTmpdir)
    call mkdir(g:QuickrunTmpdir)
  endif

  " set autocmds
  augroup Quickrun
    for thisFT in keys(g:quickrun_default_flags)
      exe 'autocmd FileType '.thisFT.' call s:init_buffer(&ft)'
    endfor

    if has('nvim')
      au WinEnter * call s:term_enter()
      au WinLeave * let b:quickrun_term_pos = getcurpos()
      tnoremap <esc> <c-\><c-n>
    endif

    au BufLeave *.input w
    au TermEnter * setlocal list norelativenumber
  augroup END
endfunction

" more detail in autoload/SpaceVim/plugins/runner.vim and autoload/SpaceVim/mapping/space.vim
