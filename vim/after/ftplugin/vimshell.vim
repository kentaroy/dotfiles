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
call vimshell#altercmd#define('g', 'gexe') 
call vimshell#altercmd#define('sl', 'ls') 

" Key mappings.
imap <buffer><expr> ,       getline('.')[col('.')-2] == ' ' ? "\<Esc><C-^>" : ','
imap <buffer><expr> <Space> getline('.')[col('.')-2] == ' ' ? "\<Plug>(vimshell_history_unite)" : ' '
imap <buffer>       <C-l>   <Plug>(vimshell_clear)
nmap <buffer>       0       <Plug>(vimshell_move_head)

" zsh-like tabcompletion for directory stack.
let g:vimshell_dir_expr = "\<C-u>dirs\<CR>\<Esc>dk\<C-p>Ccd \<C-v>-"
imap <buffer><expr> <Tab>   pumvisible() ? "\<C-n>" : getline('.')[col('.')-5:col('.')-2]=='cd -' ? g:vimshell_dir_expr : "\<Plug>(vimshell_command_complete)"

" Execute selected files by X in normal mode.
nnoremap <Plug>(colon) :
nmap <buffer> X <Plug>(colon)call <SID>extract_file()<CR>GA<C-u><C-r>x<CR><Esc>
function! s:extract_file()
    normal! "xyiW 
    let m = @x
    let m = substitute(m, ':.*$', '', '')
    let @x = m
    let @/ = m
endfunction
