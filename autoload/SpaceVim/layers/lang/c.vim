"=============================================================================
" c.vim --- SpaceVim lang#c layer
" Copyright (c) 2016-2019 Wang Shidong & Contributors
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
    call add(plugins, ['octol/vim-cpp-enhanced-highlight', { 'merged' : 0}])
    let g:cpp_class_scope_highlight = 1
    let g:cpp_member_variable_highlight = 1
    let g:cpp_class_decl_highlight = 1
    let g:cpp_concepts_highlight = 1
    let g:cpp_posix_standard = 1
    let g:cpp_experimental_simple_template_highlight = 1      " which works in most cases, but can be a little slow on large files
    " let g:cpp_experimental_template_highlight = 1           " which is a faster implementation but has some corner cases where it doesn't work.
  endif
  return plugins
endfunction

function! SpaceVim#layers#lang#c#config() abort
  call SpaceVim#mapping#gd#add('c',
        \ function('s:go_to_def'))
  call SpaceVim#mapping#gd#add('cpp',
        \ function('s:go_to_def'))
  " TODO: add stdin suport flex -t lexer.l | gcc -o lexer.o -xc -
  " let runner1 = {
  "       \ 'exe' : 'gcc',
  "       \ 'targetopt' : '-o',
  "       \ 'opt' : ['-xc', '-'],
  "       \ 'usestdin' : 1,
  "       \ }
  " call SpaceVim#plugins#runner#reg_runner('c', [runner1, '#TEMP#'])
  " call SpaceVim#mapping#space#regesit_lang_mappings('c', function('s:language_specified_mappings'))
  " let runner2 = {
  "       \ 'exe' : 'g++',
  "       \ 'targetopt' : '-o',
  "       \ 'opt' : ['-xc++', '-'],
  "       \ 'usestdin' : 1,
  "       \ }
  " call SpaceVim#plugins#runner#reg_runner('cpp', [runner2, '#TEMP#'])
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

"================================
" => QuickRun配置
"================================
tmap <esc> <c-\><c-n>
tmap <c-up> <esc><c-up>
tmap <c-down> <esc><c-down>
tmap <c-right> <esc><c-right>
tmap <c-left> <esc><c-left>
tmap <c-w> <esc><c-w>
tmap <silent><tab> <esc>:winc w<cr>
tmap <silent><s-tab> <esc>:winc p<cr>
tmap <c-a> <esc><home>
tmap <c-e> <esc><end>
tmap <c-f> <esc><c-f>
tmap <c-b> <esc>10<c-y>
tmap <up> <esc><up>
tmap <down> <esc><down>
tmap <left> <esc><left>
tmap <right> <esc><right>

function! SpaceVim#layers#lang#c#quickrun_do(var, str) abort
  if a:str == '' && !call("exists",[a:var])
    if a:var == 'b:QuickRun_cpp_CompileFlag'
      let b:QuickRun_cpp_CompileFlag = get(g:, 'ale_and_quickrun_cpp_default_compile_flag', '-std=c++20')
    else
      exe 'let '.a:var.'=""'
    endif
    exe 'let '. a:var
  else
    exe 'let '. a:var .' =  a:str'
  endif
endfunction
command! -nargs=? QuickrunArgs call SpaceVim#layers#lang#c#quickrun_do('b:QuickRun_Args', <q-args>)
command! -nargs=? -complete=file QuickrunRedirect call SpaceVim#layers#lang#c#quickrun_do('b:QuickRun_Redirect', <q-args>)
command! -nargs=? QuickrunCompileFlag call SpaceVim#layers#lang#c#quickrun_do('b:QuickRun_cpp_CompileFlag', <q-args>)

let s:bufnr = 0
let g:quickrun_Path = {}
au TermEnter * setlocal  list nu norelativenumber

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
  let tmp = execute("!ls -tl --time-style='+\\%M\\%H\\%S' ". a:cfile ." | cut -d' ' -f 6")  
  return substitute(tmp, '.*\(\d\d\d\d\d\d\).*', '\1', 'g')
endfunction

function! SpaceVim#layers#lang#c#QuickRun()
    if !exists('b:QuickRun_Args')
      let b:QuickRun_Args = ''
    endif
    if !exists('b:QuickRun_Redirect')
      let b:QuickRun_Redirect = ''
    endif
    if !exists('b:QuickRun_cpp_CompileFlag')
      let b:QuickRun_cpp_CompileFlag = get(g:, 'ale_and_quickrun_cpp_default_compile_flag', '-std=c++20')
    endif
    let qr_args = b:QuickRun_Args
    let qr_rd = b:QuickRun_Redirect
    let qr_cf = b:QuickRun_cpp_CompileFlag

    if s:bufnr != 0 && bufexists(s:bufnr)
        execute 'bd! ' . s:bufnr
    endif
    let QuickRun_CFILE = expand('%:p')    " 需要编译的文件全路径
    if &modified == 0 && has_key(g:quickrun_Path, QuickRun_CFILE) && g:quickrun_Path[QuickRun_CFILE] =~ s:get_timestamp(QuickRun_CFILE)
        call s:open_win()
        execute 'call termopen("vim-quickrun.sh -r '. g:quickrun_Path[QuickRun_CFILE] .' '.  qr_args.' \"'.qr_rd .'\"")'
        " echo 'call termopen("vim-quickrun.sh -r '. g:quickrun_Path[QuickRun_CFILE] .' '.  qr_args.' \"'.qr_rd .'\"")'
    else
        write
        let g:quickrun_Path[QuickRun_CFILE] = '/tmp/QuickRun/'. expand('%:t') .'.'. s:get_timestamp(QuickRun_CFILE)
        let fileT=&ft
        call s:open_win()
        if fileT == 'c'
            execute 'call termopen("vim-quickrun.sh -c -std=c11'. QuickRun_CFILE .' '. g:quickrun_Path[QuickRun_CFILE] .' '.  qr_args .' \"'. qr_rd .'\"")'
        elseif fileT == 'cpp'
            execute 'call termopen("vim-quickrun.sh -C \"'. qr_cf .'\" '. QuickRun_CFILE .' '. g:quickrun_Path[QuickRun_CFILE] .' '.  qr_args .' \"'. qr_rd .'\"")'
            " echo 'call termopen("vim-quickrun.sh -C \"'. qr_cf .'\" '. QuickRun_CFILE .' '. g:quickrun_Path[QuickRun_CFILE] .' '.  qr_args .' \"'. qr_rd .'\"")'
        else
            echoerr 'need c/cpp filetype'
        endif
    endif
    let s:bufnr=bufnr('%')
    wincmd p
endfunction

let g:QuickRun_InputWin = 0
function! SpaceVim#layers#lang#c#OpenInputWin()
    if g:QuickRun_InputWin != 0 && bufexists(g:QuickRun_InputWin)
        execute 'bd! ' . g:QuickRun_InputWin
    endif
    let originWinnr = win_getid()
    let inputFileName = '/tmp/' . expand('%:t:r') . '.input'
    let defxWinNr = win_findbuf( buffer_number('[defx] -0'))
    if defxWinNr != []
        call win_gotoid(defxWinNr[0])
    else
        Defx
    endif
    exe 'abo 20 split ' . inputFileName
    setlocal bufhidden=wipe nobuflisted list ft=Input
          \ noswapfile
          \ nowrap
          \ cursorline
          \ nospell
          \ nu
          \ norelativenumber
          \ winfixheight
    let g:QuickRun_InputWin=bufnr('%')
    let g:QuickRun_Redirect = "< ".inputFileName
    call win_gotoid(originWinnr)
endfunction

function! Sort_Includes()
  let nr = str2nr(substitute(execute("w !awk '/^\\\#include/{++cnt;} \\!/^\\\#include/{printf cnt; exit 0;}'"),'\n','','g'))
  if nr > 1
    let line = line('.')
    let col = col('.')
    exe '1,'.nr.' !sort'
    call cursor(line, col)
  endif
endfunction
au BufWritePre *.c,*.cpp call Sort_Includes()

function! SpaceVim#layers#lang#c#TurnoffQuickrun()
    if s:bufnr != 0 && bufexists(s:bufnr)
        execute 'bd! ' . s:bufnr
        let &l:statusline = SpaceVim#layers#core#statusline#get(1)
    endif
endfunction

function! SpaceVim#layers#lang#c#ClangCompile()
    if &modified == 1
        write
    endif
    if &ft == 'cpp'
        execute '!clang++ -std=c++17 -O3 -I. -o ' . expand('%:r') . ' ' . expand('%')
    elseif &ft == 'c'
        execute '!clang -std=c11 -O3 -I. -o ' . expand('%:r') . ' ' . expand('%')
    else
        echoerr 'need c/cpp filetype'
    endif
endfunction
function! SpaceVim#layers#lang#c#compile4debug()
    if &modified == 1
        write
    endif
    if &ft == 'cpp'
        execute '!g++ -std=c++17 -Og -g3 -fno-inline -D_GLIBCXX_DEBUG -D_GLIBCXX_DEBUG_PEDANTIC -I. -o ' . expand('%:r') . ' ' . expand('%')
    elseif
        execute '!gcc -std=c11 -Og -g3 -fno-inline -I. -o ' . expand('%:r') . ' ' . expand('%')
    else
        echoerr 'need c/cpp filetype'
    endif
endfunction

autocmd BufLeave *.input w

function! s:language_specified_mappings() abort

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
        \ 'call SpaceVim#layers#lang#c#compile4debug()',
        \ 'compile for debug', 1)
  call SpaceVim#mapping#space#langSPC('nmap', ['l','o'],
        \ 'call SpaceVim#layers#lang#c#ClangCompile()',
        \ 'optimized compile by clang', 1)
  let g:cppman_open_mode = '<auto>'
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
