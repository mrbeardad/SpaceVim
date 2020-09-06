"=============================================================================
" c.vim --- SpaceVim lang#c layer
" Copyright (c) 2016-2020 Wang Shidong & Contributors
" Author: Wang Shidong < wsdjeg at 163.com >
" URL: https://spacevim.org
" License: GPLv3
"=============================================================================


""
" @section lang#c, layer-lang-c
" @parentsection layers
" This layer provides C family language code completion and syntax checking.
" Requires clang.
"
" Configuration for `tweekmonster/deoplete-clang2`:
"
"   1. Set the compile flags:
"
"       `let g:deoplete#sources#clang#flags = ['-Iwhatever', ...]`
"
"   2. Set the path to the clang executable:
" 
"       `let g:deoplete#sources#clang#executable = '/usr/bin/clang'
"
"   3. `g:deoplete#sources#clang#autofill_neomake` is a boolean that tells this
"       plugin to fill in the `g:neomake_<filetype>_clang_maker` variable with the
"       clang executable path and flags. You will still need to enable it with
"       `g:neomake_<filetype>_enabled_make=['clang']`.
"
"   4. Set the standards for each language:
"       `g:deoplete#sources#clang#std` is a dict containing the standards you want
"       to use. It's not used if you already have `-std=whatever` in your flags. The
"       defaults are:
" >
"       {
"           'c': 'c11',
"           'cpp': 'c++1z',
"           'objc': 'c11',
"           'objcpp': 'c++1z',
"       }
" <
"   5. `g:deoplete#sources#clang#preproc_max_lines` sets the
"      maximum number of lines to search for an #ifdef or #endif
"      line. #ifdef lines are discarded to get completions within
"      conditional preprocessor blocks. The default is 50, 
"      setting it to 0 disables this feature.
"



if exists('s:clang_executable')
  finish
else
  let s:clang_executable = 'clang'
endif
let s:SYSTEM = SpaceVim#api#import('system')
let s:CPT = SpaceVim#api#import('vim#compatible')


function! SpaceVim#layers#lang#c#plugins() abort
  let plugins = []
  call add(plugins, ['skywind3000/vim-cppman'])
  call add(plugins, ['agatan/vim-sort-include'])
  if !SpaceVim#layers#lsp#check_filetype('c') && !SpaceVim#layers#lsp#check_filetype('cpp')
    if g:spacevim_autocomplete_method ==# 'deoplete'
      call add(plugins, ['Shougo/deoplete-clangx', {'merged' : 0}])
    elseif g:spacevim_autocomplete_method ==# 'ycm'
      " no need extra plugins
    elseif g:spacevim_autocomplete_method ==# 'completor'
      " no need extra plugins
    elseif g:spacevim_autocomplete_method ==# 'asyncomplete'
      call add(plugins, ['wsdjeg/asyncomplete-clang.vim', {'merged' : 0, 'loadconf' : 1}])
    else
      call add(plugins, ['Rip-Rip/clang_complete'])
    endif
  endif

  if s:enable_clang_syntax
    " chromatica is for neovim with py3
    " clamp is for neovim rpcstart('python', " [s:script_folder_path.'/../python/engine.py'])]
    " clighter8 is for vim8
    " clighter is for old vim
    if has('nvim')
      if s:CPT.has('python3') && SpaceVim#util#haspy3lib('clang')
        call add(plugins, ['arakashic/chromatica.nvim', { 'merged' : 0}])
      else
        call add(plugins, ['bbchung/Clamp', { 'if' : has('python')}])
      endif
    elseif has('job')
      call add(plugins, ['bbchung/clighter8', { 'if' : has('python')}])
    else
      call add(plugins, ['bbchung/clighter', { 'if' : has('python')}])
    endif
  else
    call add(plugins, ['mrbeardad/vim-cpp-enhanced-highlight', { 'merged' : 0}])
  endif
  return plugins
endfunction

function! SpaceVim#layers#lang#c#config() abort
  let g:cppman_open_mode = '<auto>'
  let g:cpp_class_scope_highlight = 1
  let g:cpp_member_variable_highlight = 1
  let g:cpp_class_decl_highlight = 1
  let g:cpp_concepts_highlight = 1
  let g:cpp_posix_standard = 1
  let g:cpp_experimental_simple_template_highlight = 1      " which works in most cases, but can be a little slow on large files
  " let g:cpp_experimental_template_highlight = 1           " which is a faster implementation but has some corner cases where it doesn't work.
  augroup sort-include
    autocmd!
    autocmd BufWritePre *.{c,cpp,h,hpp} SortInclude
  augroup END
  call SpaceVim#mapping#gd#add('c',
        \ function('s:go_to_def'))
  call SpaceVim#mapping#gd#add('cpp',
        \ function('s:go_to_def'))
  " TODO: add stdin suport flex -t lexer.l | gcc -o lexer.o -xc -
  if exists("g:disable_quickrun") && g:disable_quickrun == 1
    let runner1 = {
          \ 'exe' : 'gcc',
          \ 'targetopt' : '-o',
          \ 'opt' : ['-xc', '-'],
          \ 'usestdin' : 1,
          \ }
    call SpaceVim#plugins#runner#reg_runner('c', [runner1, '#TEMP#'])
    call SpaceVim#mapping#space#regesit_lang_mappings('c', function('s:language_specified_mappings'))
    let runner2 = {
          \ 'exe' : 'g++',
          \ 'targetopt' : '-o',
          \ 'opt' : ['-xc++', '-'],
          \ 'usestdin' : 1,
          \ }
    call SpaceVim#plugins#runner#reg_runner('cpp', [runner2, '#TEMP#'])
  endif
  if !empty(s:c_repl_command)
    call SpaceVim#plugins#repl#reg('c', s:c_repl_command)
  else
    call SpaceVim#plugins#repl#reg('c', 'igcc')
  endif
  call SpaceVim#mapping#space#regesit_lang_mappings('cpp', funcref('s:language_specified_mappings'))
  call SpaceVim#plugins#projectmanager#reg_callback(funcref('s:update_clang_flag'))
  if executable('clang')
    let g:neomake_c_enabled_makers = ['clang']
    let g:neomake_cpp_enabled_makers = ['clang']
  endif
  let g:chromatica#enable_at_startup = 0
  let g:clighter_autostart           = 0
  augroup SpaceVim_lang_c
    autocmd!
    if s:enable_clang_syntax
      if has('nvim')
        if s:CPT.has('python3') && SpaceVim#util#haspy3lib('clang')
          auto FileType c,cpp  ChromaticaStart
        else
          auto FileType c,cpp  ClampStart
        endif
      elseif has('job')
        auto FileType c,cpp  ClStart
      else
        auto FileType c,cpp  ClighterEnable
      endif
    endif
  augroup END
  call add(g:spacevim_project_rooter_patterns, '.clang')
endfunction

let s:enable_clang_syntax = 0

let s:c_repl_command = ''

function! SpaceVim#layers#lang#c#set_variable(var) abort
  if has_key(a:var, 'clang_executable')
    let g:completor_clang_binary = a:var.clang_executable
    let g:deoplete#sources#clang#executable = a:var.clang_executable
    let g:neomake_c_enabled_makers = ['clang']
    let g:neomake_cpp_enabled_makers = ['clang']
    let s:clang_executable = a:var.clang_executable
    if !has('nvim')
      let g:asyncomplete_clang_executable = a:var.clang_executable
    endif
  endif
  let s:c_repl_command = get(a:var, 'repl_command', '') 
  if has_key(a:var, 'libclang_path')
    if has('nvim')
      if s:CPT.has('python3') && SpaceVim#util#haspy3lib('clang')
        let g:chromatica#libclang_path = a:var.libclang_path
      else
        let g:clamp_libclang_path = a:var.libclang_path
      endif
    else
      let g:asyncomplete_clang_libclang_path = a:var.libclang_path
      if has('job')
        let g:clighter8_libclang_path = a:var.libclang_path
      else
        let g:clighter_libclang_file = a:var.libclang_path
      endif
    endif
  endif

  let s:enable_clang_syntax = get(a:var, 'enable_clang_syntax_highlight', s:enable_clang_syntax)
endfunction

"================================================================
" => QuickRun
"================================================================
" 初始化变量
let s:bufnr = 0
let g:quickrun_Path = {}
function! SpaceVim#layers#lang#c#quickrun_init()
  let b:QuickRun_Args = ''
  let b:QuickRun_Redirect = ''
  if &ft ==# 'c'
    let b:QuickRun_CompileFlag = get(g:, 'quickrun_c_default_compile_flag', '-std=c11')
  elseif &ft ==# 'cpp'
    let b:QuickRun_CompileFlag = get(g:, 'quickrun_cpp_default_compile_flag', '-std=c++17')
  endif
endfunction
au! FileType c,cpp call SpaceVim#layers#lang#c#quickrun_init()

" Quickrun Command
function! SpaceVim#layers#lang#c#quickrun_do(var, str) abort
  if a:str ==# ''
    exe 'let '. a:var
  else
    exe 'let '. a:var .' =  a:str'
  endif
endfunction
command! -nargs=? -complete=file QuickrunArgs call SpaceVim#layers#lang#c#quickrun_do('b:QuickRun_Args', <q-args>)
command! -nargs=? -complete=file QuickrunRedirect call SpaceVim#layers#lang#c#quickrun_do('b:QuickRun_Redirect', <q-args>)
command! -nargs=? -complete=file QuickrunCompileFlag call SpaceVim#layers#lang#c#quickrun_do('b:QuickRun_CompileFlag', <q-args>)

function! s:open_win() abort
    belowright 12 split __quickrun__
    setlocal buftype=nofile bufhidden=wipe nobuflisted list nomodifiable noim
          \ noswapfile
          \ nowrap
          \ cursorline
          \ nospell
          \ nu
          \ norelativenumber
          \ winfixheight
          \ nomodifiable
endfunction

function! s:get_timestamp(cfile)
python3 << EOF
import time
import datetime
import os
filePath = vim.eval('a:cfile')
vim.command("let l:tmp = '" + time.strftime('%M:%H:%S', time.localtime(os.path.getmtime(filePath))) + "'")
EOF
  return l:tmp
endfunction

function! s:add_arguments()
  let cntr = 0
  let g:quickrun_compileflag_extension_regex = get(g:, 'quickrun_compileflag_extension_regex', [])
  let g:quickrun_compileflag_extension_flass = get(g:, 'quickrun_compileflag_extension_flags', [])
  for ext_qr_cf_grep in g:quickrun_compileflag_extension_regex
    if execute('g/'.ext_qr_cf_grep.'/echo 1') =~# '1'
      let ret = g:quickrun_compileflag_extension_flags[cntr]
    endif
    let cntr += 1
  endfor
  if exists('ret')
    return ret
  else
    return ''
  endif
endfunction

function! SpaceVim#layers#lang#c#QuickRun()
  let qr_args = b:QuickRun_Args
  let qr_rd = b:QuickRun_Redirect
  let qr_cf = b:QuickRun_CompileFlag
  let qr_cf = qr_cf .' -I. -I'.SpaceVim#plugins#projectmanager#current_root() .'include ' . s:add_arguments()

  if s:bufnr != 0 && bufexists(s:bufnr) " close last opend Quickrun terminal window
    execute 'bd! ' . s:bufnr
  endif
  let QuickRun_CFILE = expand('%:p')    " absolute path for source file
  " 若当前文件为改动，且之前通过QuickRun运行过，且自上次编译之后未改动过文件内容，则直接运行上次编译的可执行文件；否则重新编译
  if &modified ==# '0' && has_key(g:quickrun_Path, QuickRun_CFILE) && g:quickrun_Path[QuickRun_CFILE] =~# s:get_timestamp(QuickRun_CFILE)
    call s:open_win()
    execute 'call termopen("vim-quickrun.sh -r '. g:quickrun_Path[QuickRun_CFILE] .' '.  qr_args.' \"'.qr_rd .'\"")'
  else
    if &modified ==# '1'
      write
    endif
    let g:quickrun_Path[QuickRun_CFILE] = '/tmp/QuickRun/'. expand('%:t') .'.'. s:get_timestamp(QuickRun_CFILE)
    let fileT=&ft
    call s:open_win()
    if fileT ==# 'c'
      execute 'call termopen("vim-quickrun.sh -c \"'. qr_cf .'\" '. QuickRun_CFILE .' '. g:quickrun_Path[QuickRun_CFILE] .' '.  qr_args .' \"'. qr_rd .'\"")'
    elseif fileT ==# 'cpp'
      execute 'call termopen("vim-quickrun.sh -C \"'. qr_cf .'\" '. QuickRun_CFILE .' '. g:quickrun_Path[QuickRun_CFILE] .' '.  qr_args .' \"'. qr_rd .'\"")'
    endif
  endif
  let s:bufnr=bufnr('%')
  wincmd p
endfunction

let g:QuickRun_InputWin = 0
function! SpaceVim#layers#lang#c#OpenInputWin()
  if g:QuickRun_InputWin !=# '0' && bufexists(g:QuickRun_InputWin)

  endif
  let originWinnr = win_getid()
  py3 import tempfile
  let inputFileName = py3eval('tempfile.gettempdir()') . '/' . expand('%:t:r') . '.input'
  exe "QuickrunRedirect < ".inputFileName
  let defxWinNr = win_findbuf( buffer_number('[defx] -0'))
  if defxWinNr != []
    call win_gotoid(defxWinNr[0])
  else
    Defx
  endif
  exe 'abo 20 split ' . inputFileName
  setlocal nobuflisted ft=Input
        \ noswapfile
        \ nowrap
        \ cursorline
        \ nospell
        \ nu
        \ norelativenumber
        \ winfixheight
  let g:QuickRun_InputWin=bufnr('%')
  call win_gotoid(originWinnr)
endfunction

au BufLeave *.input w

function! SpaceVim#layers#lang#c#TurnoffQuickrun()
    if s:bufnr != 0 && bufexists(s:bufnr)
        execute 'bd! ' . s:bufnr
        let &l:statusline = SpaceVim#layers#core#statusline#get(1)
    endif
endfunction

let g:quickrun_disable_auto_launch_gdb = get(g:, 'quickrun_disable_auto_launch_gdb', '0')
function! SpaceVim#layers#lang#c#openGDB(a,...)
  if g:quickrun_disable_auto_launch_gdb != 0
    return
  endif
  if $TMUX == ''
    echoerr 'You need run your neovim in tmux!'
    return 1
  endif
  if executable('cgdb')
    call jobstart("tmux new-window 'cgdb ". expand('%:p:r') ."'")
  elseif executable('gdb')
    exe jobstart("tmux new-window 'gdb -tui ". expand('%:p:r') ."'")
  endif
endfunction

function! SpaceVim#layers#lang#c#compile4debug()
  let qr_cf = b:QuickRun_CompileFlag
  let qr_cf = qr_cf .' -I. -I'.SpaceVim#plugins#projectmanager#current_root() .'/include ' . s:add_arguments()

  if &modified == 1
      write
  endif
  let ELF_FILE = expand('%:p:r')
  let CFILE = expand('%:p')
  if &modified == 0 && execute('!test '. ELF_FILE .' -nt '. CFILE .' ; echo $?') =~ 0
    call SpaceVim#layers#lang#c#openGDB(1)
  else
    if &ft == 'cpp'
        call jobstart('g\++ '. qr_cf .' -Og -g3 -fno-inline -I. -o ' . expand('%:p:r') . ' ' . expand('%'), {'on_exit':'SpaceVim#layers#lang#c#openGDB'})
    elseif &ft == 'c'
        call jobstart('gcc '. qr_cf .' -Og -g3 -fno-inline -I. -o ' . expand('%:p:r') . ' ' . expand('%'), {'on_exit':'SpaceVim#layers#lang#c#openGDB'})
    else
        echoerr 'need c/cpp filetype'
    endif
  endif
endfunction

function! Term_Enter()
  if buffer_name() =~# 'term://'
    call feedkeys("\<c-\>\<c-n>:call setpos('.', b:pos)\<cr>")
  endif
endfunction

" 终端模式
if has('nvim')
  tnoremap <esc> <c-\><c-n>
  " tnoremap <c-up> <c-\><c-n><c-up>
  " tnoremap <c-down> <c-\><c-n><c-down>
  " tnoremap <c-right> <c-\><c-n><c-right>
  " tnoremap <c-left> <c-\><c-n><c-left>
  " tnoremap <c-w> <c-\><c-n><c-w>
  " tnoremap <silent><tab> <c-\><c-n>:winc w<cr>
  " tnoremap <silent><s-tab> <c-\><c-n>:winc p<cr>
  " tnoremap <c-a> <c-\><c-n><home>
  " tnoremap <c-e> <c-\><c-n><end>
  " tnoremap <up> <c-\><c-n><up>
  " tnoremap <down> <c-\><c-n><down>
  " tnoremap <left> <c-\><c-n><left>
  " tnoremap <right> <c-\><c-n><right>
  " tnoremap <silent><s-down> :call <SID>Scroll(1)<cr>
  " tnoremap <silent><s-up> :call <SID>Scroll(0)<cr>
  au WinEnter * call Term_Enter()
  au WinLeave * let b:pos = getcurpos()
  au TermEnter * setlocal list nu norelativenumber
endif


function! s:language_specified_mappings() abort
  if exists("g:disable_quickrun") && g:disable_quickrun == 1
    call SpaceVim#mapping#space#langSPC('nmap', ['l','r'],
          \ 'call SpaceVim#plugins#runner#open()',
          \ 'execute current file', 1)
  else
    call SpaceVim#mapping#space#langSPC('nmap', ['l','r'],
          \ 'call SpaceVim#layers#lang#c#QuickRun()',
          \ 'execute current file', 1)
    call SpaceVim#mapping#space#langSPC('nmap', ['l','i'],
          \ 'call SpaceVim#layers#lang#c#OpenInputWin()',
          \ 'open input window', 1)
    call SpaceVim#mapping#space#langSPC('nmap', ['l','c'],
          \ 'call SpaceVim#layers#lang#c#TurnoffQuickrun()',
          \ 'close quickrun terminal', 1)
    call SpaceVim#mapping#space#langSPC('nmap', ['l','d'],
          \ ':call SpaceVim#layers#lang#c#compile4debug()<cr><cr>',
          \ 'compile for debug', 0)
  endif

  nnoremap <silent><buffer> K :exe "Cppman ". expand('<cword>')<cr>

  if SpaceVim#layers#lsp#check_filetype('c')
    nnoremap <silent><buffer> K :call SpaceVim#lsp#show_doc()<CR>

    call SpaceVim#mapping#space#langSPC('nnoremap', ['l', 'd'],
          \ 'call SpaceVim#lsp#show_doc()', 'show_document', 1)
    call SpaceVim#mapping#space#langSPC('nnoremap', ['l', 'e'],
          \ 'call SpaceVim#lsp#rename()', 'rename symbol', 1)
    call SpaceVim#mapping#space#langSPC('nnoremap', ['l', 'f'],
          \ 'call SpaceVim#lsp#references()', 'references', 1)

    " these work for now with coc.nvim only

    call SpaceVim#mapping#space#langSPC('nnoremap', ['l', 'i'],
          \ 'call SpaceVim#lsp#go_to_impl()', 'implementation', 1)
    call SpaceVim#mapping#space#langSPC('nnoremap', ['l', 't'],
          \ 'call SpaceVim#lsp#go_to_typedef()', 'type definition', 1)
    call SpaceVim#mapping#space#langSPC('nnoremap', ['l', 'R'],
          \ 'call SpaceVim#lsp#refactor()', 'refactor', 1)
    " TODO this should be gD
    call SpaceVim#mapping#space#langSPC('nnoremap', ['l', 'D'],
          \ 'call SpaceVim#lsp#go_to_declaration()', 'declaration', 1)

  endif
  let g:_spacevim_mappings_space.l.s = {'name' : '+Send'}
  call SpaceVim#mapping#space#langSPC('nmap', ['l','s', 'i'],
        \ 'call SpaceVim#plugins#repl#start("c")',
        \ 'start REPL process', 1)
  call SpaceVim#mapping#space#langSPC('nmap', ['l','s', 'l'],
        \ 'call SpaceVim#plugins#repl#send("line")',
        \ 'send line and keep code buffer focused', 1)
  call SpaceVim#mapping#space#langSPC('nmap', ['l','s', 'b'],
        \ 'call SpaceVim#plugins#repl#send("buffer")',
        \ 'send buffer and keep code buffer focused', 1)
  call SpaceVim#mapping#space#langSPC('nmap', ['l','s', 's'],
        \ 'call SpaceVim#plugins#repl#send("selection")',
        \ 'send selection and keep code buffer focused', 1)
endfunction


function! s:update_clang_flag() abort
  if filereadable('.clang')
    let argvs = readfile('.clang')
    call s:update_checkers_argv(argvs, ['c', 'cpp'])
    call s:update_autocomplete_argv(argvs, ['c', 'cpp'])
    call s:update_neoinclude(argvs, ['c', 'cpp'])
  endif
endfunction

if g:spacevim_enable_neomake && g:spacevim_enable_ale == 0
  function! s:update_checkers_argv(argv, fts) abort
    for ft in a:fts
      let g:neomake_{ft}_clang_maker = {
            \ 'args': ['-fsyntax-only', '-Wall', '-Wextra', '-I./'] + a:argv,
            \ 'exe' : s:clang_executable,
            \ 'errorformat':
            \ '%-G%f:%s:,' .
            \ '%f:%l:%c: %trror: %m,' .
            \ '%f:%l:%c: %tarning: %m,' .
            \ '%I%f:%l:%c: note: %m,' .
            \ '%f:%l:%c: %m,'.
            \ '%f:%l: %trror: %m,'.
            \ '%f:%l: %tarning: %m,'.
            \ '%I%f:%l: note: %m,'.
            \ '%f:%l: %m'
            \ }
    endfor
  endfunction
elseif g:spacevim_enable_ale
  function! s:update_checkers_argv(argv, fts) abort
    " g:ale_c_clang_options
    for ft in a:fts
      let g:ale_{ft}_clang_options = ' -fsyntax-only -Wall -Wextra -I./ ' . join(a:argv, ' ')
      let g:ale_{ft}_clang_executable = s:clang_executable
    endfor
  endfunction
else
  function! s:update_checkers_argv(argv, fts) abort

  endfunction
endif

function! s:update_autocomplete_argv(argv, fts) abort

endfunction

function! s:update_neoinclude(argv, fts) abort
  if s:SYSTEM.isLinux
    let path = '.,/usr/include,,' 
  else
    let path = '.,,' 
  endif
  for argv in a:argv
    if argv =~# '^-I'
      let path .= ',' . argv[2:]
    endif
  endfor
  let b:neoinclude_paths = path
endfunction

function! s:go_to_def() abort
  if !SpaceVim#layers#lsp#check_filetype(&ft)
    execute "norm! g\<c-]>"
  else
    call SpaceVim#lsp#go_to_def()
  endif
endfunction
