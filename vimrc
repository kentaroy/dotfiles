" Vim Options: {{{
set nocompatible
filetype plugin indent on
autocmd!
language message C
set ambiwidth=double encoding=utf-8 fileencoding=utf-8
set showmode showcmd cmdheight=1 laststatus=2
set autoindent smartindent expandtab smarttab 
set tabstop=8 shiftwidth=4 softtabstop=4
set foldenable foldmethod=marker foldcolumn=0 commentstring=%s foldlevel=999
let &showbreak = '...'
set nohlsearch ignorecase smartcase incsearch wrapscan
set display=lastline textwidth=0 splitbelow splitright
set backspace=indent,eol,start shiftround infercase wrap linebreak
set showmatch matchpairs& matchpairs+=<:>
set hidden autoread noswapfile nobackup nowritebackup
set timeout timeoutlen=5000 ttimeoutlen=50
set history=250 clipboard& clipboard+=unnamed
set shortmess=aTI       " no greeting messages
set completeopt=menuone
autocmd FileType * setlocal formatoptions-=ro "avoid auto comment mark insertinon
autocmd BufEnter * execute 'lcd '. expand('%:p:h')
autocmd WinLeave *
            \     let b:vimrc_pattern = @/
            \   | let b:vimrc_hlsearch = &hlsearch
autocmd WinEnter *
            \     let @/ = get(b:, 'vimrc_pattern', @/)
            \   | let &l:hlsearch = get(b:, 'vimrc_hlsearch', &l:hlsearch)
autocmd BufNewFile,BufRead *.src setlocal filetype=fortran

" Status line.
let &statusline = "[%{winnr()}]%f%m%r%h%w\ %="
let &statusline .= "[%l/%L]\ [%{&ff}]\ [%Y]\ [%{&fenc!=''?&fenc:&enc}]"

if v:version >= 700
    " Spell checks.
    set helplang=en,ja spelllang=en_us showtabline=2
    " Tab.
    function! s:tabpage_label(n)
        let title = gettabvar(a:n, 'title')
        if title !=# ''
            return title
        endif
        let bufnrs = tabpagebuflist(a:n)
        let hi = a:n is tabpagenr() ? '%#TabLineSel#' : '%#TabLine#'
        let no = a:n
        let curbufnr = bufnrs[tabpagewinnr(a:n) - 1]
        let fname = pathshorten(bufname(curbufnr))
        let fname = substitute(fname, '.*\/', '', '')
        let label = '[' . no . ']'. fname
        return '%' . a:n . 'T' . hi . label . '%T%#TabLineFill#'
    endfunction
    function! MakeTabLine()
        let titles = map(range(1, tabpagenr('$')), 's:tabpage_label(v:val)')
        let sep = '|'  " separator
        let tabpages = join(titles, sep) . sep . '%#TabLineFill#%T'
        let info = ''
        let info .= ' [' . fnamemodify(getcwd(), ":~") . ']'
        let hostname = system('hostname')
        let info .= ' [' . hostname[:len(hostname)-2] . ']'
        if exists('*fugitive#head')
            let info .= ' [' . fugitive#head() . ']'
        endif
        return tabpages . '%=' . info
    endfunction
    set tabline=%!MakeTabLine()
endif

" Key mappings
noremap : ;
noremap ; :
nnoremap Y y$
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nmap <Space> <C-w>
nnoremap <C-w><Space> gt
nnoremap <silent> g/ :let @/=expand("<cword>")<CR>:set hls<CR>
" }}}
" Appearance: "{{{
syntax enable
set background=dark
if $TERM == "mlterm" || $TERM == "xterm-256color"
    set t_Co=256
endif
if has('gui_running')
    set noshowmode
    set guicursor=a:blinkon0 guioptions=Mc mousehide
    if isdirectory('/usr/share/doc/fonts-vlgothic')
        set guifont=VL\ Gothic
    elseif has('gui_macvim')
        set transparency=5 lines=90 columns=250 guifont=Osaka-mono:h14
    endif
endif
" }}}
" Plugings: "{{{
if v:version < 700
    finish
endif
" Initialization:"{{{
let s:neobundle_dir = expand('~/.vim_bundle')
if isdirectory('neobundle.vim')
    set runtimepath+=neobundle.vim
elseif finddir('neobundle.vim', '.;') != ''
    execute 'set runtimepath+=' . finddir('neobundle.vim', '.;')
elseif &runtimepath !~ '/neobundle.vim'
    if !isdirectory(s:neobundle_dir.'/neobundle.vim')
        execute printf('!git clone %s://github.com/Shougo/neobundle.vim.git',
                    \ (exists('$http_proxy') ? 'https' : 'git')) s:neobundle_dir.'/neobundle.vim'
    endif
    execute 'set runtimepath+=' . s:neobundle_dir.'/neobundle.vim'
endif
let g:neobundle#enable_tail_path = 1
let g:neobundle#default_options = { 'default' : { 'overwrite' : 0 }, }
call neobundle#rc(s:neobundle_dir)
NeoBundleFetch 'Shougo/neobundle.vim'
"}}}
NeoBundle     'LeafCage/foldCC'
NeoBundle     'Shougo/vimproc', {'build' : {'mac': 'make -f make_mac.mak', 'unix': 'make -f make_unix.mak',},}
NeoBundle     'Shougo/junkfile.vim', {'depends': 'Shougo/unite.vim'}
NeoBundleLazy 'Shougo/neocomplete.vim', {'autoload': {'insert': 1},}
NeoBundleLazy 'Shougo/neosnippet.vim', {'autoload': {'insert': 1},}
NeoBundle     'Shougo/unite-outline', {'depends': 'Shougo/unite.vim'}
NeoBundle     'Shougo/unite.vim'
NeoBundleLazy 'Shougo/vimshell.vim', {'autoload': {'commands': ['VimShell'],}, 'depends': 'Shougo/vimproc',}
NeoBundle     'h1mesuke/vim-alignta'
NeoBundleLazy 'kana/vim-operator-replace', {'autoload': {'mappings': '<Plug>(operator-replace)'}, 'depends': 'kana/vim-operator-user',}
NeoBundle     'kana/vim-surround'
NeoBundle     'kana/vim-textobj-line', {'depends': 'kana/vim-textobj-user',}
NeoBundle     'kana/vim-textobj-entire', {'depends': 'kana/vim-textobj-user',}
NeoBundle     'kana/vim-textobj-indent', {'depends': 'kana/vim-textobj-user',}
NeoBundle     'kana/vim-textobj-fold', {'depends': 'kana/vim-textobj-user',}
NeoBundle     'nanotech/jellybeans.vim'
NeoBundleLazy 'thinca/vim-quickrun', {'autoload': {'mappings': '<Plug>(quickrun)'},}
NeoBundleLazy 'thinca/vim-ref', {'autoload': {'commands': 'Ref'},}
NeoBundle     'thinca/vim-textobj-comment', {'depends': 'kana/vim-textobj-user',}
NeoBundle     'thinca/vim-textobj-between', {'depends': 'kana/vim-textobj-user',}
NeoBundle     'thinca/vim-visualstar'
NeoBundle     'tpope/vim-fugitive'
NeoBundle     'tpope/vim-repeat'
NeoBundleLazy 'tyru/eskk.vim', {'autoload': {'mappings': [['i', '<Plug>(eskk:toggle)'],]},}
NeoBundle     'tyru/caw.vim', {'depends': 'kana/vim-operator-user',}
NeoBundleCheck
filetype plugin indent on
" alignta"{{{
" Make this plugin operator.
let g:alignta_default_arguments='<<0 \ '
function! OpAlignta(motion_wisenes)
    execute line("'[").','.line("']") 'Alignta' input('')
endfunction
call operator#user#define('alignta', 'OpAlignta')
map + <plug>(operator-alignta)
"}}}    
" caw.vim "{{{
" Make this plugin operator.
function! OpCawCommentout(motion_wise)
    execute "normal" "`[V`]\<Plug>(caw:i:toggle)"
endfunction
call operator#user#define('caw', 'OpCawCommentout')
map -  <Plug>(operator-caw)
"}}}
" eskk.vim "{{{
let s:bundle = neobundle#get("eskk.vim")
function! s:bundle.hooks.on_source(bundle)
    let g:eskk#dictionary = {'path': "~/.vim/eskk/skk-jisyo", 'sorted': 0, 'encoding': 'utf-8',}
    let g:eskk#large_dictionary = {'path': "~/.vim/eskk/SKK-JISYO.L", 'sorted': 1, 'encoding':'euc-jp',}
    let g:eskk#keep_state = 1
endfunction
unlet s:bundle
imap <C-j> <Plug>(eskk:toggle)
cmap <C-j> <Plug>(eskk:toggle)
"}}}
" foldCC "{{{
set foldtext=FoldCCtext()
"}}}
" jellybeans "{{{
if has('gui_running') || &t_Co==256
    colorscheme jellybeans
    highlight Folded gui=bold guibg=#303030 guifg=#998899
    highlight Normal ctermbg=None
endif
"}}}
" neocomplete.vim "{{{
let s:bundle = neobundle#get("neocomplete.vim")
function! s:bundle.hooks.on_source(bundle)
    let g:neocomplete#enable_at_startup = 1
    let g:neocomplete#enable_smart_case = 1
    let g:neocomplete#enable_camel_case = 1
    let g:neocomplete#max_list = 12
    let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'
    let g:neocomplete#sources#dictionary#dictionaries = {'default': '', 'vimshell': $HOME.'/.vim/vimshell/command-history',}
    inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
    function! s:my_cr_function()
        return neocomplete#smart_close_popup() . "\<CR>"
    endfunction
    inoremap <expr> <TAB>     pumvisible() ? "\<C-n>" : "\<Tab>"
    inoremap <expr> <S-Tab>   pumvisible() ? "\<C-p>" : "\<S-Tab>"
endfunction 
unlet s:bundle
"}}}
" neosnippet.vim "{{{
let g:neosnippet#snippets_directory = '~/.vim/after/snippet'
let s:bundle = neobundle#get("neosnippet.vim")
function! s:bundle.hooks.on_source(bundle)
    imap <expr> @ neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "@"
    smap <expr> @ neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "@"
endfunction 
unlet s:bundle
"}}}
" unite.vim "{{{
nnoremap [unite] <Nop>
nmap x [unite]
let s:bundle = neobundle#get('unite.vim')
function! s:bundle.hooks.on_source(bundle)
    let g:unite_enable_start_insert = 1
    let g:unite_source_file_mru_time_format = ''
    let g:unite_source_rec_max_cache_files = 0
    call unite#custom#source('file', 'ignore_pattern', '__pycache__/')
    call unite#custom#source('file_rec,file_rec/async', 'max_candidates', 0)
    call unite#custom#source('change', 'max_candidates', 5)
endfunction
nnoremap <silent> [unite]x   :<C-u>Unite -no-split -buffer-name=files buffer file_mru<CR>
nnoremap <silent> [unite]p   :<C-u>Unite -no-split -buffer-name=files file_rec/async:!<CR>
nnoremap <silent> [unite]h   :<C-u>Unite -no-split -buffer-name=files file file/new<CR>
nnoremap <expr>   [unite]H ":\<C-u>Unite -no-split -buffer-name=files file:". $HOME . "\<CR>"
nnoremap          [unite]g   :<C-u>Unite -no-split -buffer-name=files grep:.::
nnoremap <silent> [unite]l   :<C-u>Unite -no-split -buffer-name=search change line<CR>
nnoremap <silent> [unite]o   :<C-u>Unite -no-split -buffer-name=outline outline<CR>
nnoremap          [unite]m   :<C-u>Unite -no-split -buffer-name=files junkfile junkfile/new<CR>
nnoremap <silent> [unite].   :<C-u>UniteResume -no-split files<CR>
"}}}
" vim-operator-replace "{{{
map gr <Plug>(operator-replace)
"}}}
" vim-quickrun "{{{
let s:bundle = neobundle#get("vim-quickrun")
function! s:bundle.hooks.on_source(bundle)
    let g:quickrun_config = {
                \   "_": {"runner": "vimproc", "runner/vimproc/updatetime" : 100,}, 
                \   "python": {"command": "python3", "cmdopt" : "-u", },
                \   "tex": {"command": "platex", },
                \}
endfunction
unlet s:bundle
nnoremap <Plug>(colon) :
nmap X <Plug>(colon)write<CR><Plug>(quickrun)
"}}}
" vim-ref "{{{
let s:bundle = neobundle#get('vim-ref')
function! s:bundle.hooks.on_source(bundle)
    let g:ref_source_webdict_sites = {'weblio':{'url': 'http://ejje.weblio.jp/content/%s' },}
    function! g:ref_source_webdict_sites.weblio.filter(output)
        return join(split(a:output, "\n")[50 :], "\n")
    endfunction
endfunction 
unlet s:bundle
function! s:lookup_weblio(word)
    if a:word =~ '\S'
        execute 'Ref webdict weblio ' . a:word . "\<CR>"
    endif
endfunction
command! -nargs=1 Weblio :call <SID>lookup_weblio("<args>")
"}}}
" vim-surround "{{{
nmap s  <Plug>Ysurround
nmap S  <Plug>Ysurround$
"}}}
" vimshell.vim "{{{
let s:bundle = neobundle#get("vimshell.vim")
function! s:bundle.hooks.on_source(bundle)
    autocmd FileType int-* NeoCompleteLock
    let g:vimshell_split_command = ''
    let g:vimshell_prompt = "% "
    let g:vimshell_user_prompt = '$HOST .":". fnamemodify(getcwd(), ":~")'
    let g:unite_source_vimshell_external_history_path = $HOME . '/.zsh_history'
endfunction
unlet s:bundle
nnoremap , :<C-u>update<CR>:VimShell<CR>
"}}}
"}}}