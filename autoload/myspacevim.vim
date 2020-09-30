"=============================================================================
" myspacevim.vim --- Customized configuration file for spacevim
" Copyright (c) 2020 Heachen Bear
" Author: Heachen Bear
" Email: mrbeardad@qq.com
" License: GPLv3
"=============================================================================

function! myspacevim#before() abort
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
  let g:ycm_clangd_args = [ '--header-insertion=never' ]
  let g:AutoPairsMapCR = 0
  let g:AutoPairsShortcutJump = 0
  let g:AutoPairsMultilineClose = 0


  " ==================================
  " CUSTOM: checker Before
  " ==================================
  let g:ale_linters_explicit = 1
  let g:ale_sign_column_always = 1
  let g:ale_disable_lsp = 1
  let g:ale_completion_enabled = 0
  let g:ale_set_highlights = 1
  let g:ale_lint_on_text_changed = 'never'
  let g:ale_lint_on_insert_leave = 1
  let g:ale_lint_on_enter = 0
  let g:ale_lint_on_save = 0
  let g:ale_linters = {
        \   'cpp': ['cppcheck', 'gcc', 'clangtidy'],
        \   'c': ['gcc', 'cppcheck'],
        \   'sh': ['shellcheck'],
        \   'python': ['flake8', 'pylint'],
        \}


  " ==================================
  " CUSTOM: lang#c Before
  " ==================================
  augroup MySpaceVim_lang_c
    autocmd!
    if g:spacevim_enable_ale == 1
      au! VimEnter call s:is_ale_ok()
      au! InsertLeave *.cpp,*.hpp call s:ale_chopt() | call s:ale_cnter()
    endif
    autocmd BufWritePre *.{c,cpp,h,hpp} SortInclude
  augroup END


  " ==================================
  " CUSTOM: tools Before
  " ==================================
  let g:rainbow_active = 1
  let g:rainbow_conf = {
  \ 'guifgs':  ['#e15078', '#95bcad', '#ff7300', '#3a5fcd', '#d7cfff', '#00dfd7', '#ffd700', '#ff00ff', '#40ffff'],
  \ 'ctermfgs': ['lightblue', 'lightyellow', 'lightcyan', 'lightmagenta'],
  \ 'guis': [''],
  \ 'cterms': [''],
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
  " comment 946
  let g:gruvbox_contrast_dark = 'hard'
  let g:gruvbox_italicize_strings = 1
  let g:palenight_terminal_italics = 1

endfunction

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
    let g:ycm_clangd_uses_ycmd_caching = 0
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
    let g:ale_cpp_std = '-std=c++17'
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
    let g:ale_sign_error = ' '
    let g:ale_sign_warning = ' '
    let g:ale_sign_info = ' '
    let g:ale_echo_msg_error_str = 'Error'
    let g:ale_echo_msg_warning_str = 'Warning'
    let g:ale_echo_msg_info_str = 'Info'

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
  call SpaceVim#mapping#def('nnoremap', '<Leader>tm', ':call tablemode#Toggle()<cr>',
        \ '',
        \ '',
        \ 'Toggle table mode')


  " ==================================
  " CUSTOM: git After
  " ==================================
  let g:gitgutter_enabled = 0
  call SpaceVim#mapping#space#def('nnoremap', ['g', 'm'], 'Git branch', 'branch-manager', 1)
  call SpaceVim#mapping#space#def('nnoremap', ['g', 'g'], 'GitGutterToggle', 'GitGutter Buffer Toggle', 1)

  " ==================================
  " CUSTOM: lang#c After
  " ==================================
  let g:cppman_open_mode = '<auto>'
  let g:cpp_class_scope_highlight = 1
  let g:cpp_member_variable_highlight = 1
  let g:cpp_class_decl_highlight = 1
  let g:cpp_concepts_highlight = 1
  let g:cpp_posix_standard = 1
  let g:cpp_experimental_simple_template_highlight = 1      " which works in most cases, but can be a little slow on large files
  " let g:cpp_experimental_template_highlight = 1           " which is a faster implementation but has some corner cases where it doesn't work.
  inoremap <buffer><m-m> <c-r>=<SID>change_namespace()<cr>
  nnoremap <buffer><m-m> i<c-r>=<SID>change_namespace()<cr><c-c>
  nnoremap <silent><buffer> K :exe "Cppman ". expand('<cword>')<cr>

  " ==================================
  " CUSTOM: lang#markdown After
  " ==================================
  let g:markdown_fenced_languages = ['shell=sh', 'bash=sh', 'sh', 'viml=vim', 'java', 'coffee', 'css', 'erb=eruby', 'javascript', 'js=javascript', 'json=javascript', 'ruby', 'sass', 'xml', 'html']
  let g:tex_conceal = ""
  let g:vim_markdown_math = 1
  let g:vim_markdown_emphasis_multiline = 0
  set conceallevel=0
  let g:vim_markdown_conceal = 0
  let g:vim_markdown_strikethrough = 1
  let g:vim_markdown_conceal_code_blocks = 0
  let g:vmt_auto_update_on_save = 1
  let g:mkdp_auto_close = 0
  let g:mkdp_open_to_the_world = 1
  augroup myspacevim_layer_lang_markdown
    autocmd!
    autocmd FileType markdown inoremap <buffer><s-tab> &emsp;
    autocmd FileType markdown inoremap <buffer><leader><cr> <br><cr>
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
  " CUSTOM: colorscheme After
  " ==================================
  if $DARKBG != ''
    let colorNr = localtime() % 5
    " let colorNr = 3
    if colorNr == 0
      colorscheme SpaceVim
      hi! CursorLineNr gui=bold guifg=#df5fdf
      hi! CursorLine guibg=#363636
      hi! LineNr guifg=#6c6c6c
      hi! Constant guifg=#af00ee
      hi! Boolean guifg=#af00ee
      hi! Structure guifg=#bd93f9
      hi! StorageClass guifg=#47d0ff
      hi! Comment gui=italic guifg=#007f7f
      hi! String gui=italic guifg=#00dfd7
      hi! Statement guifg=#ff5f87
      hi! Repeat guifg=#ff5f87
      hi! Conditional guifg=#ff5f87
      hi! Label guifg=#ff5f87
      hi! MatchParen gui=bold
      hi! Operator gui=bold
      hi! Function gui=bold guifg=#df5faf
      hi! Type guifg=#ffafdf
      hi! Typedef guifg=#ffafdf
    elseif colorNr == 1  && &rtp =~ 'gruvbox'
      colorscheme gruvbox
      hi! CursorLineNr gui=bold
      hi! GruvboxYellow gui=italic
    elseif colorNr == 2  && &rtp =~ 'NeoSolarized'
      colorscheme NeoSolarized
      hi! NonText guifg=#596364
      hi! Normal guifg=#a5b4b4
      hi! CursorLineNr gui=bold guifg=#2aa198
      hi! CursorLine guibg=#2c4b53 gui=none
      hi! Operator gui=bold guifg=#8787af
      hi! Structure guifg=#5fafd7
      hi! StorageClass guifg=#d78700
      hi! Function gui=bold guifg=#268bd2
      hi! Type gui=italic
      hi! String gui=italic guifg=#2aa198
    elseif colorNr == 3  && &rtp =~ 'palenight.vim'
      colorscheme palenight
      hi! CursorLine guibg=#3c4658
      hi! CursorLineNr gui=bold
      hi! Structure guifg=#00dfd7
      hi! StorageClass guifg=#87ff00
      hi! StorageClass guifg=#c3e88d
      hi! Operator gui=bold
      hi! MatchParen gui=bold
      hi! Constant guifg=#ff5370
      hi! Function gui=bold guifg=#82b1ff
      hi! Typedef gui=italic guifg=#ffcb6b
      hi! Type gui=italic guifg=#ffcb6b
      hi! String gui=italic guifg=#c3e88d
    elseif colorNr == 4  && &rtp =~ 'vim-material'
      colorscheme material
      hi! Normal guifg=#ccdddd
      hi! Search gui=underline guifg=#cfffff
      hi! SignColumn guibg=#374349
      hi! Error guibg=#374349
      hi! ALEWarningSign guibg=#374349
      hi! Pmenu guifg=#cfffff guibg=#323232
      hi! Structure guifg=#00dfd7
      hi! StorageClass guifg=#bd93f9
      hi! MatchParen gui=bold
      hi! Operator gui=bold
      hi! Function gui=bold guifg=#82aaff
      hi! Type gui=italic guifg=#ffcb6b
      hi! String gui=italic guifg=#c3e88d
      hi! Pmenu guifg=#d7dfff
    endif
  else
    colorscheme default-plus
  endif
  hi! ALEWarningSign guifg=#ffbc6b
  hi! BookmarkSignDefault guifg=yellow
  if $WSL_DISTRO_NAME != ''
    " Windows Terminal暂时还不支持undercurl，且无法回滚为underline
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
  set termguicolors
  set tabstop=4
  set softtabstop=4
  set shiftwidth=4
  set expandtab
  set list
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
  nnoremap <silent><c-down> :exe 'normal '. winheight('.') / 5 * 2 ."<bslash><lt>c-y>"<cr>
  nnoremap <silent><c-up> :exe 'normal '. winheight('.') / 5 * 2 ."<bslash><lt>c-t>"<cr>
  nnoremap <silent> <bs> :nohl<CR>
  nnoremap <expr> n  'Nn'[v:searchforward]
  nnoremap <expr> N  'nN'[v:searchforward]
  nnoremap <silent>d<space> :s/ *$//<cr>:nohl<cr>
  nnoremap <silent>da<space> :%s/ *$//<cr>:nohl<cr>
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

