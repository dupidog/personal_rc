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

nmap <C-w>= :resize +5<CR>
nmap <C-w>- :resize -5<CR>
nmap <C-w>. :vertical resize +5<CR>
nmap <C-w>, :vertical resize -5<CR>

nnoremap k gk
nnoremap gk k
nnoremap j gj
nnoremap gj j

" Plugin: Auto pairs
let g:AutoPairsFlyMode = 1
let g:AutoPairsCenterLine = 0
