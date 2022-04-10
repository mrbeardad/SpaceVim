function! myspacevim#before() abort
    set ignorecase
    set smartcase
    set autochdir
    set shell=/usr/bin/bash

    function! s:mycursorpos() abort
      return ' %P  %l/%L : %c '
    endf
    call SpaceVim#layers#core#statusline#register_sections('mycursorpos', function('s:mycursorpos'))

    let g:translator_default_engines = ['bing', 'youdao']
    let g:indent_blankline_show_first_indent_level = v:false
    let g:Lf_Gtagslabel = 'native-pygments'

    let g:ycm_semantic_triggers =  {
      \   'c': ['re!\w', '->', '.'],
      \   'objc': ['re!\w', '->', '.', 're!\[[_a-zA-Z]+\w*\s', 're!^\s*[^\W\d]\w*\s',
      \            're!\[.*\]\s'],
      \   'ocaml': ['re!\w', '.', '#'],
      \   'cpp,cuda,objcpp': ['re!\w', '->', '.', '::'],
      \   'perl': ['re!\w', '->'],
      \   'php': ['re!\w', '->', '::'],
      \   'cs,d,elixir,go,groovy,java,javascript,julia,perl6,python,scala,typescript,vb': ['re!\w', '.'],
      \   'ruby,rust': ['re!\w', '.', '::'],
      \   'lua': ['re!\w', '.', ':'],
      \   'erlang': ['re!\w', ':'],
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
    nnoremap <Leader>y "+y
    nnoremap <Leader>Y "+y$
    vnoremap <Leader>y "+y
    nnoremap <Space>y ggVG"+y<C-O>
    nnoremap =p "0p
    nnoremap =P "0P
    vnoremap =p "0p
    nnoremap <silent>=o :<C-U>put =@0<CR>
    nnoremap <silent>=O :<C-U>put! =@0<CR>
    nnoremap <Leader>p "+p
    nnoremap <Leader>P "+P
    vnoremap <Leader>p "+p
    nnoremap <silent><leader>o :<C-U>put =@+<CR>
    nnoremap <silent><leader>O :<C-U>put! =@+<CR>
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
    inoremap [9 <End><Cr>

    inoremap <expr> <C-K> repeat('<Delete>', strchars(getline('.')) - getcurpos()[2] + 1)
    inoremap <C-L> <C-C><Right>cw

    inoremap <C-Z> <C-C>ui
    nnoremap <C-Z> u
    vnoremap <C-Z> u
    
    nmap <C-_> <Plug>NERDCommenterInvert
    
    nnoremap <silent><C-F> :call SpaceVim#plugins#flygrep#open({'input' : input("grep pattern:"), 'dir' : get(b:, "rootDir", getcwd())})<CR>
    nnoremap <silent>[6 :Leaderf command<Cr>
    nnoremap <silent>[7 :LeaderfBufTag<Cr>
    nmap <C-T> <Plug>LeaderfGtagsGrep
    nnoremap <silent><C-G> :Leaderf gtags<Cr>
    nnoremap <silent><F12> :YcmCompleter GoTo<Cr>
    nnoremap <silent><S-F12> :YcmCompleter GoToReferences<Cr>

    nnoremap <expr> n  'Nn'[v:searchforward]
    nnoremap <expr> N  'nN'[v:searchforward]

    nnoremap <silent> mm :<C-u>BookmarkToggle<Cr>
    nnoremap <silent> mi :<C-u>BookmarkAnnotate<Cr>
    nnoremap <silent> mc :<C-u>BookmarkClear<Cr>
    nnoremap <silent> mC :<C-u>BookmarkClearAll<Cr>
    nnoremap <silent> ml :<C-u>BookmarkShow<Cr>
    nnoremap <silent> mL :<C-u>BookmarkShowAll<Cr>
    nnoremap <silent> mn :<C-u>BookmarkNext<Cr>
    nnoremap <silent> mb :<C-u>BookmarkPrev<Cr>

    nnoremap <silent><F1> :Defx<Cr>
    nnoremap <silent><F3> :call SpaceVim#plugins#todo#list()<Cr>
    
    nnoremap <silent><Leader>n :bn<Cr>
    nnoremap <silent><Leader>b :bp<Cr>
    nmap <silent><Leader><Tab> [SPC]<Tab>
    
    nnoremap <silent><C-K>n :enew<Cr>
    nnoremap <C-K>o :e <C-R>=getcwd()<Cr>/
    nnoremap <C-K>r :Leaderf neomru<Cr>
    nmap [8 [SPC]fa
    nnoremap <silent><C-K>s :wall<Cr>
    nnoremap <silent><M-S> :SudoWrite<Cr>
    nnoremap <silent><C-W>x :call SpaceVim#mapping#close_current_buffer()<Cr>
    nnoremap <silent><C-K>u :call SpaceVim#mapping#clear_saved_buffers()<Cr>
    
    nnoremap <silent><tab> :winc w<cr>
    nnoremap <silent><s-tab> :winc W<cr>

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
    nnoremap <silent><C-W>z :stop<Cr>
endf
