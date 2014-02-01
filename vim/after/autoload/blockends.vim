function! s:jumpable()
    " if match, g:blockends#jump_char is set
    let found = 0
    " start scanning char by char
    let col = col('.')
    let l = 0
    while col + l < col("$") 
        let char = getline(".")[col+l-1]
        for c in g:blockends#end_char 
            if char =~ c 
                let g:blockends#jump_char = c
                let found = 1
            endif
            if found
                break 
            endif 
        endfor 
        if found
            break 
        endif 
        let l += 1
    endwhile
    return found
endfunction

function! blockends#jump_char_or_end(torf)
    if <SID>jumpable()    
        let c = g:blockends#jump_char
        let jump_command = a:torf . c[len(c)-1]
        echo jump_command 
        return jump_command
    else
        return '$'
    endif
endfunction
