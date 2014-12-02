" Insert mode mapping.
imap <buffer> <Tab>   <Plug>(unite_select_next_line)
imap <buffer> <S-Tab> <Plug>(unite_select_previous_line)
imap <buffer> A       <Plug>(unite_choose_action)

" Normal mode mapping.
nmap <buffer> <Tab>   <Plug>(unite_loop_cursor_down)
nmap <buffer> <S-Tab> <Plug>(unite_loop_cursor_up)

" Action shortcut.
inoremap <expr><silent><buffer> E unite#do_action('insert')
inoremap <expr><silent><buffer> R unite#do_action('rec/async')
inoremap <expr><silent><buffer> S unite#do_action('split')
inoremap <expr><silent><buffer> V unite#do_action('vsplit')
inoremap <expr><silent><buffer> T unite#do_action('tabopen')
inoremap <expr><silent><buffer> , unite#do_action('vimshell')
