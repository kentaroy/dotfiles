augroup ftdetect
    autocmd!
augroup END
autocmd BufNewFile,BufRead *.src setfiletype fortran
autocmd BufNewFile,BufRead *.md setlocal filetype=markdown
