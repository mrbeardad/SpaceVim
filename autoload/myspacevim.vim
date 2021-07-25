" Copyright (c) 2020-2021 Heachen Bear & Contributors
" File: myspacevim.vim
" License: GPLv3
" Author: Heachen Bear <mrbeardad@qq.com>
" Date: 09.02.2021
" Last Modified Date: 25.07.2021
" Last Modified By: Heache Bear <mrbeardad@qq.com>


function! s:code_runner()
  if g:spacevim_terminal_runner
    let g:quickrun_default_flags = {
        \ 'cpp': {
            \ 'compileCmd': "g++ -g3 -ggdb3 -D_GLIBCXX_DEBUG -I${fileDirname} -I${workspaceFolder}include -o ${execPath} ${file}",
            \ 'extRegex': [
                \ '\v^#\s*include\s*[<"](pthread\.h|future|thread|.*asio\.hpp|.*gtest\.h)[>"]',
                \ '^#\s*include\s*[<"]dlfcn.h[>"]',
                \ '^#\s*include\s*[<"]pty.h[>"]',
                \ '^#\s*include\s*[<"]boost/locale\.hpp[>"]',
                \ '^#\s*include\s*[<"]*asio/ssl\.hpp[>"]',
                \ '^#\s*include\s*[<"](*asio/co_spawn\.hpp\|coroutine)[>"]',
                \ '^#\s*include\s*[<"]glog/.*[>"]',
                \ '^#\s*include\s*[<"]gtest/.*[>"]',
                \ '^#\s*include\s*[<"]gmock/.*[>"]',
                \ '^#\s*include\s*[<"]mysql++/.*[>"]',
                \ '^#\s*include\s*[<"]srchilite/.*[>"]',
                \ '^#\s*include\s*[<"]fmt/.*[>"]',
            \ ],
            \ 'extFlags': [
                \ '-lpthread',
                \ '-ldl',
                \ '-lutil',
                \ '-lboost_locale',
                \ '-lssl -lcrypto',
                \ '-fcoroutines',
                \ '-lglog',
                \ '-lgtest -lgtest_main',
                \ '-lgmock',
                \ '-I/usr/include/mysql -lmysqlpp',
                \ '-lsource-highlight',
                \ '-lfmt',
            \ ],
            \ 'runCmd': '${execPath}'
        \ },
        \ 'c': {
            \ 'compileCmd': 'gcc -std=c11 -I${fileDirname} -I${workspaceFolder}include -o ${execPath} ${file}',
            \ 'runCmd': '${execPath}'
        \ },
        \ 'python': {
            \ 'runCmd': 'python ${file}'
        \},
        \ 'go': {
            \ 'compileCmd': 'go',
            \ 'extRegex': [
              \ '^func\s*main()\s*{',
              \ '^\s*"testing"'
            \],
            \ 'extFlags': [
              \ 'build -o ${execPath} ${file}',
              \ 'test -c -o ${execPath} ${file}'
            \],
            \ 'runCmd': '${execPath}',
            \ 'cwd': '${fileDirname}'
        \ }
    \ }
  endif
endfunction


function! s:autocomplete()
  if g:spacevim_autocomplete_method ==# 'ycm'
    let g:ycm_auto_hover = ''
    let g:ycm_confirm_extra_conf = 0
    let g:ycm_cache_omnifunc = 1
    let g:ycm_clangd_uses_ycmd_caching = 1
    let g:ycm_clangd_args = []
    let g:ycm_gopls_args = []
    let g:ycm_key_invoke_completion = '<C-Z>'
    let g:ycm_seed_identifiers_with_syntax = 1
    let g:ycm_collect_identifiers_from_comments_and_strings = 1
    let g:ycm_update_diagnostics_in_insert_mode = 0

    let g:ycm_filetype_whitelist = {
          \ 'c':1,
          \ 'cpp':1,
          \ 'cmake':1,
          \ 'go':1,
          \ 'python':1,
          \ 'sh':1,
          \ 'vim':1,
          \ }
    let g:ycm_semantic_triggers = {
          \ 'c':['re!\w\w', '.', '->'],
          \ 'cpp':['re!\w\w', '.', '->'],
          \ 'cmake':['re!\w\w'],
          \ 'go':['re!\w\w', '.'],
          \ 'python':['re!\w\w', '.'],
          \ 'sh':['re!\w\w', '-'],
          \ 'vim':['re!\w\w', ':'],
          \ 'VimspectorPrompt': [ '.', '->', ':', '<' ]
          \ }
    let g:ycm_language_server = 
          \ [ 
          \   {
          \     'name': 'vim',
          \     'cmdline': [ 'vim-language-server', '--stdio' ],
          \     'filetypes': [ 'vim' ],
          \    },
          \   {
          \     'name': 'bash',
          \     'cmdline': [ 'bash-language-server', 'start' ],
          \     'filetypes': [ 'sh' ],
          \    },
          \   {
          \     'name': 'cmake',
          \     'cmdline': [ 'cmake-language-server'],
          \     'filetypes': [ 'cmake' ],
          \     'project_root_files': [ 'build' ]
          \    },
          \ ]
    augroup MySpaceVimAutocomplete
      for ft in keys(g:ycm_semantic_triggers)
        exe 'autocmd FileType '.ft.' nnoremap <silent><buffer> gd :YcmCompleter GoTo<CR>'
        exe 'autocmd FileType '.ft.' nnoremap <silent><buffer> gr :YcmCompleter GoToReferences<CR>'
        exe 'autocmd FileType '.ft.' nnoremap <silent><buffer> gD :YcmCompleter GetDoc<CR>'
        exe 'autocmd FileType '.ft." nnoremap <silent><buffer> gR :exe 'YcmCompleter RefactorRename '.input('refactor \"'.expand('<cword>').'\" to:')<cr>"
        exe 'autocmd FileType '.ft.' nnoremap <silent><buffer> gt :YcmCompleter GetType<CR>'
      endfor
    augroup END
  endif
endfunction


function! s:checker()
  if g:spacevim_lint_engine ==# 'ale'
    let g:ale_set_quickfix = 1
    let g:ale_set_loclist = 0
    let g:ale_disable_lsp = 1
    let g:ale_completion_enabled = 0
    let g:ale_set_highlights = 1
    let g:ale_sign_column_always = 1
    let g:ale_lint_on_filetype_changed = 0
    let g:ale_lint_on_text_changed = 'always'
    let g:ale_lint_on_insert_leave = 0
    let g:ale_lint_on_enter = 0
    let g:ale_lint_on_save = 0
    let g:ale_linters_explicit = 1
    let g:ale_linters = {
                \ 'c': ['cppcheck'],
                \ 'cpp': ['cppcheck', 'clangtidy'],
                \ 'go': ['gofmt', 'govet'],
                \ 'python': ['bandit', 'pylint'],
                \ 'sh': ['shellcheck'],
                \ 'vim': ['ale_custom_linting_rules', 'vint'],
                \ }
    let g:ale_echo_msg_format = '[%linter%] %s  [%severity%]'
    let g:ale_cpp_cppcheck_options = '--enable=warning,style,performance,portability'
    let g:ale_cpp_cc_executable = 'gcc'
    let g:ale_cpp_cc_options = '-O2 -I. -fsyntax-only -fcoroutines -Wall -Wextra -Wshadow -Wfloat-equal -Wsign-conversion -Wlogical-op -Wnon-virtual-dtor -Woverloaded-virtual -Wduplicated-cond -Wduplicated-branches -Wnull-dereference -Wuseless-cast -Wdouble-promotion '
    let g:ale_cpp_clangtidy_executable = 'echo'
    let g:ale_cpp_clangtidy_options = ' -I. '
    let g:ale_cpp_clangtidy_checks = ['*',
      \ '-abseil*',
      \ '-android*',
      \ '-darwin*',
      \ '-fuchsia*',
      \ '-linuxkernel*',
      \ '-*osx*',
      \ '-*objc*',
      \ '-openmp*',
      \ '-zircon*',
      \ '-*avoid-c-arrays',
      \ '-*deprecated-headers',
      \ '-llvm-include-order',
      \ '-cppcoreguidelines-pro-bounds-pointer-arithmetic',
      \ '-modernize-use-trailing-return-type',
      \ '-readability-isolate-declaration',
      \ '-*llvmlibc*',
      \ ]
    let g:ale_python_pylint_options = '-d C0103,C0301,C0112,C0115,C0116,C0114'
  endif
endfunction
" called by checker
function! myspacevim#show_detailed_diagnostic() abort
  let bufnr = bufnr('YcmShowDetailedDiagnostic')
  let winid = bufwinid(bufnr)
  if ( winid != -1 )
    exe 'bd! '.bufnr
  endif

  let content = execute('YcmShowDetailedDiagnostic')
  if content =~# 'No diagnostics for current '
    let content = ''
  else
    let content .= "\n\n"
  endif

  let [l:info, l:loc] = ale#util#FindItemAtCursor(bufnr())
  if !empty(l:loc)
    let content .= get(l:loc, 'detail', l:loc.text)
  endif

  let content = split(content, "\n")
  if len(content) == 0
    echom 'No diagnostics for current line.'
    return
  endif

  silent pedit YcmShowDetailedDiagnostic
  wincmd P

  setlocal modifiable
  setlocal noreadonly
  setlocal nobuflisted
  setlocal buftype=nofile
  setlocal bufhidden=wipe
  :%d
  call setline(1, content)
  setlocal nomodifiable
  setlocal readonly

  syntax keyword ErrorMsg error
  syntax keyword WarningMsg warning
  syntax keyword Include note

  winc p
endfunction


function! s:lang_go()
  let g:go_gopls_enabled = 0
  let g:go_def_mapping_enabled = 0
  let g:ctrlp_map = ''
endfunction


function! s:lang_c()
  let g:cppman_open_mode = '<auto>'
  let g:cpp_nofunction_highlight = 1
  let g:cpp_simple_highlight = 0
  let g:c_no_posix_function = 1
  let g:cmake_ycm_symlinks = 1
  let g:disable_protodef_mapping = 1
  call SpaceVim#custom#LangSPC('cpp', 'nnore', ['l'],
        \ 'let ale_cpp_clangtidy_executable = "clang-tidy" | ALELint',
        \ 'Lint with all linters', 1)
  call SpaceVim#custom#LangSPC('cpp', 'nnore', ['p'],
        \ ":set paste\<cr>i\<c-r>=protodef#ReturnSkeletonsFromPrototypesForCurrentBuffer({'includeNS' : 0})\<cr>\<esc>='[:set nopaste\<cr>",
        \ 'protodef in namespace', 0)

  augroup MySpaceVimLangC
    autocmd FileType cpp nnoremap <silent><buffer> K :exe "Cppman ". expand('<cword>')<cr>
    autocmd FileType cpp call myspacevim#set_cpp_std_from_ycm_extra_conf()
    autocmd BufWritePre *.{c,cpp,h,hpp} SortInclude
    autocmd User ALELintPost let g:ale_cpp_clangtidy_executable = 'echo'
  augroup END
endfunction


" called by lang_c
function! myspacevim#set_cpp_std_from_ycm_extra_conf()
  let file = findfile('.ycm_extra_conf.py', '.;'.$HOME)
  if file !=# ''
    exe 'py3file '. file
    for thisFlag in py3eval('Settings()').flags
      if thisFlag =~# '-std='
        let b:lang_cpp_std = thisFlag
      endif
    endfor
  endif
  if get(b:, 'lang_cpp_std', '') ==# ''
    let b:lang_cpp_std = '-std=c++20'
  endif

  let g:ale_cpp_cc_options = b:lang_cpp_std . ' -O2 -I. -fsyntax-only -fcoroutines -Wall -Wextra -Wshadow -Wfloat-equal -Wsign-conversion -Wlogical-op -Wnon-virtual-dtor -Woverloaded-virtual -Wduplicated-cond -Wduplicated-branches -Wnull-dereference -Wuseless-cast -Wdouble-promotion '
  let g:ale_cpp_cppcheck_options = '--enable=warning,style,performance,portability -'.b:lang_cpp_std
  let g:ale_cpp_clangtidy_options = ' -I. ' . b:lang_cpp_std

  let b:QuickrunCompileCmd = substitute(get(g:quickrun_default_flags.cpp, 'compileCmd', ''), '^\(\S*\)', '\1 '.b:lang_cpp_std, '')
endfunction


function! s:edit()
  let g:table_mode_auto_align = 0
  " let g:table_mode_disable_mappings = 1
endfunction


function! s:edit_after()
  let g:splitjoin_split_mapping = ''
  let g:splitjoin_join_mapping = ''
  let g:EasyMotion_smartcase = 1
  xmap v <Plug>(expand_region_expand)
  xmap V <Plug>(expand_region_shrink)
  nmap ds <Plug>Dsurround
  nmap cs <Plug>Csurround
  nmap ys <Plug>Ysurround
  nmap yss <Plug>Yssurround
  inoremap <silent><m-t> <c-r>=tablemode#Toggle()<cr><bs>
  nnoremap <silent><m-t> :call tablemode#Toggle()<cr>
  nnoremap <silent>S :SplitjoinSplit<cr>
  if executable('cloc')
    call SpaceVim#mapping#space#def('nnoremap', ['x', 'c'],
          \ 'exec "!cloc ". expand("%:p")',
          \ 'count in the selection region', 1, 1
          \)
    call SpaceVim#mapping#space#def('nnoremap', ['x', 'C'],
          \ 'exe "!cloc ".SpaceVim#plugins#projectmanager#current_root()',
          \ 'count in the selection region', 1, 1
          \)
  else
    call SpaceVim#mapping#space#def('nnoremap', ['x', 'c'],
          \ 'SourceCounter',
          \ 'count in the selection region', 1, 1
          \)
  endif
  call SpaceVim#mapping#space#def('vmap', ['x', 'c'], '<Plug>CountSelectionRegion', 'count in the selection region', 0, 1)
endfunction


function! s:lang_markdown()
  let g:vim_markdown_no_default_key_mappings = 1
  nmap [[ <Plug>Markdown_MoveToPreviousHeader
  nmap ]] <Plug>Markdown_MoveToNextHeader
  nmap [] <Plug>Markdown_MoveToCurHeader
endfunction


function! s:lang_markdown_after()
  let g:vim_markdown_folding_style_pythonic = 1
  let g:vim_markdown_emphasis_multiline = 0
  let g:vim_markdown_math = 1
  let g:tex_conceal = 'abdmg'
  let g:vim_markdown_strikethrough = 1
  let g:vim_markdown_conceal_code_blocks = 1
  let g:vmt_auto_update_on_save = 1
  let g:mkdp_auto_close = 0
  let g:mkdp_open_to_the_world = 1
  let g:vim_markdown_override_foldtext = 0
  nmap ][ <Plug>Markdown_MoveToParentHeader
  augroup MySpaceVim
    autocmd FileType markdown inoremap <buffer><s-tab> &emsp;
    " if executable('fcitx5')
    "   autocmd FileType markdown inoremap <buffer><silent><c-c> <c-c>:call Fcitx2en()<cr>
    " elseif executable('fcitx')
    "   autocmd FileType markdown inoremap <buffer><silent><c-c> <c-c>:py3 fcitx2en()<cr>
    " else
    "   autocmd FileType markdown iunmap <c-c>
    " endif
    autocmd InsertEnter *.md setl conceallevel=0
    autocmd InsertLeave *.md setl conceallevel=2
  augroup END
endfunction


function! s:leaderf()
  set tags=./.tags;,.tags
  let g:Lf_GtagsAutoGenerate = 1
  let g:Lf_GtagsAutoUpdate = 1
  let g:Lf_GtagsSkipUnreadable = 1
  let g:Lf_WindowHeight = 0.3
  let g:Lf_CacheDirectory = g:spacevim_data_dir.'SpaceVim/'
  let g:Lf_RootMarkers = ['.git', '_darcs', '.hg', '.bzr', '.svn', '.SpaceVim.d']
  let g:Lf_WildIgnore = {
          \ 'dir': ['.svn', '.git', '.hg', 'build'],
          \ 'file': ['*.swap', '*.jpg', '*.png', '*.sw?','~$*','*.bak','*.exe','*.o','*.so','*.py[co]']
          \}
  let g:Lf_IndexTimeLimit = 30
  let g:Lf_UseCache = 0
endfunction


function! s:colorscheme()
  let g:neosolarized_italic = 1
  let g:gruvbox_contrast_dark = 'hard'
  let g:gruvbox_italic = 1
  let g:gruvbox_bold = 1
  let g:gruvbox_italicize_strings = 1
  let g:palenight_terminal_italics = 1
endfunction


function! s:set_neovim_after() abort
  " buffer and window operator
  " 若只设置guide则快捷键输入时会打开导航
  " 若只设置map则打开导航时输入的快捷键无效
  let g:_spacevim_mappings.n = ['bn', 'next buffer']
  nnoremap <silent> <leader>n :bn<cr>
  let g:_spacevim_mappings.b = ['bp', 'previous buffer']
  nnoremap <silent> <leader>b :bp<cr>
  nnoremap <silent><c-w>x :let bufnr_for_delete_with_ctrl_w_x = buffer_number()<cr>:bp<cr>:exe 'bd '.bufnr_for_delete_with_ctrl_w_x<cr>
  nnoremap <silent> <c-w>W :w !sudo tee % > /dev/null<CR><CR>
  nnoremap <silent> Q :<c-b>call <SID>close_window('<c-e>')<cr>
  nnoremap <silent><tab> :winc w<cr>
  nnoremap <silent><s-tab> :winc W<cr>
  nnoremap <silent><s-Right> >>
  nnoremap <silent><s-Left>  <<
  nnoremap <silent><s-Up>    :<C-u>wincmd k<CR>
  nnoremap <silent><s-Down>  :<C-u>wincmd j<CR>
  nnoremap <m-s> %

  " insert mode
  " inoremap <c-c> <esc>
  inoremap <c-a> <home>
  inoremap <c-e> <end>
  inoremap <c-d> <c-c><c-d>i<right>
  inoremap <c-b> <c-c><c-u>i<right>
  inoremap <silent><c-down> <c-c>:exe 'normal '. winheight('.') / 5 * 2 ."<bslash><lt>c-y>"<cr>a
  inoremap <silent><c-up> <c-c>:exe 'normal '. winheight('.') / 5 * 2 ."<bslash><lt>c-t>"<cr>a
  inoremap <m-s> <c-c>%i
  inoremap <c-l> <right><bs>
  inoremap <c-u> <c-c><right>d^i
  inoremap <c-k> <c-c><right>d$i
  inoremap <c-y> <c-r>"
  inoremap <c-o> <end><cr>
  inoremap <s-right> <c-t>
  inoremap <s-left> <c-d>
  inoremap <silent><C-S-Down> <C-C>:m .+1<CR>==gi
  inoremap <silent><C-S-Up> <C-C>:m .-2<CR>==gi

  " normal mode
  nnoremap <c-a> 0
  nnoremap <c-e> $
  nnoremap <c-b> <c-u>
  nnoremap <c-t> <c-e>
  nnoremap <c-right> w
  nnoremap <c-left> b
  nnoremap <c-y> <c-y>
  nnoremap <c-o> <c-o>
  nnoremap <c-p> <c-i>
  nnoremap <expr><c-d> winheight('.') / 5 * 2 ."\<c-d>"
  nnoremap <expr><c-b> winheight('.') / 5 * 2 ."\<c-u>"
  nnoremap <silent><c-down> :exe 'normal '. winheight('.') / 5 * 2 ."<bslash><lt>c-y>"<cr>
  nnoremap <silent><c-up> :exe 'normal '. winheight('.') / 5 * 2 ."<bslash><lt>c-t>"<cr>
  nnoremap <silent><c-j> :exe 'normal '. winheight('.') / 5 * 2 ."<bslash><lt>c-y>"<cr>
  nnoremap <silent><c-k> :exe 'normal '. winheight('.') / 5 * 2 ."<bslash><lt>c-t>"<cr>
  nnoremap <silent> <bs> :nohl<CR>
  nnoremap <expr> n  'Nn'[v:searchforward]
  nnoremap <expr> N  'nN'[v:searchforward]
  nnoremap <silent>d<space> :s/ *$//<cr>:nohl<cr>
  nnoremap <silent>da<space> :%s/ *$//<cr>:nohl<cr>
  nnoremap <silent> <c-w>o <c-w>o:let &l:statusline = SpaceVim#layers#core#statusline#get(1)<cr>
  nnoremap <c-l> :let &l:statusline = SpaceVim#layers#core#statusline#get(1)<cr><c-l>

  function! s:filesize() abort
    let l:size = getfsize(bufname('%'))
    if l:size == 0 || l:size == -1 || l:size == -2
      return ''
    endif
    if l:size < 1024
      return l:size.' bytes '
    elseif l:size < 1024*1024
      return printf('%.1f', l:size/1024.0).'k '
    elseif l:size < 1024*1024*1024
      return printf('%.1f', l:size/1024.0/1024.0) . 'm '
    else
      return printf('%.1f', l:size/1024.0/1024.0/1024.0) . 'g '
    endif
  endfunction
  nnoremap <silent> <c-g> :echo '"'.expand('%:p').'" -- '.<SID>filesize()<cr>

  nnoremap <silent> <leader>m  :<c-u><c-r><c-r>='let @'. v:register .' = '. string(getreg(v:register))<cr><c-f><left>:<c-u><c-r><c-r>='let @'. v:register .' = '. string(getreg(v:register))<cr><c-f><left>
  let g:_spacevim_mappings.m = ['try again...', 'quickly modify your macros']

  " visual mode
  vnoremap <c-a> 0
  vnoremap <c-e> $

  " command mode
  cnoremap <c-a> <c-b>
  command! -nargs=* Rcmd :let tmp=<q-args> | put =execute(tmp)

  " paste operator
  nunmap ,<space>
  nnoremap <silent> , yl
  nnoremap <silent> Y y$
  xnoremap =p "0p
  nnoremap =p "0p
  nnoremap =P "0P
  nnoremap <silent>=o :set paste<cr>o<c-r>0<c-c>:set nopaste<cr>
  nnoremap <silent>=O :set paste<cr>O<c-r>0<c-c>:set nopaste<cr>
  if has('nvim') || $WSL_DISTRO_NAME ==# ''
    xnoremap <Leader>y "+y
    nnoremap <leader>y "+y
    nnoremap <leader>Y "+y$
    nnoremap <leader>, "+yl
    nnoremap <silent><leader>o :set paste<cr>o<c-r>+<c-c>:set nopaste<cr>
    let g:_spacevim_mappings.o = ['normal! "+p', 'paste in next line']
    nnoremap <silent><leader>O :set paste<cr>O<c-r>+<c-c>:set nopaste<cr>
    let g:_spacevim_mappings.O = ['normal! "+p', 'paste in previous line']
  endif

  " g mapping
  let g:_spacevim_mappings_g['&'] = ['exe "normal :s/\<up>\<cr>:nohl\<cr>"', 'repeat last ":s" on this lines']
  nnoremap <silent>g& :s/<up><cr>:nohl<cr>
  let g:_spacevim_mappings_g['8'] = ['call feedkeys("g8", "n")', 'print ascii or unicode value of cursor character']
  nnoremap g8 g8
  let g:_spacevim_mappings_g['%'] = ['MatchupWhereAmI', 'show matchup']
  nnoremap <silent>g% :MatchupWhereAmI<cr>
  let g:_spacevim_mappings_g['F'] = ['call SpaceVim#api#import("job").start("xdg-open ".expand("<cfile>"))', 'edit file under cursor with GUI']
  nnoremap <silent> gF :call SpaceVim#api#import('job').start("xdg-open ".expand('<cfile>'))<cr>

  " z mapping
  let g:_spacevim_mappings_z['<Left>'] = ['call feedkeys("zL", "n")', 'scroll half a screenwidth to the left']
  nnoremap z<Left> zL
  let g:_spacevim_mappings_z['<Right>'] = ['call feedkeys("zH", "n")', 'scroll half a screenwidth to the Right']
  nnoremap z<Right> zH
  let g:_spacevim_mappings_z['<Up>'] = ['normal 3<c-y>', 'scroll up one line']
  nnoremap z<up> 3<c-e>
  let g:_spacevim_mappings_z['<Down>'] = ['normal 3<c-e>', 'scroll down one line']
  nnoremap z<down> 3<c-y>
endfunction
" called by set_neovim
function! s:close_window(range)
  if a:range ==# ''
    quit
  else
    exe substitute(a:range, '.*\(\d\)', '\1', 'g')+1.'close'
  endif
  let &l:statusline = SpaceVim#layers#core#statusline#get(1)
endfunction


function! s:incsearch_after()
  let g:incsearch#auto_nohlsearch = 0
  function! s:config_easyfuzzymotion(...) abort
    return extend(copy({
    \   'converters': [incsearch#config#fuzzyword#converter()],
    \   'modules': [incsearch#config#easymotion#module({'overwin': 1})],
    \   'keymap': {"\<CR>": '<Over>(easymotion)'},
    \   'is_expr': 0,
    \   'is_stay': 1
    \ }), get(a:, 1, {}))
  endfunction
  nnoremap <silent><expr> g/ incsearch#go(<SID>config_easyfuzzymotion())
  nmap z/ <Plug>(incsearch-fuzzyword-/)
endfunction


function! s:git_after()
  let g:gitgutter_enabled = 0
  call SpaceVim#mapping#space#def('nnoremap', ['g', 'm'], 'Git branch', 'branch-manager', 1)
  call SpaceVim#mapping#space#def('nnoremap', ['g', 'g'], 'GitGutterToggle', 'GitGutter Buffer Toggle', 1)
endfunction


function! s:colorscheme_after()
  if $WSL_DISTRO_NAME !=# ''
    hi! SpellBad gui=underline guisp=Red
    hi! SpellCap gui=underline guisp=Yellow
    hi! SpellRare gui=underline guisp=Cyan
  else
    hi! SpellBad gui=undercurl guisp=Red
    hi! SpellCap gui=undercurl guisp=Yellow
    hi! SpellRare gui=undercurl guisp=Cyan
  endif
endfunction


function! s:custom_plugins()
  "=============== vim-header ================="
  let g:header_field_author = 'Heache Bear'
  let g:header_field_author_email = 'mrbeardad@qq.com'
  let g:header_field_license_id = 'GPLv3'
  let g:header_field_copyright = 'Copyright (c) 2020-'.strftime('%Y').' Heache Bear & Contributors'
  let g:header_max_size = 9
  let g:header_alignment = 0
  let g:header_auto_add_header = 0
  "=============== vim-visual-multi ================="
  let g:VM_case_setting = 'sensitive'
  let g:VM_set_statusline = 3
  let g:VM_default_mappings = 0
  let g:VM_maps = {}
  let g:VM_maps['Find Under'] = '<m-e>'
  let g:VM_maps['Find Subword Under'] = '<m-e>'
  let g:VM_maps['Add Cursor At Pos'] = '<m-a>'
  let g:VM_maps['Add Cursor Up'] = '<m-up>'
  let g:VM_maps['Add Cursor Down'] = '<m-down>'
  let g:VM_maps['Select Operator'] = 'v'
  let g:VM_maps['Increase'] = '+'
  let g:VM_maps['Decrease'] = '-'
  function! g:VM_Start()
    nmap <buffer> <C-C> <Esc>
    imap <buffer> <C-C> <Esc>
    nmap <buffer> \\A <Plug>(VM-Select-All)
    nmap <buffer> s cl
  endfunction
  function! g:VM_Exit()
    nunmap <buffer> <C-C>
    iunmap <buffer> <C-C>
    nunmap <buffer> \\A
    nunmap <buffer> s
  endfunction
  "=============== vimspector =================
  let g:vimspector_terminal_maxwidth = 35
  let g:vimspector_sidebar_width = 45
  let g:vimspector_bottombar_height = 15
  " let g:vimspector_enable_mappings = 'VISUAL_STUDIO'
  if has('nvim')
    nmap <F5>   <Plug>VimspectorContinue
    nmap <F17>  <Plug>VimspectorPause
    nmap <F6>   <Plug>VimspectorRestart
    nmap <F18>  <plug>VimspectorStop
    nmap <F7>   <Plug>VimspectorStepOver
    nmap <F19>  <Plug>VimspectorRunToCursor
    nmap <F8>   <Plug>VimspectorStepInto
    nmap <F20>  <Plug>VimspectorStepOut
    nmap <F9>   <Plug>VimspectorToggleBreakpoint
    nmap <F21>  <Plug>VimspectorAddFunctionBreakpoint
    nmap <F33>  <Plug>VimspectorToggleConditionalBreakpoint
    au BufCreate vimspector.Variables nnoremap <buffer><silent><leader><cr> :call vimspector#SetVariableValue()<cr>
  else
    nmap <F5>   <Plug>VimspectorContinue
    nmap <S-F5> <Plug>VimspectorPause
    nmap <F6>   <Plug>VimspectorRestart
    nmap <S-F6> <plug>VimspectorStop
    nmap <F7>   <Plug>VimspectorStepOver
    nmap <S-F7> <Plug>VimspectorRunToCursor
    nmap <F8>   <Plug>VimspectorStepInto
    nmap <S-F8>  <Plug>VimspectorStepOut
    nmap <F9>   <Plug>VimspectorToggleBreakpoint
    nmap <S-F9> <Plug>VimspectorAddFunctionBreakpoint
    nmap <C-F9> <Plug>VimspectorToggleConditionalBreakpoint
  endif
endfunction


function! s:custom_plugins_after()
  "=============== vim-header =================
  call SpaceVim#mapping#space#def('nnoremap', ['f', 'h'], 'AddHeader', 'add file header', 1)
endfunction


function! s:spacevim_after()
  nnoremap <silent><F3> :call SpaceVim#plugins#tabmanager#open()<cr>
  augroup MySpaceVim
    autocmd FileType SpaceVimFlyGrep map <buffer> <c-c> <esc>
    autocmd FileType leaderGuide map <buffer> <c-c> <esc>
    autocmd FileType qf nnoremap <buffer><tab> <down>
    autocmd FileType qf nnoremap <buffer><s-tab> <up>
    autocmd FileType SpaceVimTasksInfo nnoremap <buffer><tab> <down>
    autocmd FileType SpaceVimTasksInfo nnoremap <buffer><s-tab> <up>
  augroup END
endfunction


function! s:lang_chinese()
  let g:translator_default_engines = ['bing', 'youdao']
endfunction


" ===================================================================================================
function! myspacevim#before() abort
  call s:code_runner()
  call s:autocomplete()
  call s:checker()
  call s:edit()
  call s:lang_c()
  call s:lang_go()
  call s:leaderf()
  call s:lang_markdown()
  call s:colorscheme()
  call s:custom_plugins()
  call s:lang_chinese()
endfunction
" ===================================================================================================


" ===================================================================================================
function! myspacevim#after() abort
  call s:custom_plugins_after()
  call s:set_neovim_after()
  call s:edit_after()
  call s:lang_markdown_after()
  call s:incsearch_after()
  call s:git_after()
  call s:spacevim_after()
  call s:colorscheme_after()
endfunction
" ===================================================================================================

