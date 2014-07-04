function! put_jumpable#put(key, lchar, rchar)
    let s = getline('.')[col('.')-2]
    if a:key == s
        let s = getline('.')[col('.')-1]
        echo s
        if s == a:rchar
            let ret = ""
        else
            let ret = "\<BS>"
        endif
        let ret .= a:lchar . a:rchar
        let ret .= "<`0`>"
        for i in range(len(a:rchar)+5)
            let ret .= "\<Left>"
        endfor
    else
        let ret = a:key
    endif
    return ret
endfunction

inoremap <expr> ( put_jumpable#put('(', '(', ')')
