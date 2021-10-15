" ~/.vimrc

set nu
set autoindent
set cindent
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set hlsearch
set magic
set cursorline

syntax on

nmap <C-w>= :resize +5<CR>
nmap <C-w>- :resize -5<CR>
nmap <C-w>. :vertical resize +5<CR>
nmap <C-w>, :vertical resize -5<CR>

nnoremap k gk
nnoremap gk k
nnoremap j gj
nnoremap gj j

" Color Scheme
set t_Co=256
colorscheme Tomorrow-Night
if has("termguicolors") && $TERM != 'rxvt'
    colorscheme base16-tomorrow-night
    set t_8f=[38;2;%lu;%lu;%lum
    set t_8b=[48;2;%lu;%lu;%lum
    set termguicolors
endif

" Plugin: Auto pairs
"let g:AutoPairsFlyMode = 1
let g:AutoPairsMapCR = 1
let g:AutoPairsCenterLine = 0

" Plugin: Ctrlp
set wildignore+=*/tmp/*,*.so,*.swp,*.zip
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'

" Enable Meta key in putty
function! Terminal_MetaMode(mode)
    set ttimeout
    if $TMUX != ''
        set ttimeoutlen=30
    elseif &ttimeoutlen > 80 || &ttimeoutlen <= 0
        set ttimeoutlen=80
    endif
    if has('nvim') || has('gui_running')
        return
    endif
    function! s:metacode(mode, key)
        if a:mode == 0
            exec "set <M-".a:key.">=\e".a:key
        else
            exec "set <M-".a:key.">=\e]{0}".a:key."~"
        endif
    endfunc
    for i in range(10)
        call s:metacode(a:mode, nr2char(char2nr('0') + i))
    endfor
    for i in range(26)
        call s:metacode(a:mode, nr2char(char2nr('a') + i))
        call s:metacode(a:mode, nr2char(char2nr('A') + i))
    endfor
    if a:mode != 0
        for c in [',', '.', '/', ';', '[', ']', '{', '}']
            call s:metacode(a:mode, c)
        endfor
        for c in ['?', ':', '-', '_']
            call s:metacode(a:mode, c)
        endfor
    else
        for c in [',', '.', '/', ';', '{', '}']
            call s:metacode(a:mode, c)
        endfor
        for c in ['?', ':', '-', '_']
            call s:metacode(a:mode, c)
        endfor
    endif
endfunc
call Terminal_MetaMode(0)

" Record position for last exit
autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

" Toggle hex
nmap <C-h> :call ToggleHex()<CR>
let b:hex = 0
function! ToggleHex()
    if(b:hex == 0)
        exec ":%!xxd"
        let b:hex = 1
    else
        exec ":%!xxd -r"
        let b:hex = 0
    endif
endfunction
