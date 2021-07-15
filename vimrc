"=============================================================================
" vimrc --- Entry file for vim
" Copyright (c) 2016-2020 Shidong Wang & Contributors
" Author: Shidong Wang < wsdjeg@outlook.com >
" URL: https://spacevim.org
" License: GPLv3
"=============================================================================

" ============================ Before Load SpaceVim ==========================
" Note: Skip initialization for vim-tiny or vim-small.
if 1
    let g:_spacevim_if_lua = 0
    if has('lua')
        if has('win16') || has('win32') || has('win64')
            let s:plugin_dir = fnamemodify(expand('<sfile>'), ':h').'\lua'
            let s:str = s:plugin_dir . '\?.lua;' . s:plugin_dir . '\?\init.lua;'
        else
            let s:plugin_dir = fnamemodify(expand('<sfile>'), ':h').'/lua'
            let s:str = s:plugin_dir . '/?.lua;' . s:plugin_dir . '/?/init.lua;'
        endif
        silent! lua package.path=vim.eval("s:str") .. package.path
        if empty(v:errmsg)
            let g:_spacevim_if_lua = 1
        endif
    endif
    execute 'source' fnamemodify(expand('<sfile>'), ':h').'/main.vim'
endif
" ============================ After Load SpaceVim  ==========================

" WSL clipboard
if has('windows')
    let s:clip = 'win32yank.exe -i --crlf'
    augroup WSLYank
        autocmd!
        autocmd TextYankPost * if v:event.operator ==# 'y' && v:event.regname ==# 'x' | call system(s:clip, @x) | endif
        autocmd TextYankPost * let g:fuck = deepcopy(v:event)
    augroup END
    xnoremap <Leader>y "xy
    nnoremap <leader>y "xy
    nnoremap <leader>Y "xy$
    nnoremap <leader>, "xyl
    xnoremap <silent><leader>p :r !win32yank.exe -o --lf<cr>
    nnoremap <silent><leader>p :let @x = system('win32yank.exe -o --lf')<cr>"xp
    nnoremap <silent><leader>o :r !win32yank.exe -o --lf<cr>
endif

" cursor shape
let &t_SI.="\e[5 q"
let &t_EI.="\e[1 q"

" color schemes
set termguicolors
let s:colorschemes = [
      \ 'SpaceVim',
      \ 'gruvbox',
      \ 'NeoSolarized',
      \ 'palenight',
      \ 'material',
      \]
if &diff == 1
  colorscheme gruvbox
elseif $DARKBG !=# ''
  if index(s:colorschemes, $DARKBG) > 0
    exe 'colorscheme '. $DARKBG
  else
    exe 'colorscheme '. s:colorschemes[localtime() % 5]
  endif
endif
