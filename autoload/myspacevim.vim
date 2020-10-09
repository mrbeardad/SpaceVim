"=============================================================================
" myspacevim.vim --- Customized configuration file for spacevim
" Copyright (c) 2020 Heachen Bear
" Author: Heachen Bear
" Email: mrbeardad@qq.com
" License: GPLv3
"=============================================================================

function! myspacevim#before() abort
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

  " ==================================
  " CUSTOM: autocomplete Before
  " ==================================
  let g:ycm_filetype_whitelist = {
        \ "c":1,
        \ "cpp":1,
        \ "python":1,
        \ "vim":1,
        \ "sh":1,
        \ }
    let g:ycm_semantic_triggers = {
          \ "c":['re!\w\w'],
          \ "cpp":['re!\w\w'],
          \ "python":['re!\w\w']
          \ }
  let g:ycm_clangd_args = [ '--header-insertion=never' ]
  let g:AutoPairsMapCR = 0
  let g:AutoPairsShortcutJump = 0
  let g:AutoPairsMultilineClose = 0


  " ==================================
  " CUSTOM: checker Before
  " ==================================
  let g:ale_sign_column_always = 1
  let g:ale_disable_lsp = 1
  let g:ale_completion_enabled = 0
  let g:ale_set_highlights = 1
  let g:ale_lint_on_filetype_changed = 0
  let g:ale_lint_on_text_changed = 'never'
  let g:ale_lint_on_insert_leave = 1
  let g:ale_lint_on_enter = 0
  let g:ale_lint_on_save = 0
  let g:ale_linters_explicit = 1
  let g:ale_linters = {
        \   'cpp': ['cppcheck', 'gcc', 'clangtidy'],
        \   'c': ['gcc', 'cppcheck'],
        \   'sh': ['shellcheck'],
        \   'python': ['flake8', 'pylint'],
        \}


  " ==================================
  " CUSTOM: lang#c Before
  " ==================================
  let g:cppman_open_mode = '<auto>'
  let g:cpp_nofunction_highlight = 1
  let g:cpp_simple_highlight = 0

  augroup MySpaceVim_lang_c
    autocmd!
    if g:spacevim_enable_ale == 1
      au! VimEnter call s:is_ale_ok()
      au! InsertLeave *.cpp,*.hpp call s:ale_chopt() | call s:ale_cnter()
    endif
    autocmd FileType cpp inoremap <buffer><m-m> <c-r>=<SID>change_namespace()<cr>
    autocmd FileType cpp nnoremap <buffer><m-m> i<c-r>=<SID>change_namespace()<cr><c-c>
    autocmd FileType cpp nnoremap <silent><buffer> K :exe "Cppman ". expand('<cword>')<cr>
    autocmd BufWritePre *.{c,cpp,h,hpp} SortInclude
  augroup END


  " ==================================
  " CUSTOM: tools Before
  " ==================================
  let g:rainbow_active = 1
  " \ 'guifgs':  ['#ff0000', '#ffff00', '#00ff00', '#00ffff', '#0000ff', '#ff00ff' ]
  " \ 'guifgs':  ['#ff0000', '#00ffff', '#ff8800', '#ff8800', '#ffff00', '#0000ff', '#88ff00', '#8800ff', '#00ff00', '#ff00ff'],
  let g:rainbow_conf = {
  \ 'guifgs':  ['#ff0000', '#95bcad', '#ff7300', '#d7cfff', '#00dfd7', '#ffd700', '#00ff00'],
  \ 'ctermfgs': ['lightblue', 'lightyellow', 'lightcyan', 'lightmagenta'],
  \ 'guis': ['none', 'bold', 'italic'],
  \ 'cterms': ['none', 'bold', 'italic'],
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
  \ }
  \}


  " ==================================
  " CUSTOM: colorscheme Before
  " ==================================
  let g:neosolarized_italic = 1
  let g:gruvbox_contrast_dark = 'hard'
  let g:gruvbox_italic = 1
  let g:gruvbox_bold = 1
  " let g:gruvbox_italicize_strings = 1
  let g:palenight_terminal_italics = 1

  " ==================================
  " CUSTOM: core#banner Before
  " ==================================
  set list  " 放在before防止覆盖Startify设置

endfunction

" ===================================================================================================
" ===================================================================================================

function! myspacevim#after() abort
  " ==================================
  " CUSTOM: NeoVim
  " ==================================
  call s:set_my_neovim()


  " ==================================
  " CUSTOM: autocomplete After
  " ==================================
  if g:spacevim_autocomplete_method ==# 'ycm'
    let g:ycm_cache_omnifunc = 0
    let g:ycm_confirm_extra_conf = 0
    let g:ycm_show_diagnostics_ui = 0
    let g:ycm_max_num_candidates = 30
    let g:ycm_clangd_uses_ycmd_caching = 1
    let g:ycm_key_invoke_completion = '<C-Z>'
    let g:ycm_key_list_stop_completion = ['<S-CR>']
    let g:ycm_key_list_select_completion = ['<TAB>']
    let g:ycm_key_list_previous_completion = ['<S-TAB>']
    let g:ycm_seed_identifiers_with_syntax = 1
    let g:ycm_collect_identifiers_from_tags_files = 1
    let g:ycm_collect_identifiers_from_comments_and_strings = 1

    let g:_spacevim_mappings_g['d'] = ['YcmCompleter GoTo', 'Go to definition/declaration']
    nnoremap <silent> gd :YcmCompleter GoTo<CR>
    let g:_spacevim_mappings_g['r'] = ['YcmCompleter GoToReferences', 'Go to reference']
    nnoremap <silent> gr :YcmCompleter GoToReferences<CR>
    let g:_spacevim_mappings_g['c'] = ['YcmCompleter RefactorRename', 'Refactor and rename']
    nnoremap <silent> gc :YcmCompleter RefactorRename
    let g:_spacevim_mappings_g['t'] = ['YcmCompleter GetType', 'Get Type']
    nnoremap <silent> gt :YcmCompleter GetType<CR>
  endif

  if g:spacevim_autocomplete_parens
    inoremap <silent><m-n> <c-c>:call AutoPairsJump()<cr>a
    if g:spacevim_autocomplete_method ==# 'ycm'
      inoremap <silent><cr> <c-r>=<SID>ycm_and_autopair_return()<cr>
    endif
  endif


  " ==================================
  " CUSTOM: checker After
  " ==================================
  if g:spacevim_enable_ale == 1
    let g:ale_cpp_std = get(g:, 'ale_cpp_std', '-std=c++17')
    let g:ale_cpp_cc_executable = 'gcc'
    let g:ale_cpp_cc_options = '-Wall -Wextra -O2 -I. ' . g:ale_cpp_std
    let g:ale_cpp_cppcheck_options = '--inconclusive --enable=warning,style,performance,portability -'.g:ale_cpp_std
    let g:ale_cpp_clangtidy_options = ' -I. ' . g:ale_cpp_std
    let g:ale_clangtidy_period = 6
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
      \ '-modernize-use-trailing-return-type',
      \ '-readability-isolate-declaration',
      \ ]

    let g:ale_echo_msg_format = '[%linter%] %s  [%severity%]'

  endif


  " ==================================
  " CUSTOM: chinese After
  " ==================================
  let g:translator_default_engines = ['bing']
  call SpaceVim#mapping#def('nnoremap', '<Leader>tc', ':Translate<cr>', '', '', 'Translate in cmdline')
  call SpaceVim#mapping#def('nnoremap', '<Leader>tw', ':TranslateW<cr>', '', '', 'Translate in popwindow')
  call SpaceVim#mapping#def('nnoremap', '<Leader>tx', ':TranslateX<cr>', '', '', 'Translate content in clipboard')
  call SpaceVim#mapping#def('nnoremap', '<Leader>tr', ':TranslateR<cr>', '', '', 'Translate and replace')


  " ==================================
  " CUSTOM: core After
  " ==================================
  let g:matchup_matchparen_stopline = 45
  let g:matchup_delim_stopline = 45
  let g:clever_f_smart_case = 1
  let g:clever_f_fix_key_direction = 1

  nmap + [SPC]n+
  nmap - [SPC]n-
  nmap ; <Plug>(easymotion-overwin-f2)
  nnoremap <silent><c-w>X :call SpaceVim#mapping#clear_saved_buffers()<cr>
  call SpaceVim#mapping#space#def('nmap', ['j', 'l'], '<Plug>(easymotion-overwin-line)', 'jump to a line', 0)
  nmap gs <Plug>(openbrowser-smart-search)
  vmap gs <Plug>(openbrowser-smart-search)

  " ==================================
  " CUSTOM: incsearch After
  " ==================================
  nmap z/ [SPC]b/
  let g:_spacevim_mappings_z['z/'] = ['normal z/', 'fuzzy incsearch ']
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
  let g:_spacevim_mappings_g['/'] = ['normal g/', 'fuzzy incsearch easymotion']

  " ==================================
  " CUSTOM: edit After
  " ==================================
  let g:EasyMotion_smartcase = 1
  let g:_spacevim_mappings.t = {'name' : '+Table-Mode/Translate'}
  xmap v <Plug>(expand_region_expand)
  xmap V <Plug>(expand_region_shrink)
  nmap ds <Plug>Dsurround
  nmap cs <Plug>Csurround
  nmap ys <Plug>Ysurround
  nmap yss <Plug>Yssurround
  nmap <leader>tt <Plug>table-mode-tableize
  xmap <leader>tt <Plug>table-mode-tableize
  inoremap <silent><m-m> <c-r>=tablemode#Toggle()<cr><bs>
  nnoremap <silent><m-m> <c-r>=tablemode#Toggle()<cr><bs>
  call SpaceVim#mapping#def('nnoremap', '<Leader>tm', ':call tablemode#Toggle()<cr>',
        \ '',
        \ '',
        \ 'Toggle table mode')
  call SpaceVim#mapping#space#def('nnoremap', ['x', 'c'], 'SourceCounter', 'count in the selection region', 1, 1)
  call SpaceVim#mapping#space#def('vmap', ['x', 'c'], '<Plug>CountSelectionRegion', 'count in the selection region', 0, 1)


  " ==================================
  " CUSTOM: git After
  " ==================================
  let g:gitgutter_enabled = 0
  call SpaceVim#mapping#space#def('nnoremap', ['g', 'm'], 'Git branch', 'branch-manager', 1)
  call SpaceVim#mapping#space#def('nnoremap', ['g', 'g'], 'GitGutterToggle', 'GitGutter Buffer Toggle', 1)

  " ==================================
  " CUSTOM: lang#markdown After
  " ==================================
  let g:markdown_fenced_languages = ['shell=sh', 'bash=sh', 'sh', 'viml=vim', 'java', 'coffee', 'css', 'erb=eruby', 'javascript', 'js=javascript', 'json=javascript', 'ruby', 'sass', 'xml', 'html']
  let g:vim_markdown_emphasis_multiline = 0
  let g:vim_markdown_math = 1
  let g:tex_conceal = "abdmg"
  " set conceallevel=0
  " let g:vim_markdown_conceal = 0
  let g:vim_markdown_strikethrough = 1
  let g:vim_markdown_conceal_code_blocks = 1
  let g:vmt_auto_update_on_save = 1
  let g:mkdp_auto_close = 0
  let g:mkdp_open_to_the_world = 1
  augroup myspacevim_layer_lang_markdown
    autocmd!
    autocmd FileType markdown inoremap <buffer><s-tab> &emsp;
    autocmd FileType markdown inoremap <buffer><leader><cr> <br><cr>
    autocmd FileType markdown inoremap <buffer><c-c> <esc>
    autocmd InsertEnter *.md setl conceallevel=0
    autocmd InsertLeave *.md setl conceallevel=2
  augroup END

  " ==================================
  " CUSTOM: tools After
  " ==================================
  call SpaceVim#mapping#space#def('nnoremap', ['a', 'R'],
        \ 'Goyo', 'read-mode', 1)
  let g:bookmark_sign = ' '
  let g:bookmark_annotation_sign = ' '
  let g:bookmark_auto_save_file = $HOME.'/.cache/SpaceVim/vim_bookmarks'
  let g:bookmark_no_default_key_mappings = 1
  call SpaceVim#mapping#space#def('nnoremap', ['m', 'm'], 'BookmarkToggle', 'BookmarkToggle', 1)
  call SpaceVim#mapping#space#def('nnoremap', ['m', 'i'], 'BookmarkAnnotate', 'BookmarkAnnotate', 1)
  call SpaceVim#mapping#space#def('nnoremap', ['m', 'l'], 'BookmarkShowAll', 'BookmarkShowAll', 1)
  call SpaceVim#mapping#space#def('nnoremap', ['m', 'n'], 'BookmarkNext', 'BookmarkNext', 1)
  call SpaceVim#mapping#space#def('nnoremap', ['m', 'b'], 'BookmarkPrev', 'BookmarkPrev', 1)
  call SpaceVim#mapping#space#def('nnoremap', ['m', 'c'], 'BookmarkClear', 'BookmarkClear', 1)
  call SpaceVim#mapping#space#def('nnoremap', ['m', 'C'], 'BookmarkClearAll', 'BookmarkClearAll', 1)
  nnoremap <silent> <F5> :UndotreeToggle<CR>

  " ==================================
  " CUSTOM: ui After
  " ==================================
  let g:indentLine_char =  '¦'
  let g:indentLine_fileTypeExclude = ['help', 'man', 'startify', 'vimfiler', 'defx', 'json']
  noremap <silent> <F1> :TagbarToggle<CR>
  nnoremap <silent><F7> :call SpaceVim#plugins#tabmanager#open()<cr>

  " ==================================
  " CUSTOM: SpaceVim After
  " ==================================
  autocmd FileType SpaceVimFlyGrep map <buffer> <c-c> <esc>
  autocmd FileType leaderGuide map <buffer> <c-c> <esc>

  " ==================================
  " CUSTOM: LeaderF After
  " ==================================
  let g:Lf_IndexTimeLimit = 30
  let g:Lf_UseCache = 0

  " ==================================
  " CUSTOM: colorscheme After
  " ==================================
  if $WSL_DISTRO_NAME != ''
    hi! SpellBad gui=underline guifg=Red
    hi! SpellCap gui=underline guifg=Yellow
    hi! SpellRare gui=underline guifg=Green
  else
    hi! SpellBad gui=undercurl guisp=red
    hi! SpellCap gui=undercurl guisp=yellow
    hi! SpellRare gui=undercurl guisp=magenta
  endif

endfunction

function! s:set_my_neovim() abort
  " set tabstop=4
  " set softtabstop=4
  " set shiftwidth=4
  set expandtab
  set listchars=tab:▸\ ,eol:↵,trail:·,extends:↷,precedes:↶
  set foldmethod=indent
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


  " buffer and window operator
  " 若只设置guide则快捷键输入时会打开导航
  " 若只设置map则打开导航时输入的快捷键无效
  let g:_spacevim_mappings.n = ['bn', 'next buffer']
  nnoremap <silent> <leader>n :bn<cr>
  let g:_spacevim_mappings.b = ['bp', 'previous buffer']
  nnoremap <silent> <leader>b :bp<cr>
  nnoremap <silent><c-w>x :let bufnr_for_delete_with_ctrl_w_x = buffer_number()<cr>:bp<cr>:exe 'bd '.bufnr_for_delete_with_ctrl_w_x<cr>
  nnoremap <silent> <c-w>W :w !sudo tee % > /dev/null<CR><CR>
  nnoremap <silent><tab> :winc w<cr>
  nnoremap <silent><s-tab> :winc W<cr>
  nnoremap <silent><s-Right> :<C-u>wincmd l<CR>
  nnoremap <silent><s-Left>  :<C-u>wincmd h<CR>
  nnoremap <silent><s-Up>    :<C-u>wincmd k<CR>
  nnoremap <silent><s-Down>  :<C-u>wincmd j<CR>

  " insert mode
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
  inoremap <silent><c-c> <c-c>:set cul<cr>
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
  nnoremap <silent> <bs> :nohl<CR>
  nnoremap <silent> <c-g> :echo '"'.expand('%:p').'" -- '.SpaceVim#layers#core#statusline#filesize()<cr>
  nnoremap <expr> n  'Nn'[v:searchforward]
  nnoremap <expr> N  'nN'[v:searchforward]
  nnoremap <silent>d<space> :s/ *$//<cr>:nohl<cr>
  nnoremap <silent>da<space> :%s/ *$//<cr>:nohl<cr>
  nnoremap <silent> <c-w>o <c-w>o:let &l:statusline = SpaceVim#layers#core#statusline#get(1)<cr>
  nnoremap <silent> <leader>m  :<c-u><c-r><c-r>='let @'. v:register .' = '. string(getreg(v:register))<cr><c-f><left>:<c-u><c-r><c-r>='let @'. v:register .' = '. string(getreg(v:register))<cr><c-f><left>
  let g:_spacevim_mappings.m = ['try again...', "quickly modify your macros"]
  if has('unix') || has('wsl')
    nnoremap <silent> gF :call jobstart('xdg-open '. expand('<cfile>'))<cr>
  elseif has ('win32')
    nnoremap <silent> gF :call jobstart('explorer '. expand('<cfile>'))<cr>
  endif

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
  let g:_spacevim_mappings_g['F'] = ['call jobstart("xdg-open ". expand("<cfile>"))', 'edit file under cursor with GUI']
  nnoremap <silent> gF :call jobstart('xdg-open '. expand('<cfile>'))<cr>
  let g:_spacevim_mappings_g['8'] = ['call feedkeys("g8", "n")', 'print ascii or unicode value of cursor character']
  nnoremap g8 g8
  let g:_spacevim_mappings_g['%'] = ['MatchupWhereAmI', 'show matchup']
  nnoremap <silent>g% :MatchupWhereAmI<cr>

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

function! s:is_ale_ok()
  let needcp_cppcheck = 1
  let needcp_clangtidy = 1
  let dir = g:spacevim_data_dir.'vimfiles/repos/github.com/dense-analysis/ale/ale_linters/cpp/'
  for thisLinter in ['cppcheck', 'clangtidy']
    if  match(execute('echo g:ale_linters'),thisLinter) != -1 && filereadable(dir.thisLinter.'.vim')
      for thisLine in readfile(dir.thisLinter.'.vim')
        if thisLine =~# 'ALE_CUSTOM_CHANGED'
          let needcp_{thisLinter} =0
        endif
      endfor
    endif
  endfor
  if  match(execute('echo g:ale_linters'),thisLinter) != -1 && filereadable(dir.thisLinter.'.vim')
    py3 from shutil import copyfile
    for thisLinter in ['cppcheck', 'clangtidy']
      if needcp_{thisLinter} == 1
        echo 'copy file from ~/.SpaceVim/custom/'.thisLinter.'.vim to '.dir.thisLinter.'.vim'
        exe "py3 copyfile('".$HOME."/.SpaceVim/custom/".thisLinter.".vim', '".dir.thisLinter.".vim')"
      endif
    endfor
  endif
endfunction

function! s:change_namespace()
  let WORD = expand('<cWORD>')
  normal diW
  if match(WORD, 'std\w*::') != 0
    return 'std::'.WORD
  elseif match(WORD, 'std::filesystem::') == 0
    return substitute(WORD, 'std::filesystem::', 'std_fs::', 'g')
  elseif match(WORD, 'std::chrono::') == 0
    return substitute(WORD, 'std::chrono::', 'std_co::', 'g')
  elseif match(WORD, 'std::ios_base::\|std::ios::') == 0
    return substitute(WORD, 'std::ios\w\{-}::', 'std_ios::', 'g')
  endif
endfunction

function! s:ycm_and_autopair_return()
  if expand('<cWORD>') ==# '{}' || expand('<cWORD>') ==# '()'
    return "\<CR>\<c-c>zz=ko"
  else
    let ret = substitute(substitute(execute('imap <s-cr>'),'^.*<SNR>','<SNR>', ''),"S-CR",'CR','')
    if ret =~ 'StopCompletion'
      exe 'return '. ret
    else
      return "\<cr>"
  endif
endfunction

let g:ale_clangtidy_executable = get(g:, 'ale_cpp_clangtidy_executable', 'clang-tidy')
let g:ale_clangtidy_period = get(g:, 'ale_clangtidy_period', 6)
let s:ale_lint_count = 0

function! s:ale_cnter()
  if s:ale_lint_count == 0
    let g:ale_cpp_clangtidy_executable = g:ale_clangtidy_executable
  else
    let g:ale_cpp_clangtidy_executable = 'echo'
  endif
  let s:ale_lint_count = (s:ale_lint_count + 1) % g:ale_clangtidy_period
endfunction

function! s:ale_chopt()
  let src_file_path = expand('%:p')
  if !filereadable(src_file_path)
    return
  endif
  let exe_file_path = g:QuickRun_Tempdir . expand('%:t') .'.'. py3eval('time.strftime("%M:%H:%S", time.localtime(os.path.getmtime("'.expand('%:p').'")))').'.exe'
  let qr_cf = SpaceVim#plugins#quickrun#parse_flags(SpaceVim#plugins#quickrun#extend_compile_arguments(g:quickrun_default_flags[&ft].extRegex, g:quickrun_default_flags[&ft].extFlags), src_file_path, exe_file_path)
  let g:ale_cpp_cc_options = g:ale_cpp_cc_options.' '.qr_cf
  let g:ale_cpp_clangtidy_options = g:ale_cpp_clangtidy_options.' '.qr_cf
endfunction

