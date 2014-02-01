" define bound characters
if v:version < 703 
    finish
endif
if ! exists("g:blockends#end_char") || g:blockends#end_char != g:blockends#end_char
    let g:blockends#end_char = ['\$', ')', '}', ']', '>', "'", '"']
endif

let g:blockends#jump_char = ""

" plugin key mappings
nnoremap <expr> <Plug>(blockends-t) blockends#jump_char_or_end('t')
xnoremap <expr> <Plug>(blockends-t) blockends#jump_char_or_end('t')
onoremap <expr> <Plug>(blockends-t) blockends#jump_char_or_end('t')
nnoremap <expr> <Plug>(blockends-f) blockends#jump_char_or_end('f')
xnoremap <expr> <Plug>(blockends-f) blockends#jump_char_or_end('f')
onoremap <expr> <Plug>(blockends-f) blockends#jump_char_or_end('f')
inoremap <expr> <Plug>(blockends-leaveb) "\<Esc>" . blockends#jump_char_or_end('f') . 'a'

