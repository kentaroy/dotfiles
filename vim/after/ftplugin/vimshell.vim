" Vimshell setting.
call unite#custom_default_action('vimshell/history', 'execute')
let g:vimshell_execute_file_list  =  {}
call vimshell#set_execute_file('txt,vim,c,h,cpp,hpp,py,tex', 'vim')
call vimshell#set_execute_file('png,eps,bmp,jpg', 'gexe display')
call vimshell#set_execute_file('pdf', 'gexe evince')
call vimshell#set_execute_file('dvi', 'gexe xdvi')
call vimshell#set_execute_file('html,xhtml', 'gexe google-chrome')
call vimshell#set_execute_file('wmv,mp4', 'avplay -loop 0')
call vimshell#set_execute_file('log,inp,trj,dat', 'gexe wxmacmolplt')
call vimshell#altercmd#define('g', 'git') 
call vimshell#altercmd#define('pv', 'gexe paraview') 
call vimshell#altercmd#define('p', 'python3') 
call vimshell#altercmd#define('m', 'make') 

"Key mappings.
imap <buffer><expr> ,       getline('.')[col('.')-2] == ' ' ? "\<Esc><C-^>" : ','
imap <buffer><expr> <Space> getline('.')[col('.')-2] == ' ' ? "\<Plug>(vimshell_history_unite)" : ' '
imap <buffer>       <C-l>   <Plug>(vimshell_clear)
nmap <buffer>       0       <Plug>(vimshell_move_head)

nnoremap <Plug>(colon) :
nmap <buffer> X <Plug>(colon)call <SID>extract_file()<CR>GA<C-u><C-r>x<CR><Esc>
function! s:extract_file()
    normal! "xyiW 
    let m = @x
    let m = substitute(m, ':.*$', '', '')
    let @x = m
    let @/ = m
endfunction
