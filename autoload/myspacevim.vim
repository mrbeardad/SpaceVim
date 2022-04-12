function! myspacevim#before() abort
    set ignorecase
    set smartcase
    set autochdir
    set list
    set shell=/usr/bin/bash

    function! s:mycursorpos() abort
      return ' %P  %l/%L : %c '
    endf
    call SpaceVim#layers#core#statusline#register_sections('mycursorpos', function('s:mycursorpos'))

    let g:table_mode_syntax = 0
    let g:table_mode_auto_align = 0
		let g:table_mode_always_active = 0
    let g:_spacevim_mappings.t = {'name' : '+Table Mode'}
    let g:clever_f_smart_case = 1
    let g:clever_f_fix_key_direction = 1
    let g:EasyMotion_smartcase = 1

    let g:translator_default_engines = ['bing', 'youdao']
    let g:indent_blankline_show_first_indent_level = v:false
    let g:Lf_GtagsSource = 2
    let g:Lf_Gtagslabel = 'native-pygments'

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

function! myspacevim#after() abort
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

    nmap <C-D> <Plug>(SmoothieForwards)
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
    nnoremap <C-T> :call feedkeys(":Leaderf gtags\<lt>CR>".expand('<cword>'))<CR>
    nnoremap <silent><F12> :YcmCompleter GoTo<Cr>
    nnoremap <silent><S-F12> :YcmCompleter GoToReferences<Cr>

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
    nnoremap <C-K>o :e <C-R>=getcwd()<Cr>/
    nnoremap <C-K>r :Leaderf neomru<Cr>
    nnoremap <silent><M-s> :SudoWrite<Cr>
    " map terminal key ctrl+shift+s to sendkey <Esc>S
    nmap <M-S> [SPC]fa
    nnoremap <silent><C-K>s :wall<Cr>
    nnoremap <silent><C-W>w :call SpaceVim#mapping#close_current_buffer()<Cr>
    nnoremap <silent><C-K>u :call SpaceVim#mapping#clear_saved_buffers()<Cr>
    nmap <silent><C-K>w [SPC]bo
    nnoremap <C-Q> :qa<Cr>
    nnoremap <silent><C-W>z :stop<Cr>
    nnoremap Q q

    nnoremap <silent><tab> :winc w<cr>
    nnoremap <silent><s-tab> :winc W<cr>

    nnoremap <silent><F1> :Defx<Cr>
    nnoremap <silent><F3> :call SpaceVim#plugins#todo#list()<Cr>
    nmap <M-`> [SPC]'

    function s:open_file_in_explorer()
      if has('win32') || has('wsl')
        call jobstart('explorer.exe .')
      elseif has('unix')
        call jobstart('xdg-open .')
      endif
    endf
    nnoremap <silent><M-E> :call <SID>open_file_in_explorer()<Cr>
    nmap <silent><M-R> :w<Cr>[SPC]lr
    nnoremap <silent><M-z> :setlocal wrap!<Cr>
    nnoremap <M-t> :TranslateW<Cr>
    vnoremap <M-t> :TranslateW<Cr>
    nnoremap <M-T> :Translate<Cr>
    vnoremap <M-T> :Translate<Cr>
    nmap <M-F> [SPC]bf
    command CodeCounter exe "!cloc ".SpaceVim#plugins#projectmanager#current_root()
    nnoremap <silent><M-C> :Calc<Cr>
endf
