setlocal foldmethod=indent
let g:python_highlight_all=1
let g:python_highlight_space_errors=0
inoremap <buffer> # X<BS>#
nnoremap <buffer><expr> h col('.')==1 ? "zC" : "h"
nnoremap <buffer><expr> l foldclosed(line('.'))!=-1 ? "zO" : "l"
