function! fastmove#fastmove(direction, ndiv)
    let wtime = 50      " wait time in miliseconds
    let mndiv = 2       " step times in one scroll

    " Get the maximum size of window.
    let l:win_size = winheight(".")
    let l:col = col(".") - 1        " save the initial position

    " Determine the step size. 
    let ndivide = a:ndiv * mndiv
    let l:step_size = (l:win_size - (l:win_size % ndivide)) / ndivide

    " Move.
    for i in range(mndiv)
        execute "normal! " . l:step_size . a:direction . "zz"
        redraw
        if i != mndiv - 1
            execute "sleep ". wtime . " m"
        endif 
    endfor
    execute "normal! 0" . l:col . "l"
endfunction

" call fastmove#fastmove('j', 4)
