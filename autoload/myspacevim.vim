scriptencoding utf-8

function! s:mycursorpos() abort
  return ' %P  %l/%L : %c '
endf

function s:toggle_defx_and_tagbar()
  let prev_winid = win_getid()

  let defx_bufnr = bufnr('[defx] -0')
  if defx_bufnr == -1
    Defx -direction=topleft
    Defx -close
    let defx_bufnr = bufnr('[defx] -0')
  endif
  let is_defx_opend = bufwinid(defx_bufnr) != -1
  let is_tagbar_opend = bufwinid(bufnr(t:tagbar_buf_name)) != -1
  if is_tagbar_opend == v:true || is_defx_opend == v:true
    TagbarClose
    Defx -close
  else
    call tagbar#ToggleWindow('f')
    split +exe\ 'b\ '.defx_bufnr
  endif

  call win_gotoid(prev_winid)
endf

function s:open_file_in_explorer()
  if has('win32') || has('wsl')
    call jobstart('explorer.exe .')
  elseif has('unix')
    call jobstart('xdg-open .')
  endif
endf

function! s:smartquit(range)
  " if user have specified range, then colse target window
  if a:range != 0
    exe a:range.'close'
    " redraw windows number
    let &l:statusline = SpaceVim#layers#core#statusline#get(1)
    return
  endif
  " if there is not last one user window displayed, close it
  let win_layout = split(substitute(string(winlayout()), '\D', ' ', 'g'))
  call SpaceVim#mapping#SmartClose()
  if len(split(substitute(string(winlayout()), '\D', ' ', 'g'))) != len(win_layout)
    return
  endif
  " if there is last one user window displayed, quit vim
  if len(getbufinfo({'buflisted':1,'bufloaded':1,'bufmodified':1})) > 0
    echohl WarningMsg
    echon 'There are some buffer modified! Quit/Save/Cancel'
    let rs = nr2char(getchar())
    echohl None
    if rs ==? 'q'
      qall!
    elseif rs ==? 's' || rs ==? 'w'
      redraw
      wall
      qall
    else
      redraw
      echohl ModeMsg
      echon 'canceled!'
      echohl None
    endif
  else
    qall
  endif
endf

" preload configuration for plugins
function! myspacevim#before() abort
    set ignorecase
    set smartcase
    " set autochdir
    set list
    set shell=/usr/bin/bash

    call SpaceVim#layers#core#statusline#register_sections('mycursorpos', function('s:mycursorpos'))

    augroup MySpaceVim
      au!
      autocmd VimEnter * RainbowParentheses
      autocmd FileType defx nnoremap <silent><buffer><expr> <C-End> defx#do_action('cd', getcwd())
      autocmd VimResized * exe "normal \<C-W>="
    augroup END

    let g:table_mode_syntax = 0
    let g:table_mode_auto_align = 1
		let g:table_mode_always_active = 0
    let g:_spacevim_mappings.t = {'name' : '+Table Mode'}

    let g:clever_f_smart_case = 1
    let g:clever_f_fix_key_direction = 1

    let g:EasyMotion_smartcase = 1

    let g:translator_default_engines = ['bing', 'youdao']

    let g:indent_blankline_show_first_indent_level = v:false

    " let g:Lf_GtagsAutoGenerate = 1
    let g:Lf_GtagsSource = 2
    let g:Lf_GtagsfilesCmd = {
            \ '.git': 'git ls-files --recurse-submodules; git ls-files --exclude-standard -o',
            \ '.hg': 'hg files',
            \ 'default': 'rg --no-messages --files'
            \}
    let g:Lf_Gtagslabel = 'native-pygments'

    let g:ycm_clangd_args = ['--clang-tidy']
    let g:ycm_semantic_triggers = {
      \ 'erlang': ['re!\w{2}'],
      \ 'c': ['re!\w{2}'],
      \ 'perl': ['re!\w{2}'],
      \ 'cpp,objcpp': ['re!\w{2}'],
      \ 'lua': ['re!\w{2}'],
      \ 'cs,javascript,d,python,perl6,scala,vb,elixir,go': ['re!\w{2}'],
      \ 'php': ['re!\w{2}'],
      \ 'objc': ['re!\w{2}'],
      \ 'ocaml': ['re!\w{2}'],
      \ 'ruby': ['re!\w{2}'],
      \ 'java,jsp': ['re!\w{2}']
      \ }
    " https://microsoft.github.io/language-server-protocol/implementors/servers/
    let g:ycm_language_server =
      \ [
      \   {
      \     'name': 'vim',
      \     'cmdline': [ 'vim-language-server', '--stdio' ],
      \     'filetypes': [ 'vim' ],
      \    },
      \ ]
    let g:ycm_key_invoke_completion = '<C-\>'
    let g:ycm_error_symbol = g:spacevim_error_symbol
    let g:ycm_warning_symbol = g:spacevim_warning_symbol
endf

" override configurations in spacevim
function! myspacevim#after() abort
    let g:neomake_c_enabled_makers = ['cppcheck']
    let g:neomake_cpp_enabled_makers = ['cppcheck']
    unlet g:neomake_c_enabled_makers
    unlet g:neomake_cpp_enabled_makers

    inoremap <C-C> <Esc>

    inoremap <C-A> <Home>
    inoremap <C-E> <End>
    nnoremap <C-A> <Home>
    nnoremap <C-E> <End>
    vnoremap <C-A> <Home>
    vnoremap <C-E> <End>
    nnoremap <C-Left> b
    nnoremap <C-Right> w
    vnoremap <C-Left> b
    vnoremap <C-Right> w
    nmap ; <Plug>(better-easymotion-overwin-f)

    " nmap <C-D> <Plug>(SmoothieForwards)
    nnoremap <silent><C-Down> <C-Y>
    nnoremap <silent><C-Up>   <C-E>

    nnoremap  Y y$
    let g:_spacevim_mappings.y = ['normal! "+y', 'yank to clipboard']
    nnoremap <Leader>y "+y
    let g:_spacevim_mappings.Y = ['normal! "+y$', 'yank all after cursor']
    nnoremap <Leader>Y "+y$
    vnoremap <Leader>y "+y
    call SpaceVim#mapping#space#def('nnoremap', ['y'], 'normal gg"+yG``', 'copy-whole-buffer-to-clipboard', 1)
    nnoremap <Space>y gg"+yG''
    nnoremap =p "0p
    nnoremap =P "0P
    vnoremap =p "0p
    nnoremap <silent>=o :<C-U>put =@0<CR>
    nnoremap <silent>=O :<C-U>put! =@0<CR>
    nnoremap <Leader>p "+p
    nnoremap <Leader>P "+P
    vnoremap <Leader>p "+p
    let g:_spacevim_mappings.o = ['put =@+', 'paste to next line']
    nnoremap <silent><leader>o :<C-U>put =@+<CR>
    let g:_spacevim_mappings.O = ['put! =@+', 'paste to previous line']
    nnoremap <silent><leader>O :<C-U>put! =@+<CR>
    call SpaceVim#mapping#space#def('nnoremap', ['p'], 'normal ggdG"+P', 'copy-clipboard-to-whole-buffer', 1)
    nnoremap <Space>p ggdG"+P

    nnoremap <S-Left> <<
    nnoremap <S-Right> >>
    vnoremap <S-Left> <<
    vnoremap <S-Right> >>
    inoremap <S-Left> <C-D>
    inoremap <S-Right> <C-T>
    nnoremap <silent><S-Down> :m .+1<CR>==
    nnoremap <silent><S-Up> :m .-2<CR>==
    inoremap <silent><S-Down> <Esc>:m .+1<CR>==gi
    inoremap <silent><S-Up> <Esc>:m .-2<CR>==gi
    vnoremap <silent><S-Down> :m '>+1<CR>gv=gv
    vnoremap <silent><S-Up> :m '<-2<CR>gv=gv
    " map terminal key ctrl+enter to sendkey <Esc>N
    inoremap <M-N> <End><Cr>
    inoremap <expr> <C-K> repeat('<Delete>', strchars(getline('.')) - getcurpos()[2] + 1)
    inoremap <C-L> <C-C><Right>cw
    inoremap <C-Z> <C-C>ui
    nnoremap <C-Z> u
    vnoremap <C-Z> u
    nmap <C-_> <Plug>NERDCommenterInvert
    
    nnoremap <silent><C-F> :call SpaceVim#plugins#flygrep#open({'input' : input("grep pattern:"), 'dir' : get(b:, "rootDir", getcwd())})<CR>
    " map terminal key ctrl+shift+p to sendkey <Esc>P
    nnoremap <silent><M-P> :Leaderf command<Cr>
    " map terminal key ctrl+shift+o to sendkey <Esc>O
    nnoremap <silent><M-O> :LeaderfBufTag<Cr>
    nnoremap <silent><C-T> :Leaderf gtags --result=ctags-x --all --cword<Cr>
    nnoremap <silent><F2> :exe 'YcmCompleter RefactorRename '.input('refactor \"'.expand('<cword>').'\" to:')<Cr>
    nnoremap <silent><F12> :YcmCompleter GoTo<Cr>
    nnoremap <silent><F24> :YcmCompleter GoToReferences<Cr>

    nnoremap <expr> n  'Nn'[v:searchforward]
    nnoremap <expr> N  'nN'[v:searchforward]
    nnoremap <silent><Bs> :nohl<Cr>

    nnoremap <silent> mm :<C-u>BookmarkToggle<Cr>
    nnoremap <silent> mi :<C-u>BookmarkAnnotate<Cr>
    nnoremap <silent> mc :<C-u>BookmarkClear<Cr>
    nnoremap <silent> mC :<C-u>BookmarkClearAll<Cr>
    nnoremap <silent> ml :<C-u>BookmarkShow<Cr>
    nnoremap <silent> mL :<C-u>BookmarkShowAll<Cr>
    nnoremap <silent> mn :<C-u>BookmarkNext<Cr>
    nnoremap <silent> mb :<C-u>BookmarkPrev<Cr>

    let g:_spacevim_mappings.n = ['bn', 'next buffer']
    nnoremap <silent><Leader>n :bn<Cr>
    let g:_spacevim_mappings.b = ['bp', 'backward buffer']
    nnoremap <silent><Leader>b :bp<Cr>
    nnoremap <silent><C-K>n :enew<Cr>
    nnoremap <C-K>o :e <C-R>=expand('%:p')<Cr>
    nnoremap <C-K>r :Leaderf neomru<Cr>
    nnoremap <silent><M-s> :SudoWrite<Cr>
    cunmap w!!
    " map terminal key ctrl+shift+s to sendkey <Esc>S
    nmap <M-S> [SPC]fa
    nnoremap <silent><C-K>s :wall<Cr>
    nnoremap <silent><C-W>w :call SpaceVim#mapping#close_current_buffer()<Cr>
    nnoremap <silent><C-K>u :call SpaceVim#mapping#clear_saved_buffers()<Cr>
    nmap <silent><C-K>w [SPC]bo
    nnoremap <C-W>z :stop<Cr>
    command! -range SmartQuit call s:smartquit(<range>)
    nnoremap <silent>q :SmartQuit<Cr>
    nnoremap Q q

    " map terminal key ctrl+i to sendkey <Esc>I
    nnoremap <M-I> <C-I>
    nnoremap <silent><tab> :winc w<cr>
    nnoremap <silent><s-tab> :winc W<cr>

    nnoremap <silent><F1> :call <SID>toggle_defx_and_tagbar()<Cr>
    nmap <M-`> [SPC]'

    nnoremap <silent><M-E> :call <SID>open_file_in_explorer()<Cr>
    nmap <silent><M-R> :w<Cr>[SPC]lr
    nnoremap <silent><M-z> :setlocal wrap!<Cr>
    nnoremap <M-t> :TranslateW<Cr>
    vnoremap <M-t> :TranslateW<Cr>
    nnoremap <M-T> :Translate<Cr>
    vnoremap <M-T> :Translate<Cr>
    nmap <M-F> [SPC]bf
    nnoremap <silent><M-C> :Calc<Cr>
    command CodeCounter exe "!cloc ".SpaceVim#plugins#projectmanager#current_root()
endf
