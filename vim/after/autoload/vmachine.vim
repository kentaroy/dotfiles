function! vmachine#purchase(table_key, ...)
    " you can give dict-key directory by the optional argument
    let key = a:0 >= 1 ? a:1 : nr2char(getchar())

    " get the reference of the table
    let scope = exists('b:vmachine_table') ? 'b' : 'g'
    execute 'let table = ' . scope . ':vmachine_table[a:table_key]'

    " return the corresponding strings
    if has_key(table, key)
        return table[key]
    else 
        return "\<Esc>"
    endif
endfunction



function! vmachine#supply(inp)
    " ------------------------------------------------------------
    " key       char    the name of vmachine unit
    " table     char    dictionary
    " prefix    char    vmachine prefix
    " headers   list    consists of map prefixes such as 'n', 'i', etc.
    " replace   bool    whether an argument of operator is replaced or not
    " local     bool    buffer local table 
    " ------------------------------------------------------------
    let key     = a:inp['key']
    let replace = has_key(a:inp, 'replace') ? a:inp['replace'] : 0
    let local   = has_key(a:inp, 'local')   ? a:inp['local'] :   0

    " table and prefix
    let scope = local ? 'b' : 'g'
    if ! exists('g:vmachine_table') 
        let g:vmachine_table  = {}
        let g:vmachine_prefix = {}
    endif 
    if local && ! exists('b:vmachine_table') 
        let b:vmachine_table  = deepcopy(g:vmachine_table)
        let b:vmachine_prefix = deepcopy(g:vmachine_prefix)
    endif 
    execute 'let ' . scope . ':vmachine_table[key]  = a:inp[''table'']' 
    execute 'let ' . scope . ':vmachine_prefix[key] = a:inp[''prefix'']' 

    " basic key mappings
    call <SID>set_base_mappings(key, a:inp['headers'], local)

    " extra key mappings if needed
    if replace
        call <SID>set_extra_mappings(key, local)
    endif
endfunction



function! s:set_base_mappings(key, headers, local)
    " ------------------------------
    " a) basic mapping such as 
    "   imap <expr> ; vmachine#purchase('s')
    " 
    " b) and mappings for returning itself such as
    "   noremap ;<Space> ;
    " 
    " c) raw strokes as
    "   inoremap <expr> <C-v>; "\<C-v>" . vmachine#purchcase('s')
    " ------------------------------
    let scope = a:local ? 'b' : 'g'
    " let prefix = g:vmachine_prefix[a:key]
    execute 'let prefix = ' . scope . ':vmachine_prefix[a:key]'
    let buf = a:local ? '<buffer>' : ''
    for h in a:headers 
        " a)
        execute h . 'map '. buf . '<expr> ' . prefix . ' vmachine#purchase('''. a:key . ''')'

        " b)
        execute h . 'noremap ' . buf . ' ' . prefix . '<Space> ' . prefix

        " c)
        execute h . 'noremap ' . buf . '<expr> ' . '<C-v>' . prefix ' ' .  '"\<C-v>"' . ' . vmachine#purchase('''. a:key . ''')'  

    endfor 
endfunction




function! s:set_extra_mappings(key, local)
    let map_list = {
                \ 'n': ['r', 'g', 'y',], 
                \ 'o': ['r', 't', 'f', 'a', 'i'], 
                \ 'x': ['r', 't', 'f', 'a', 'i'], 
                \}
    let k = a:key
    let scope = a:local ? 'b' : 'g'
    execute 'let prefix = ' . scope . ':vmachine_prefix[k]'
    for m in keys(map_list)
        for a in map_list[m]
            execute m . 'noremap <expr> ' . a . prefix . ' ''' . a .
                        \''' . vmachine#purchase(''' . k . ''')'
        endfor
    endfor
endfunction
