let b:fortran_do_enddo = 1
setlocal colorcolumn=6,73
setlocal tabstop=8 shiftwidth=2 softtabstop=2
nnoremap <buffer> ]m /\c^\s*module<CR>/module<CR>
nnoremap <buffer> [m ?\c^\s*module<CR>/module<CR>
highlight FortranSerialNumber term=reverse ctermfg=15 ctermbg=12 guifg=White guibg=Red
