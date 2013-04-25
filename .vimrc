execute pathogen#infect()
syntax on
filetype plugin indent on

autocmd VimEnter * NERDTree " Open nerdtree by default
autocmd VimEnter * wincmd p " Move cursor main window

let mapleader = "," " Change map leader to a easier key

nmap <silent> <F8> :TagbarToggle<CR> " Key map for tagbar toggle
nmap <silent> <F9> :NERDTreeToggle<CR> " Toggle NERDTree
imap ;; <esc> " Use custom keys to exit insert mode

colorscheme jellybeans

set nofoldenable " Disable folds by default
set showcmd " show command being typed
set number " Line numbering one
set background=light
set undodir=~/vimundo " Set location for .un~ files
set backupskip=/tmp/*,/private/tmp/* 
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp 
set writebackup
set tabstop=4
set shiftwidth=2
set expandtab

map <Leader>n <plug>NERDTreeTabsToggle<CR>
map <Leader>vc :tab drop ~/.vimrc<CR> " Open vim config file in a new tag
map <Leader>te  :ConqueTermTab bash<CR> 
map <Leader>c :q<CR> " close buffer
map <Leader>q :qa<CR> " Close all files

let g:pdv_cfg_Version = "$id$"
let g:pdv_cfg_Author = ""
let g:pdv_cfg_Copyright = ""
let g:pdv_cfg_License = ""

let g:cssColorVimDoNotMessMyUpdatetime = 1

"enable 256 colors for terminal vim
if $COLORTERM == 'gnome-terminal'
    set t_Co=256
endif

set rtp+=~/.vim/bundle/powerline/powerline/bindings/vim
let g:Powerline_symbols = "fancy"
set encoding=utf-8
