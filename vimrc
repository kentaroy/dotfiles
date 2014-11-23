" Vim Options: {{{
" Set options. {{{
set nocompatible
filetype plugin indent on
autocmd!
language message C
set helplang=en,ja
set ambiwidth=double encoding=utf-8 fileencoding=utf-8
set showmode showcmd cmdheight=1 laststatus=2
set autoindent smartindent expandtab smarttab
set tabstop=8 shiftwidth=4 softtabstop=4
set foldenable foldmethod=marker foldcolumn=0 commentstring=%s foldlevel=999
let &showbreak = '> '
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
autocmd BufEnter * execute 'lcd ' . expand('%:p:h')
if exists('&spell')
    set spelllang=en_us,cjk
endif
"}}}
" Status line."{{{
let &statusline = "[%{winnr()}]%f%m%r%h%w\ %="
let &statusline .= "[%l/%L]\ [%{&ff}]\ [%Y]\ [%{&fenc!=''?&fenc:&enc}]"
"}}}
" Tab line."{{{
if exists('&showtabline')
    set showtabline=2
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
        let hostname = system('hostname')
        let info = ' [' . hostname[:len(hostname)-2] . ':' . fnamemodify(getcwd(), ":~") . ']'
        return tabpages . '%=' . info
    endfunction
    set tabline=%!MakeTabLine()
endif
"}}}
" Key mappings."{{{
noremap : ;
noremap ; :
nnoremap Y y$
noremap n nzz
noremap N Nzz
nnoremap g; g;zz
nnoremap zv zMzvzz
nmap <Space> <C-w>
nnoremap <C-w>N :tabnew<CR>
nnoremap - gt
nnoremap _ gT
nnoremap <expr> h col('.')==1 ? "zc" : "h"
nnoremap <expr> l foldclosed(line('.'))!=-1 ? "zo" : "l"
inoremap <C-f> <C-x><C-o>
"}}}
" }}}
" Appearance: "{{{
"{{{
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
    endif
endif
"}}}
"}}}
" Plugings: "{{{
" Initialization:"{{{
let s:neobundle_dir = expand('~/.cache/neobundle')
if !isdirectory(s:neobundle_dir.'/neobundle.vim')
    execute printf('!git clone %s://github.com/Shougo/neobundle.vim.git',
                \ (exists('$http_proxy') ? 'https' : 'git')) s:neobundle_dir.'/neobundle.vim'
endif
if has('vim_starting')
    execute 'set runtimepath+=' . s:neobundle_dir.'/neobundle.vim'
endif
let g:neobundle#enable_tail_path = 1
let g:neobundle#default_options = { 'default' : { 'overwrite' : 0 }, }
let g:neobundle#types#git#default_protocol = "ssh"
" call neobundle#rc(s:neobundle_dir)
call neobundle#begin(s:neobundle_dir)
NeoBundleFetch 'Shougo/neobundle.vim'
call neobundle#end()
"}}}
" PluginList: "{{{
call neobundle#begin(s:neobundle_dir)
NeoBundle 'LeafCage/foldCC'
NeoBundle 'Shougo/vimproc', {'build' : {'unix': 'make',},}
NeoBundle 'Shougo/junkfile.vim'
NeoBundle 'Shougo/neocomplete.vim'
NeoBundle 'Shougo/neomru.vim'
NeoBundle 'Shougo/neosnippet.vim'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/unite-outline'
NeoBundle 'Shougo/tabpagebuffer.vim'
NeoBundle 'Shougo/vimshell.vim'
NeoBundle 'h1mesuke/vim-alignta'
NeoBundle 'kana/vim-operator-user'
NeoBundle 'kana/vim-operator-replace'
NeoBundle 'kana/vim-textobj-line'
NeoBundle 'kana/vim-textobj-entire'
NeoBundle 'kana/vim-textobj-indent'
NeoBundle 'kana/vim-textobj-fold'
NeoBundle 'kana/vim-textobj-user'
NeoBundle 'nanotech/jellybeans.vim'
NeoBundle 'rhysd/vim-operator-surround'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'thinca/vim-ref'
NeoBundle 'thinca/vim-textobj-comment'
NeoBundle 'thinca/vim-visualstar'
NeoBundle 'tpope/vim-repeat'
NeoBundle 'tyru/caw.vim'
NeoBundle 'tyru/open-browser.vim'
NeoBundle 'tyru/eskk.vim'
NeoBundleCheck
call neobundle#end()
filetype plugin indent on
"}}}
" alignta (operator)"{{{
let g:alignta_default_arguments='<<0 \ '
function! OpAlignta(motion_wisenes)
    execute line("'[").','.line("']") 'Alignta' input('')
endfunction
call operator#user#define('alignta', 'OpAlignta')
map + <plug>(operator-alignta)
"}}}    
" caw (operator) "{{{
function! OpCawCommentout(motion_wise)
    execute "normal" "`[V`]\<Plug>(caw:i:toggle)"
endfunction
call operator#user#define('caw', 'OpCawCommentout')
map #  <Plug>(operator-caw)
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
" neocomplete "{{{
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#auto_completion_start_length = 999
let g:neocomplete#max_list = 12
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'
let g:neocomplete#sources#omni#input_patterns = {'python': ''}
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
    return neocomplete#smart_close_popup() . "\<CR>"
endfunction
inoremap <expr> <S-Tab>   pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" :
        \ <SID>check_space_backward() ? "\<TAB>" :
        \ neocomplete#start_manual_complete()
function! s:check_space_backward()
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction
"}}}
" neosnippet "{{{
let g:neosnippet#snippets_directory = '~/.vim/after/snippet'
imap <expr> @ neosnippet#jumpable() ? "\<Plug>(neosnippet_jump)" : "@"
smap <expr> @ neosnippet#jumpable() ? "\<Plug>(neosnippet_jump)" : "@"
imap <expr> X neosnippet#expandable() ? "\<Plug>(neosnippet_expand)" : "X"
smap <expr> X neosnippet#expandable() ? "\<Plug>(neosnippet_expand)" : "X"
"}}}
" unite "{{{
nnoremap [unite] <Nop>
nmap x [unite]
let g:unite_enable_start_insert = 1
if executable('ag')
    let g:unite_source_grep_command = 'ag'
    let g:unite_source_grep_default_opts ='-i --line-numbers --nocolor --nogroup --hidden --ignore ''.git'''
    let g:unite_source_grep_recursive_opt = ''
    let g:unite_source_rec_async_command = 'ag --follow --nocolor --nogroup --hidden -g ""'
endif
let s:pls = []
let s:ils = ['png', 'eps', 'xcf', 'pyc', 'pickle', 'vtk', 'git', 'aux', 'pdf', 'dvi', 'toc', 'bbl', 'gz', 'bz2', 'a', 'o', 'so', 'mp4']
for suffix in s:ils
    call add(s:pls, '\.'.suffix)
endfor
call add(s:pls, '__pycache__')
let s:ipattern = join(s:pls, '\|')
call unite#custom#source('file,file_rec,file_rec/async,file_rec/git', 'ignore_pattern', s:ipattern)
call unite#custom#profile('default', 'context', { 'prompt_direction': 'top'})
call unite#custom#source('file,file_rec,file_rec/async,file_rec/git', 'max_candidates', 0)
nnoremap <silent> [unite]x   :<C-u>Unite -silent -no-split -no-resize -buffer-name=files buffer file_mru<CR>
nnoremap <silent> [unite]o   :<C-u>Unite -silent -no-split -no-resize -buffer-name=outline outline<CR>
nnoremap <expr>   [unite]p ":\<C-u>" . 'lcd ' . unite#util#path2project_directory(expand("%")) . "<CR>:Unite -silent -no-split -no-resize -buffer-name=files file_rec/git\<CR>"
nnoremap <expr>   [unite]P ":\<C-u>Unite -silent -no-split -no-resize -buffer-name=files directory:". $HOME . '/Projects' . "\<CR>"
nnoremap <silent> [unite]h   :<C-u>Unite -silent -no-split -no-resize -buffer-name=files file file/new<CR>
nnoremap <expr>   [unite]H ":\<C-u>Unite -silent -no-split -no-resize -buffer-name=files file:". $HOME . "\<CR>"
nnoremap          [unite]g  :\<C-u>Unite -silent -no-split -no-resize -buffer-name=files grep:.::
nnoremap <expr>   [unite]G ":\<C-u>Unite -silent -no-split -no-resize -buffer-name=files grep:" . unite#util#path2project_directory(expand("%")) . "::"
nnoremap <silent> [unite]m   :<C-u>Unite -silent -no-split -no-resize -buffer-name=files junkfile/new junkfile<CR>
"}}}
" operator-replace "{{{
map S <Plug>(operator-replace)
"}}}
" quickrun "{{{
let g:quickrun_config = {
            \   "_":        {"runner": "vimproc", "runner/vimproc/updatetime" : 250,},
            \   "python":   {"command": "python3", "cmdopt" : "-u", },
            \   "tex":      {"command": "platex", },
            \   "markdown": {'type': "markdown/pandoc", 'cmdopt': '-s', 'outputter': 'browser'},
            \ }

nnoremap <Plug>(colon) :
nmap X <Plug>(colon)write<CR><Plug>(quickrun)
"}}}
" ref "{{{
let g:ref_open = "edit"
let g:ref_cache_dir = "~/.cache/vim_ref"
let g:ref_source_webdict_sites = {'weblio':{'url': 'http://ejje.weblio.jp/content/%s' },}
function! g:ref_source_webdict_sites.weblio.filter(output)
    return join(split(a:output, "\n")[50 :], "\n")
endfunction
nnoremap [ref] m
nmap m [ref]
nnoremap [ref]p :Ref pydoc<space>
nnoremap [ref]w :Ref webdict weblio<space>
nnoremap [ref]m :Ref man<space>
"}}}
" operator-surround "{{{
map <silent>s  <Nop>
map <silent>sa <Plug>(operator-surround-append)
map <silent>sd <Plug>(operator-surround-delete)
map <silent>sr <Plug>(operator-surround-replace)
"}}}
" vimshell "{{{
let g:vimshell_split_command = ''
let g:vimshell_prompt = "% "
let g:vimshell_user_prompt = 'hostname() .":". fnamemodify(getcwd(), ":~")'
let g:vimshell_max_command_history = 10000
nnoremap , :<C-u>update<CR>:VimShell<CR>
nnoremap g, :<C-u>update<CR>:VimShellBufferDir -create<CR>
"}}}
" visualstar"{{{
nnoremap <Plug>(Nzz) Nzz
map * <Plug>(visualstar-*)<Plug>(Nzz)
map g* <Plug>(visualstar-g*)<Plug>(Nzz)
"}}}
" eskk "{{{
cmap <C-j> <Plug>(eskk:toggle)
let g:eskk#dictionary = {'path': "~/.eskk/skk-jisyo", 'sorted': 0, 'encoding': 'utf-8',}
let g:eskk#large_dictionary = {'path': "~/.eskk/SKK-JISYO.L.utf8", 'sorted': 1, 'encoding': 'utf-8',}
let g:eskk#keep_state = 1
let g:eskk#start_completion_length = 999
imap <C-j> <Plug>(eskk:toggle)
"}}}
"}}}
