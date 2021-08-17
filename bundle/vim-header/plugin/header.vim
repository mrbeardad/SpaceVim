" Commands for vim user
" Author Info Headers
command! AddHeader call header#add_header(0, 0, 0)
command! AddMinHeader call header#add_header(1, 0, 0)
" License Headers
command! AddAGPLicense call header#add_header(2, 'agpl', 0)
command! AddApacheLicense call header#add_header(2, 'apache', 0)
command! AddEUPLicense call header#add_header(2, 'eupl', 0)
command! AddGNULicense call header#add_header(2, 'gnu', 0)
command! AddLGPLLicense call header#add_header(2, 'lgpl', 0)
command! AddMITLicense call header#add_header(2, 'mit', 0)
command! AddMPLLicense call header#add_header(2, 'mpl', 0)
command! AddWTFPLLicense call header#add_header(2, 'wtfpl', 0)
command! AddZlibLicense call header#add_header(2, 'zlib', 0)

" Set default global values
if !exists('g:header_auto_add_header') || g:header_auto_add_header == 1
    autocmd BufNewFile * call header#add_header(0, 0, 1)
    autocmd BufWritePre * silent! :AddHeader " Update date when saving buffer
elseif !exists('g:header_auto_update_header') || g:header_auto_add_header == 1
    autocmd BufWritePre * silent! :call header#update_header() " Update date when saving buffer
endif
