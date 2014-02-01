setlocal foldmethod=indent
let g:python_highlight_all=1
let g:python_highlight_space_errors=0
inoremap <buffer> # X<BS>#

" " jedi-vim "{{{
" let s:bundle = neobundle#get("jedi-vim")
" function! s:bundle.hooks.on_source(bundle)
"     let g:jedi#popup_select_first     = 0
"     let g:jedi#auto_vim_configuration = 0
"     let g:jedi#use_tabs_not_buffers   = 0
"     let g:jedi#goto_definitions_command = '<Plug>(jedi-goto-definitions)'
"     let g:jedi#goto_assignments_command = '<Plug>(jedi-goto-assignments)'
"     let g:jedi#documentation_command    = '<Plug>(jedi-documatation-command)'
"     let g:jedi#usages_command           = '<Plug>(jedi-usages-command)'
"     let g:jedi#rename_command           = '<Plug>(jedi-rename-command)'
"     " if !exists('g:neocomplete#force_omni_input_patterns')
"     "     let g:neocomplete#force_omni_input_patterns = {}
"     " endif
"     " let g:neocomplete#force_omni_input_patterns.python = '[^. \t]\.\w*'
" endfunction
" unlet s:bundle
" "}}}
" let s:save_cpo = &cpo
" set cpo&vim
" " Settings for jedi-vim
" setlocal omnifunc=jedi#completions
" nmap <buffer> md <Plug>(jedi-goto-definitions)
" nmap <buffer> mg <Plug>(jedi-goto-assignments))
" nmap <buffer> mr <Plug>(jedi-usages-command)
" nmap <buffer> mn <Plug>(jedi-rename-command)
" nmap <buffer> K  <Plug>(jedi-documatation-command))
" if exists('g:jedi#popup_select_first') && g:jedi#popup_select_first == 0
"   inoremap <buffer> . .<C-R>=jedi#complete_opened() ? "" : "\<lt>C-X>\<lt>C-O>\<lt>C-P>"<CR>
" endif
" let &cpo = s:save_cpo
" unlet s:save_cpo
" setlocal completeopt=menuone
