"=============================================================================
" init.vim --- Entry file for neovim
" Copyright (c) 2016-2020 Wang Shidong & Contributors
" Author: Wang Shidong < wsdjeg@outlook.com >
" URL: https://spacevim.org
" License: GPLv3
"=============================================================================

  " ==================================
  " CUSTOM: runner Before
  " ==================================
  let g:quickrun_default_flags = {
      \ 'python': {
          \ 'compiler': '',
          \ 'compileFlags': '',
          \ 'debugCompileFlags': '',
          \ 'extRegex': [],
          \ 'extFlags': [],
          \ 'cmd': '/bin/python ${thisFile}',
          \ 'cmdArgs': '',
          \ 'cmdRedir': '',
          \ 'debugCmd': ''
      \ },
      \ 'c': {
          \ 'compiler': 'gcc',
          \ 'compileFlags': '-std=c11 -I. -I${workspaceFolder}include -o ${exeFile} ${thisFile}',
          \ 'debugCompileFlags': '-Og -g3 -std=c17 -I. -I${workspaceFolder}include -o ${exeFile} ${thisFile}',
          \ 'extRegex': [],
          \ 'extFlags': [],
          \ 'cmd': '${exeFile}',
          \ 'cmdArgs': '',
          \ 'cmdRedir': '',
          \ 'debugCmd': 'cgdb ${exeFile}'
      \ },
      \ 'cpp': {
          \ 'compiler': 'clang\++',
          \ 'compileFlags': '-std=c++17 -I. -I${workspaceFolder}include -o ${exeFile} ${thisFile}',
          \ 'debugCompileFlags': '-Og -g3 -fno-inline -std=c++17 -I. -I${workspaceFolder}include -o ${exeFile} ${thisFile}',
          \ 'extRegex': [
              \ '^#\s*include\s*<future>',
              \ '^#\s*include\s*<mysql++.*>'
          \ ],
          \ 'extFlags': [
              \ '-lpthread',
              \ '-I/usr/include/mysql -lmysqlpp'
          \ ],
          \ 'cmd': '${exeFile}',
          \ 'cmdArgs': '',
          \ 'cmdRedir': '',
          \ 'debugCmd': '!tmux new-window "cgdb ${exeFile}"'
      \ }
  \ }
execute 'source' fnamemodify(expand('<sfile>'), ':h').'/config/main.vim'
