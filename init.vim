let g:ale_and_quickrun_cpp_default_compile_flag = '-std=c++20'
let g:ale_clangtidy_period = 6

execute 'source' fnamemodify(expand('<sfile>'), ':h').'/config/main.vim'

if $XFCE4_TERM != ''
  if localtime() % 2 == 1  && &rtp =~ 'NeoSolarized'
    colorscheme NeoSolarized
    hi! Function gui=bold guifg=#268bd2
    hi! NonText guifg=#596364
    hi! String gui=italic guifg=#2aa198
    hi! CursorLineNr gui=bold guifg=#2aa198
    hi! CursorLine guibg=#2c4b53
    hi! Normal guifg=#a5b4b4
    hi! Type gui=italic
  else
    colorscheme gruvbox
    hi! CursorLineNr gui=bold
    hi! GruvboxYellow gui=italic
  endif
else
    colorscheme default-plus
endif

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
set noswapfile
set nobackup
set path+=/usr/include/c++/*/,/usr/include/boost/,.
set wildignore-=*/tmp/*

"================================
" => 界面操作
"================================
nnoremap <silent> <leader>n :bn<cr>
nnoremap <silent> <leader>b :bp<cr>
nnoremap <silent> <c-w>W :w !sudo tee % > /dev/null<CR><CR>
nmap <silent> <c-w>X [SPC]bc
function! BufferDelete()
    let bufNr = buffer_number()
    bp
    exe 'bd '. bufNr
endfunction
nnoremap <silent><c-w>x :call BufferDelete()<cr>
nnoremap <silent><tab> :winc w<cr>
nnoremap <silent><s-tab> :winc p<cr>
nnoremap <silent><c-w>o <c-w>o:let &l:statusline = SpaceVim#layers#core#statusline#get(1)<CR>

"================================
" => Terminal操作
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
let terminal_color_1 = '#ff5555'
let terminal_color_2 = '#50fa7b'
let terminal_color_3 = '#fabd2f'
let terminal_color_4 = '#bd93f9'
let terminal_color_5 = '#ff79c6'
let terminal_color_6 = '#8be9fd'

"================================
" => 插入模式快捷键
"================================
inoremap <c-a> <home>
inoremap <c-e> <end>
inoremap <c-y> <c-r>"
inoremap <c-u> <c-c><right>d^i
inoremap <c-k> <c-c><right>d$i
inoremap <c-d> <c-c>10<c-e>i<right>
inoremap <c-b> <c-c>10<c-y>i<right>
inoremap <c-]> <c-c>%i
inoremap <c-o> <end><cr>
inoremap <c-l> <right><bs>
inoremap <silent><c-c> <c-c>:set cul<cr>

"================================
" => 可视模式快捷键
"================================
vnoremap <c-a> 0
vnoremap <c-e> $

"================================
" => 普通模式快捷键
"================================
nnoremap <silent> <c-d> 18<c-e>
nnoremap <silent> <c-b> 18<c-y>
nnoremap <silent> <c-a> 0
nnoremap <silent> <c-e> $
nnoremap <silent> , yl
nnoremap <silent> Y y$
nnoremap <leader>y "+y
nnoremap <expr> n  'Nn'[v:searchforward]
nnoremap <expr> N  'nN'[v:searchforward]
nnoremap <silent> ]<space> :<c-u>put =repeat(nr2char(10), v:count1)<CR><up>
nnoremap <silent> [<space> :<c-u>put! =repeat(nr2char(10), v:count1)<CR><down>
nnoremap <silent> <Leader>h :nohl<CR>
nnoremap <leader>o o<c-c>"+p
nnoremap <silent><leader>i :IndentLinesEnable<cr>

function! ToggleLinebreak()
    if &linebreak == 1
        setl nolinebreak
        echo 'Linebreak Disable'
    else
        setl linebreak
        echo 'Linebreak Enable'
    endif
endfunction
nnoremap <silent> <leader>l :call ToggleLinebreak()<cr>

function! ToggleWrap()
    if &wrap == 1
        setl nowrap
        echo 'Wrap Disable'
    else
        setl wrap
        echo 'Wrap Enable'
    endif
endfunction
nnoremap <silent> <Leader>w :call ToggleWrap()<CR>

function! ToggleVirtuledit()
    if &virtualedit =~ "all"
        setl virtualedit=block,onemore
        echo 'VirtualEdit Disable'
    else
        setl virtualedit=all
        echo 'VirtualEdit Enable'
    endif
endfunction
nnoremap <silent> <leader>v :call ToggleVirtuledit()<CR>

function! ToggleExpandtab()
    if &expandtab == 1
        setl noexpandtab
        echo 'ExpandTab Disable'
    else
        setl expandtab
        echo 'ExpandTab Enable'
    endif
endfunction
nnoremap <silent> <leader>e :call ToggleExpandtab()<CR>
call SpaceVim#mapping#space#def('nnoremap', ['t','e'], 'call ToggleExpandtab()', 'expandtab or not',1)

function! ToggleSpell()
    if &spell == 1
        setl nospell
        echo 'Spell Disable'
    else
        setl spell
        echo 'Spell Enable'
    endif
endfunction
nnoremap <silent> <leader>s :call ToggleSpell()<CR>

function! ToggleFoldMethod()
    if &foldmethod != 'manual'
        setl foldmethod=manual
        echo 'set foldmethod=manual'
    else
        setl foldmethod=indent
        echo 'set foldmethod=indent'
    endif
endfunction
nnoremap <silent> <leader>F :call ToggleFoldMethod()<cr>

command! -nargs=* Rcmd :let tmp=<q-args> | put =execute(tmp)

"================================================ 插件配置 ======================================================

"================================
" => Cpp_Enhanced_Highlight配置
"================================
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1
let g:cpp_concepts_highlight = 1
let g:cpp_posix_standard = 1
let g:cpp_experimental_simple_template_highlight = 1      " which works in most cases, but can be a little slow on large files
" let g:cpp_experimental_template_highlight = 1           " which is a faster implementation but has some corner cases where it doesn't work.

"================================
" => YCM配置
"================================
function! Ycm_and_AutoPair_Return()
  if expand('<cword>') == '{}'
    return "\<CR>"
  else
    exe 'return '. substitute(substitute(execute('imap <s-cr>'),'^.*<SNR>','<SNR>', ''),'S-CR','CR','')
  endif
endfunction

inoremap <silent><cr> <c-r>=Ycm_and_AutoPair_Return()<cr><c-r>=AutoPairsReturn()<cr>

"================================
" => ALE配置
"================================
let g:ale_linters = {
      \   'cpp': ['cppcheck', 'gcc', 'clangtidy'],
      \   'c': ['gcc', 'cppcheck'],
      \   'sh': ['shellcheck'],
      \   'python': ['flake8', 'pylint'],
      \}
let g:ale_linters_explicit = 1
let g:ale_sign_column_always = 1
let g:ale_disable_lsp = 1
let g:ale_completion_enabled = 0
let g:ale_set_highlights = 1
let g:ale_echo_msg_format = '[%linter%] %s  [%severity%]'
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 1
let g:ale_lint_on_enter = 0
let g:ale_lint_on_save = 0
let g:ale_cpp_gcc_options = '-Wall -Wextra -O2 '. g:ale_and_quickrun_cpp_default_compile_flag
let g:ale_cpp_cppcheck_options = '--enable=warning,style,performance,portability -'.g:ale_and_quickrun_cpp_default_compile_flag
let g:ale_cpp_clangtidy_checks = ['*',
      \ '-android-*',
      \ '-fuchsia-*',
      \ '-*osx*',
      \ '-abseil*',
      \ '-*-avoid-c-arrays',
      \ '-google-build-using-namespace',
      \ '-google-readability-casting',
      \ '-google-runtime-references',
      \ '-llvm-include-order',
      \ '-cppcoreguidelines-pro-bounds-constant-array-index',
      \ '-cppcoreguidelines-narrowing-conversions',
      \ '-readability-magic-numbers',
      \ '-readability-isolate-declaration',
      \ '-misc-non-private-member-variables-in-classes',
      \ '-modernize-use-trailing-return-type']
let g:ale_cpp_clangtidy_options = g:ale_and_quickrun_cpp_default_compile_flag
" let g:ale_cpp_clangtidy_options = '-extra-arg="-Weverything -Wno-c++98-compat -Wno-c++98-compat-pedantic -Wno-pedantic -Wno-missing-prototypes -Wno-padded -Wno-old-style-cast -O2 '.g:ale_and_quickrun_cpp_compile_std.'"'
let g:ale_sign_error = '❌' " ✗
let g:ale_sign_warning = '⚡'
let g:ale_sign_info = '🛈 ' " ‼
let g:ale_echo_msg_error_str = '❌'
let g:ale_echo_msg_warning_str = '⚡'
let g:ale_echo_msg_info_str = '🛈 '
hi! clear SpellBad
hi! clear SpellCap
hi! clear SpellRare
hi! SpellBad gui=undercurl guisp=red
hi! SpellCap gui=undercurl guisp=yellow
hi! SpellRare gui=undercurl guisp=magenta

