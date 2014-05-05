setlocal foldmethod=indent
let g:python_highlight_all=1
let g:python_highlight_space_errors=0
inoremap <buffer> # X<BS>#

" jedi-vim "{{{
nnoremap <buffer> [jedi] <Nop>
nmap <buffer> <C-j> [jedi]
nmap <buffer> [jedi]d <Plug>(jedi-goto-definitions)
nmap <buffer> [jedi]a <Plug>(jedi-goto-assignments))
nmap <buffer> [jedi]u <Plug>(jedi-usages-command)
nmap <buffer> [jedi]r <Plug>(jedi-rename-command)
nmap <buffer> K  <Plug>(jedi-documatation-command))
"}}}
