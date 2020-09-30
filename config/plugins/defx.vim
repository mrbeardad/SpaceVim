"=============================================================================
" defx.vim --- defx configuration
" Copyright (c) 2016-2020 Wang Shidong & Contributors
" Author: Wang Shidong < wsdjeg@outlook.com >
" URL: https://spacevim.org
" License: GPLv3
"=============================================================================

let s:SYS = SpaceVim#api#import('system')

if g:spacevim_filetree_direction ==# 'right'
  let s:direction = 'rightbelow'
else
  let s:direction = 'leftabove'
endif

function! s:setcolum() abort
  if g:spacevim_enable_vimfiler_filetypeicon && !g:spacevim_enable_vimfiler_gitstatus
    return 'indent:icons:filename:type'
  elseif !g:spacevim_enable_vimfiler_filetypeicon && g:spacevim_enable_vimfiler_gitstatus
    return 'indent:icons:filename:type'
  elseif g:spacevim_enable_vimfiler_filetypeicon && g:spacevim_enable_vimfiler_gitstatus
    return 'indent:git:icons:filename:type'
  else
    return 'mark:indent:icon:filename:type'
  endif
endfunction

call defx#custom#option('_', {
      \ 'columns': s:setcolum(),
      \ 'winwidth': g:spacevim_sidebar_width,
      \ 'split': 'vertical',
      \ 'direction': s:direction,
      \ 'show_ignored_files': g:_spacevim_filetree_show_hidden_files,
      \ 'buffer_name': '',
      \ 'toggle': 1,
      \ 'resume': 1
      \ })

call defx#custom#column('mark', {
      \ 'readonly_icon': '',
      \ 'selected_icon': '',
      \ })

call defx#custom#column('icon', {
      \ 'directory_icon': '▶',
      \ 'opened_icon': '▼',
      \ 'root_icon': ' ',
      \ })

	call defx#custom#column('filename', {
	      \ 'max_width': -90,
	      \ })

let g:defx_git#indicators = {'Untracked': '', 'Unmerged': '≠', 'Ignored': '○', 'Renamed': '', 'Modified': '', 'Deleted': '✗', 'Unknown': '⁇', 'Staged': ''}

augroup vfinit
  au!
  autocmd FileType defx call s:defx_init()
  " auto close last defx windows
  autocmd BufEnter * nested if
        \ (!has('vim_starting') && winnr('$') == 1  && g:_spacevim_autoclose_filetree
        \ && &filetype ==# 'defx') |
        \ call s:close_last_vimfiler_windows() | endif
augroup END

" in this function, we should check if shell terminal still exists,
" then close the terminal job before close vimfiler
function! s:close_last_vimfiler_windows() abort
  call SpaceVim#layers#shell#close_terminal()
  q
endfunction

function! Leaderf_Defx_Search()
    let path = defx#get_candidate().action__path
    winc p
    if execute('command Leaderf') !~? 'no user-defined commands found'
      exe 'Leaderf file '. path
    else
      echoerr 'only for Leaderf'
    endif
endfunction

function! Ranger_Preview()
  if ! executable('ranger')
    echoerr 'You need to install `ranger`'
  endif
  let path = defx#get_candidate().action__path
  if $TMUX !=# ''
    exe "!tmux new-window 'ranger --selectfile=". path."'"
  elseif executable('guake')
    exe '!guake -n 1 -s 1 -e "ranger --selectfile='. path . '" --show'
  else
    echoerr 'you need to run your neovim in tmux, or You need to install guake!'
  endif
endfunction

function! Open_wtih_gui()
  if has('unix') || has('wsl')
    call jobstart('xdg-open '. defx#get_candidate().action__path)
  elseif has('win32')
    call jobstart('explorer.exe '. substitute(defx#get_candidate().action__path, $PWD . '/', '', 'g'))
  endif
endfunction

function! s:defx_init()
  setl nonumber
  setl norelativenumber
  setl listchars=
  setl nofoldenable
  setl foldmethod=manual

  " disable this mappings
  nnoremap <silent><buffer> <3-LeftMouse> <Nop>
  nnoremap <silent><buffer> <4-LeftMouse> <Nop>
  nnoremap <silent><buffer> <LeftMouse> <LeftMouse><Home>

  silent! nunmap <buffer> <Space>
  silent! nunmap <buffer> <C-l>
  silent! nunmap <buffer> <C-j>
  silent! nunmap <buffer> E
  silent! nunmap <buffer> gr
  silent! nunmap <buffer> gf
  silent! nunmap <buffer> -
  silent! nunmap <buffer> s

  " nnoremap <silent><buffer><expr> st  vimfiler#do_action('tabswitch')
  " nnoremap <silent><buffer> yY  :<C-u>call <SID>copy_to_system_clipboard()<CR>
  nnoremap <silent><buffer><expr> '
        \ defx#do_action('toggle_select') . 'j'
  " TODO: we need an action to clear all selections
  nnoremap <silent><buffer><expr> V
        \ defx#do_action('toggle_select_all')
  " nmap <buffer> v       <Plug>(vimfiler_quick_look)
  " nmap <buffer> p       <Plug>(vimfiler_preview_file)
  " nmap <buffer> i       <Plug>(vimfiler_switch_to_history_directory)

  " Define mappings
  nnoremap <silent><buffer><expr> gx
        \ defx#do_action('execute_system')
  nnoremap <silent><buffer><expr> <c-c>
        \ defx#do_action('copy')
  nnoremap <silent><buffer><expr> yy
        \ defx#do_action('copy')
  nnoremap <silent><buffer><expr> q
        \ defx#do_action('quit')
  nnoremap <silent><buffer><expr> <c-x>
        \ defx#do_action('move')
  nnoremap <silent><buffer><expr> dd
        \ defx#do_action('move')
  map <silent><buffer> p <nop>
  nnoremap <silent><buffer><expr> <c-v>
        \ defx#do_action('paste')
  nnoremap <silent><buffer><expr> pp
        \ defx#do_action('paste')
  nnoremap <silent><buffer><expr> h defx#do_action('call', 'DefxSmartH')
  nnoremap <silent><buffer><expr> <Left> defx#do_action('call', 'DefxSmartH')
  nnoremap <silent><buffer><expr> l defx#do_action('call', 'DefxSmartL')
  nnoremap <silent><buffer><expr> <Right> defx#do_action('call', 'DefxSmartL')
  nnoremap <silent><buffer><expr> o defx#do_action('call', 'DefxSmartL')
  nnoremap <silent><buffer><expr> <Cr> defx#do_action('call', 'DefxSmartL')
  nnoremap <silent><buffer><expr> <2-LeftMouse> defx#do_action('call', 'DefxSmartL')
  nnoremap <silent><buffer><expr> sg
        \ defx#do_action('drop', 'vsplit')
  nnoremap <silent><buffer><expr> sv
        \ defx#do_action('drop', 'split')
  nnoremap <silent><buffer><expr> st
        \ defx#do_action('drop', 'tabedit')
  nnoremap <silent><buffer> P :call Ranger_Preview()<cr><cr>
  nnoremap <silent><buffer> <c-p> :call Ranger_Preview()<cr><cr>

  nnoremap <silent><buffer> F :call Leaderf_Defx_Search()<cr>
  nnoremap <silent><buffer> <c-f> :call Leaderf_Defx_Search()<cr>

  nnoremap <silent><buffer> R :call defx#call_action('open_directory', SpaceVim#plugins#projectmanager#current_root())<cr>

  nnoremap <silent><buffer> O :call Open_wtih_gui()<cr>
  nnoremap <silent><buffer> <c-o> :call Open_wtih_gui()<cr>

  nnoremap <silent><buffer><expr> K
        \ defx#do_action('new_directory')
  nnoremap <silent><buffer><expr> N
        \ defx#do_action('new_file')
  nnoremap <silent><buffer><expr> <del>
        \ defx#do_action('remove')
  nnoremap <silent><buffer><expr> rm
        \ defx#do_action('remove')
  nnoremap <silent><buffer><expr> rn
        \ defx#do_action('rename')
  nnoremap <silent><buffer><expr> yp defx#do_action('call', 'DefxYarkPath')
  nnoremap <silent><buffer><expr> .
        \ defx#do_action('toggle_ignored_files')
  nnoremap <silent><buffer><expr> ~
        \ defx#do_action('cd')
  nnoremap <silent><buffer><expr> j
        \ line('.') == line('$') ? 'gg' : 'j'
  nnoremap <silent><buffer><expr> k
        \ line('.') == 1 ? 'G' : 'k'
  nnoremap <silent><buffer><expr> <C-r>
        \ defx#do_action('redraw')
  nnoremap <silent><buffer><expr> <C-g>
        \ defx#do_action('print')
  nnoremap <silent><buffer> <Home> :call cursor(2, 1)<cr>
  nnoremap <silent><buffer> <End>  :call cursor(line('$'), 1)<cr>
  nnoremap <silent><buffer><expr> <C-Home>
        \ defx#do_action('cd', SpaceVim#plugins#projectmanager#current_root())
	nnoremap <silent><buffer><expr> > defx#do_action('resize',
	\ defx#get_context().winwidth + 10)
	nnoremap <silent><buffer><expr> < defx#do_action('resize',
	\ defx#get_context().winwidth - 10)
endf

" in this function we should vim-choosewin if possible
function! DefxSmartL(_)
  if defx#is_directory()
    call defx#call_action('open_tree')
    normal! j
  else
    let filepath = defx#get_candidate()['action__path']
    if tabpagewinnr(tabpagenr(), '$') >= 3    " if there are more than 2 normal windows
      if exists(':ChooseWin') == 2
        ChooseWin
      else
        let input = input('ChooseWin No./Cancel(n): ')
        if input ==# 'n' | return | endif
        if input == winnr() | return | endif
        exec input . 'wincmd w'
      endif
      exec 'e' filepath
    else
      exec 'wincmd w'
      exec 'e' filepath
    endif
  endif
endfunction

function! DefxSmartH(_)
  " if cursor line is first line, or in empty dir
  if line('.') ==# 1 || line('$') ==# 1
    return defx#call_action('cd', ['..'])
  endif

  " candidate is opend tree?
  if defx#is_opened_tree()
    return defx#call_action('close_tree')
  endif

  " parent is root?
  let s:candidate = defx#get_candidate()
  let s:parent = fnamemodify(s:candidate['action__path'], s:candidate['is_directory'] ? ':p:h:h' : ':p:h')
  let sep = s:SYS.isWindows ? '\\' :  '/'
  if s:trim_right(s:parent, sep) == s:trim_right(b:defx.paths[0], sep)
    return defx#call_action('cd', ['..'])
  endif

  " move to parent.
  call defx#call_action('search', s:parent)

  " if you want close_tree immediately, enable below line.
  call defx#call_action('close_tree')
endfunction

function! DefxYarkPath(_) abort
  let candidate = defx#get_candidate()
  let @+ = candidate['action__path']
  echo 'yanked: ' . @+
endfunction

function! s:trim_right(str, trim)
  return substitute(a:str, printf('%s$', a:trim), '', 'g')
endfunction
