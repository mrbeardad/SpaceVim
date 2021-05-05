" Copyright (c) 2020-2021 Heachen Bear & Contributors
" File: myspacevim.vim
" License: GPLv3
" Author: Heachen Bear <mrbeardad@qq.com>
" Date: 09.02.2021
" Last Modified Date: 05.05.2021
" Last Modified By: Heachen Bear <mrbeardad@qq.com>

function! s:file_icons()
  let g:spacevim_filename_icons = {
        \ '.gitconfig'    : '',
        \ '.gitignore'    : '',
        \ '.gitsubmodules': '',
        \ '.gitkepp'      : '',
        \ '.gdbinit'      : '',
        \ '.zshrc'        : '',
        \}
  let g:spacevim_filetype_icons = {
        \ 'zsh' : '',
        \ 'hpp' : '',
        \ 'toml': '',
        \}
endfunction


function! s:runner_before()
  if g:spacevim_terminal_runner
    let g:quickrun_default_flags = {
        \ 'cpp': {
            \ 'compiler': 'g++',
            \ 'compileFlags': '-g3 -ggdb3 -D_GLIBCXX_DEBUG -I. -I${workspaceFolder}/include -o ${exeFile} ${file}',
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
            \ ],
            \ 'cmd': '${exeFile}',
            \ 'cmdArgs': '',
            \ 'cmdRedir': '',
            \ 'debugCmd': '!tmux new-window "cgdb ${exeFile}"'
        \ },
        \ 'c': {
            \ 'compiler': 'gcc',
            \ 'compileFlags': '-std=c11 -I. -I${workspaceFolder}/include -o ${exeFile} ${file}',
            \ 'cmd': '${exeFile}',
            \ 'debugCmd': '!tmux new-window "cgdb ${exeFile}"'
        \ },
        \ 'python': {
            \ 'cmd': '/bin/python ${file}',
            \ 'debugCmd': '!tmux new-window "pudb3 ${file}"'
            \}
    \ }
  endif
endfunction


function! s:autocomplete_before()
  if g:spacevim_autocomplete_method ==# 'ycm'
    let g:ycm_filetype_whitelist = {
            \ 'c':1,
            \ 'cpp':1,
            \ 'python':1,
            \ 'sh':1,
            \ 'vim':1,
            \ 'cmake':1
            \ }
      let g:ycm_semantic_triggers = {
            \ 'c':['re!\w\w'],
            \ 'cpp':['re!\w\w'],
            \ 'python':['re!\w\w'],
            \ 'sh':['re![\w-]{2}', '/', '-'],
            \ 'vim':['re!\w\w'],
            \ }
    let g:ycm_clangd_args = [ '--header-insertion=never' ]
    augroup MySpaceVimAutocomplete
      for ft in keys(g:ycm_semantic_triggers)
        exe 'autocmd FileType '.ft.' nnoremap <silent> gd :YcmCompleter GoTo<CR>'
        exe 'autocmd FileType '.ft.' nnoremap <silent> gr :YcmCompleter GoToReferences<CR>'
        exe 'autocmd FileType '.ft." nnoremap <silent> gc :exe 'YcmCompleter RefactorRename '.input('refactor \"'.expand('<cword>').'\" to:')<cr>"
        exe 'autocmd FileType '.ft.' nnoremap <silent> gt :YcmCompleter GetType<CR>'
      endfor
    augroup END
  endif
endfunction


function! s:autocomplete_after()
  if g:spacevim_autocomplete_method ==# 'ycm'
    let g:ycm_global_ycm_extra_conf = $HOME.'.SpaceVim.d/.ycm_extra_conf.py'
    let g:ycm_clangd_uses_ycmd_caching = 0
    let g:ycm_cache_omnifunc = 0
    let g:ycm_confirm_extra_conf = 0
    let g:ycm_show_diagnostics_ui = 0
    let g:ycm_max_num_candidates = 50
    let g:ycm_max_num_identifier_candidates = 20
    let g:ycm_key_invoke_completion = '<C-Z>'
    let g:ycm_key_list_select_completion = ['<TAB>']
    let g:ycm_key_list_previous_completion = ['<S-TAB>']
    let g:ycm_seed_identifiers_with_syntax = 1
    let g:ycm_collect_identifiers_from_tags_files = 0
    let g:ycm_collect_identifiers_from_comments_and_strings = 1

  endif
endfunction


function! s:checker_before()
  if g:spacevim_lint_engine ==# 'ale'
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
                \ 'c': ['gcc', 'cppcheck'],
                \ 'cpp': ['cppcheck', 'gcc', 'clangtidy'],
                \ 'python': ['bandit', 'pylint'],
                \ 'sh': ['shellcheck'],
                \ 'vim': ['ale_custom_linting_rules', 'vimls', 'vint'],
                \ }
  endif
endfunction


function! s:checker_after()
  if g:spacevim_lint_engine ==# 'ale'
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

    call SpaceVim#mapping#space#def('nnoremap', ['e', 'b'], 'ALEPrevious', 'Previous error/warnning', 1)
    call SpaceVim#mapping#space#def('nnoremap', ['e', 'n'], 'ALENext', 'Next error/warnning', 1)
    call SpaceVim#mapping#space#def('nnoremap', ['e', 'd'], 'ALEDetail', 'Detail error information', 1)
  endif
endfunction


function! s:lang_c_before()
  let g:cppman_open_mode = '<auto>'
  let g:cpp_nofunction_highlight = 1
  let g:cpp_simple_highlight = 0
  let g:c_no_posix_function = 1
  let g:cmake_ycm_symlinks = 1
  call SpaceVim#custom#LangSPC('cpp', 'nnore', ['l'],
        \ 'let ale_cpp_clangtidy_executable = "clang-tidy" | ALELint',
        \ 'Lint with all linters', 1)
  call SpaceVim#custom#LangSPC('cpp', 'nnore', ['p'],
        \ ":set paste\<cr>i\<c-r>=protodef#ReturnSkeletonsFromPrototypesForCurrentBuffer({'includeNS' : 0})\<cr>\<esc>='[:set nopaste\<cr>",
        \ 'protodef in namespace', 0)

  augroup MySpaceVimLangC
    autocmd FileType cpp nnoremap <silent><buffer> K :exe "Cppman ". expand('<cword>')<cr>
    autocmd BufWritePre *.{c,cpp,h,hpp} SortInclude
    autocmd User ALELintPost let g:ale_cpp_clangtidy_executable = 'echo'
  augroup END
endfunction


function! s:lang_c_after()
  function! s:set_lang_cpp_std()
    let line = filter(split(execute('YcmDebugInfo'), '\n'), 'v:val =~# "Clangd Compilation Command:"')
    if len(line) == 0
      let b:lang_cpp_std = '-std=c++20'
    else
      let line = substitute(line[0], '.*\(-std=c++\d\+\).*', '\1', '')
      if len(line) == 0
        let b:lang_cpp_std = '-std=c++20'
      else
        let b:lang_cpp_std = line
      endif
    endif

    let g:ale_cpp_cc_options = b:lang_cpp_std . ' -O2 -I. -fsyntax-only -fcoroutines -Wall -Wextra -Wshadow -Wfloat-equal -Wsign-conversion -Wlogical-op -Wnon-virtual-dtor -Woverloaded-virtual -Wduplicated-cond -Wduplicated-branches -Wnull-dereference -Wuseless-cast -Wdouble-promotion '
    let g:ale_cpp_cppcheck_options = '--enable=warning,style,performance,portability -'.b:lang_cpp_std
    let g:ale_cpp_clangtidy_options = ' -I. ' . b:lang_cpp_std

    let b:QuickrunCompileFlag = b:lang_cpp_std.' '.b:QuickrunCompileFlag
  endfunction

  augroup MySpaceVimLangC
    autocmd FileType cpp call s:set_lang_cpp_std()
  augroup END
endfunction


function! s:core_after()
  let g:matchup_matchparen_stopline = 45
  let g:matchup_delim_stopline = 45
  let g:clever_f_smart_case = 1
  let g:clever_f_fix_key_direction = 1
  nmap + [SPC]n+
  nmap - [SPC]n-
  nmap ; <Plug>(easymotion-overwin-f2)
  nnoremap <silent><c-w>X :call SpaceVim#mapping#clear_saved_buffers()<cr>
endfunction

function! s:edit_before()
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
  " call SpaceVim#mapping#space#def('nnoremap', ['s', 'e'],
  "       \ ':set noignorecase | call SpaceVim#plugins#iedit#start() | set ignorecase<cr>',
  "       \ 'start-iedit-mode', 0
  "       \)
  " call SpaceVim#mapping#space#def('vnoremap', ['s', 'e'],
  "       \ ':set noignorecase | call SpaceVim#plugins#iedit#start(1) | set ignorecase<cr>',
  "       \ 'start-iedit-mode', 0
  "       \)
endfunction

function! s:lang_markdown_before()
  let g:vim_markdown_no_default_key_mappings = 1
  nmap [[ <Plug>Markdown_MoveToPreviousHeader
  nmap ]] <Plug>Markdown_MoveToNextHeader
  nmap [] <Plug>Markdown_MoveToCurHeader
endfunction

function! s:lang_markdown_after()
  let g:vim_markdown_folding_style_pythonic = 1
  let g:vim_markdown_emphasis_multiline = 0
  let g:vim_markdown_math = 1
  let g:tex_conceal = "abdmg"
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

function! s:leaderf_before()
  let g:Lf_GtagsAutoGenerate = 1
  let g:Lf_GtagsAutoUpdate = 1
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

function! s:tools_before()
  let g:rainbow_active = 1
  let g:rainbow_conf = {
  \ 'guifgs':  ['#ff0000', '#95bcad', '#ff7300', '#d7cfff', '#00dfd7', '#ffd700', '#00ff00'],
  \ 'guis': ['none'],
  \ 'ctermfgs': ['lightblue', 'lightyellow', 'lightcyan', 'lightmagenta'],
  \ 'cterms': ['none', 'italic'],
  \ 'operators': '_,_',
  \ 'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
  \ 'separately': {
  \     '*': {},
  \     'markdown': {
  \       'parentheses_options': 'containedin=markdownCode contained',
  \     },
  \     'lisp': {
  \       'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick', 'darkorchid3'],
  \     },
  \     'haskell': {
  \       'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/\v\{\ze[^-]/ end=/}/ fold'],
  \     },
  \     'vim': {
  \       'parentheses_options': 'containedin=vimFuncBody',
  \     },
  \     'perl': {
  \       'syn_name_prefix': 'perlBlockFoldRainbow',
  \     },
  \     'stylus': {
  \       'parentheses': ['start=/{/ end=/}/ fold contains=@colorableGroup'],
  \     },
  \     'css': 0,
  \     'cmake':0
  \ }
  \}
endfunction

function! s:ui_after()
  let g:indentLine_char =  '¦'
  let g:indentLine_fileTypeExclude = ['help', 'man', 'startify', 'vimfiler', 'defx', 'json']
  nnoremap <silent> <F1> :TagbarToggle<CR>
  nnoremap <silent> <F3> :Defx -direction=botright -no-focus<cr>
  nnoremap <silent> <F7> :call SpaceVim#plugins#tabmanager#open()<cr>
endfunction

function! s:colorscheme_before()
  let g:neosolarized_italic = 1
  let g:gruvbox_contrast_dark = 'hard'
  let g:gruvbox_italic = 1
  let g:gruvbox_bold = 1
  let g:gruvbox_italicize_strings = 1
  let g:palenight_terminal_italics = 1
endfunction

function! s:set_neovim_after() abort
  set nofoldenable
  set showcmd
  set noruler
  set noshowmode
  set virtualedit=block,onemore
  set ignorecase
  set smartcase
  set nowrapscan
  set scrolloff=2
  set noautoread
  set autochdir
  set belloff=
  set swapfile
  set nobackup

  augroup MySpaceVim
      autocmd InsertEnter *.py setlocal foldmethod=marker
      autocmd InsertLeave *.py setlocal foldmethod=expr
  augroup END

  " buffer and window operator
  " 若只设置guide则快捷键输入时会打开导航
  " 若只设置map则打开导航时输入的快捷键无效
  let g:_spacevim_mappings.n = ['bn', 'next buffer']
  nnoremap <silent> <leader>n :bn<cr>
  let g:_spacevim_mappings.b = ['bp', 'previous buffer']
  nnoremap <silent> <leader>b :bp<cr>
  nnoremap <silent><c-w>x :let bufnr_for_delete_with_ctrl_w_x = buffer_number()<cr>:bp<cr>:exe 'bd '.bufnr_for_delete_with_ctrl_w_x<cr>
  nnoremap <silent> <c-w>W :w !sudo tee % > /dev/null<CR><CR>
  nnoremap <silent> Q :q<cr>
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
  nnoremap <c-l> :let &l:statusline = SpaceVim#layers#core#statusline#get(1)<cr>:<cr>

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
  let g:_spacevim_mappings.m = ['try again...', "quickly modify your macros"]

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
  if has('unnamedplus')
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
  let g:_spacevim_mappings_g['F'] = ['call jobstart("xdg-open ". expand("<cfile>"))', 'edit file under cursor with GUI']
  if has('unix') || has('wsl')
    nnoremap <silent> gF :call jobstart('xdg-open '. expand('<cfile>'))<cr>
  elseif has ('win32')
    nnoremap <silent> gF :call jobstart('explorer '. expand('<cfile>'))<cr>
  endif

  " z mapping
  let g:_spacevim_mappings_z['<Left>'] = ['call feedkeys("zH", "n")', 'scroll half a screenwidth to the left']
  nnoremap z<Left> zH
  let g:_spacevim_mappings_z['<Right>'] = ['call feedkeys("zL", "n")', 'scroll half a screenwidth to the Right']
  nnoremap z<Right> zL
  let g:_spacevim_mappings_z['<Up>'] = ['normal 3<c-y>', 'scroll up one line']
  nnoremap z<up> 3<c-e>
  let g:_spacevim_mappings_z['<Down>'] = ['normal 3<c-e>', 'scroll down one line']
  nnoremap z<down> 3<c-y>
endfunction

function! s:set_neovim_before() abort
  set list  " 放在before防止覆盖Startify设置
  " set listchars=tab:▸\ ,eol:↵,trail:·,extends:↷,precedes:↶
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
  if $WSL_DISTRO_NAME != ''
    hi! SpellBad gui=underline guisp=Red
    hi! SpellCap gui=underline guisp=Yellow
    hi! SpellRare gui=underline guisp=Cyan
  else
    hi! SpellBad gui=undercurl guisp=Red
    hi! SpellCap gui=undercurl guisp=Yellow
    hi! SpellRare gui=undercurl guisp=Cyan
  endif
endfunction

function! s:custom_plugins_before()
  "=============== vim-header ================="
  let g:header_field_author = 'Heachen Bear'
  let g:header_field_author_email = 'mrbeardad@qq.com'
  let g:header_field_license_id = 'GPLv3'
  let g:header_field_copyright = 'Copyright (c) 2020-'.strftime("%Y").' Heachen Bear & Contributors'
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
  "=============== vim-autoformat ================="
  nnoremap <silent>g= :AutoformatLine<cr>
endfunction

function! s:custom_plugins_after()
  "=============== vim-header =================
  call SpaceVim#mapping#space#def('nnoremap', ['f', 'h'], 'AddHeader', 'add file header', 1)
endfunction

function! s:spacevim_after()
  augroup MySpaceVim
    autocmd FileType SpaceVimFlyGrep map <buffer> <c-c> <esc>
    autocmd FileType leaderGuide map <buffer> <c-c> <esc>
    autocmd FileType qf nnoremap <buffer><tab> <down>
    autocmd FileType qf nnoremap <buffer><s-tab> <up>
    autocmd FileType SpaceVimTasksInfo nnoremap <buffer><tab> <down>
    autocmd FileType SpaceVimTasksInfo nnoremap <buffer><s-tab> <up>
  augroup END
endfunction

" ===================================================================================================
function! myspacevim#before() abort
  call s:set_neovim_before()
  call s:file_icons()
  call s:runner_before()
  call s:autocomplete_before()
  call s:checker_before()
  call s:edit_before()
  call s:lang_c_before()
  call s:leaderf_before()
  call s:lang_markdown_before()
  call s:tools_before()
  call s:colorscheme_before()
  call s:custom_plugins_before()
endfunction
" ===================================================================================================


" ===================================================================================================
function! myspacevim#after() abort
  call s:custom_plugins_after()
  call s:set_neovim_after()
  call s:autocomplete_after()
  call s:checker_after()
  call s:core_after()
  call s:edit_after()
  call s:lang_markdown_after()
  call s:lang_c_after()
  call s:ui_after()
  call s:incsearch_after()
  call s:git_after()
  call s:spacevim_after()
  call s:colorscheme_after()
endfunction
" ===================================================================================================

