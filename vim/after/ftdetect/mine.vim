augroup ftdetect
    autocmd!
augroup END
autocmd ftdetect BufNewFile,BufRead *.src setfiletype fortran
autocmd ftdetect BufNewFile,BufRead *.md setlocal filetype=markdown
