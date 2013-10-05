execute pathogen#infect()
call pathogen#helptags()

colorscheme torte 

syntax on
filetype plugin indent on

"enable 256 colors for terminal vim
if $COLORTERM == 'gnome-terminal'
  set t_Co=256
endif

" Change map leader to a easier key
let mapleader = "," 

" ============================================
" AUTO COMMANDS
" ============================================

" http://stackoverflow.com/a/6174010
" http://stackoverflow.com/a/1413352
"
" indentation for php files
if !exists("*PhpIndent")
  function PhpIndent()
    " echom "setting php options"
    setlocal tabstop=4 softtabstop=4 shiftwidth=4 noexpandtab
  endfunction
endif

" indentation for ruby files
if !exists("*RubyIndent")
  function RubyIndent()
    " echom "setting ruby options"
    setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
  endfunction
endif

" indentation for python files
if !exists("*PythonIndent")
  function PythonIndent()
    " echom "python indent set"
    setlocal tabstop=4 softtabstop=4 shiftwidth=4 expandtab
  endfunction
endif

augroup indentCodeGroup
  autocmd!
  autocmd BufRead,BufEnter /var/www/po-system/* call PhpIndent()
  autocmd BufRead,BufEnter ~/faves/* call RubyIndent()
  autocmd FileType python call PythonIndent()
augroup END

" flush ctrlp cache so that 
" files created outside vim become available
augroup CtrlPExtension
  autocmd!
  autocmd FocusGained * CtrlPClearCache
  autocmd BufWritePost * CtrlPClearCache
augroup END

" Set php autocompletion
" http://stackoverflow.com/questions/5169638/autocompletion-in-vim
au FileType php setl ofu=phpcomplete#CompletePHP

" emphasize word
au FileType markdown nnoremap <Leader>we bi**<esc>ea**<esc>
" emphasize line
au FileType markdown nnoremap <Leader>le ^i**<esc>$a**<esc>
" horizontal rule
au FileType markdown nnoremap <Leader>hr o---<esc>

" autocmd VimEnter * NERDTree " Open nerdtree by default
" autocmd VimEnter * wincmd p " Move cursor main window

au FileType html let b:delimitMate_matchpairs = "(:),[:],{:}"

" ============================================
" GENERAL SETTINGS
" ============================================


" Search for tags
" http://stackoverflow.com/questions/563616/vim-and-ctags-tips-and-tricks
set tags=./tags;

set encoding=utf-8

" fixes weird behavior of backspace
set backspace=2

" automatically read files modified outside vim
set autoread 

set nofoldenable " Disable folds by default
set showcmd " show command being typed
set number " Line numbering on

set undofile
set undodir=~/vimundo " Set location for .un~ files

set backupskip=/tmp/*,/private/tmp/* 
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp 
set writebackup

set tabstop=2 softtabstop=2 shiftwidth=2 expandtab
set autoread
set title
set history=1000
set undolevels=1000
" set list
set pastetoggle=<F2>  " fixes indentation while copy pasting
set incsearch " start search as you type
set hlsearch " highlight search
set ignorecase " ignore case while searching

" always show the statusline, required for powerline to show up in single window
" http://stackoverflow.com/a/14114786
set laststatus=2 

set splitbelow " Split below when using help tags
set splitright " Split right when splitting from nerdtree

set nocompatible
set cursorline


" ============================================
" KEY MAPPINGS
" ============================================

inoremap ;; <esc> " Use custom keys to exit insert mode

nnoremap <leader>t :CtrlP<CR>

noremap <Leader>n :NERDTreeToggle<CR>
nnoremap <Leader>vc :tab drop ~/.vimrc<CR> " Open vim config file in a new tag
nnoremap <Leader>sv :source ~/.vimrc<CR>

nnoremap <Leader>ba :tab drop ~/.bash_aliases<CR> " Open bash aliases

nnoremap <Leader>c :close<CR> " close buffer
nnoremap <Leader>q :qa<CR> " Close all files

nnoremap <silent> <leader>w :w<CR>
nnoremap <silent> <leader>u viw~<esc>

nnoremap <Leader>g :TComment<CR>

nnoremap <silent> <leader>r :RunSpec<CR>
nnoremap <silent> <leader>re :RunSpecLine<CR>

nnoremap <silent> <leader>m :TagbarToggle<CR>

" Generate php docs
inoremap <C-P> <ESC>:call PhpDocSingle()<CR>i 
nnoremap <C-P> :call PhpDocSingle()<CR> 
vnoremap <C-P> :call PhpDocRange()<CR> 

" Move up/down in omnicomplete
" inoremap <expr> j ((pumvisible())?("\<C-n>"):("j"))
" inoremap <expr> k ((pumvisible())?("\<C-p>"):("k"))

" Search project for word under cursor
" files with same extension only
nnoremap <F5> "zyw:exe "vimgrep/".@z."/ ./**/*".expand("%:e")<CR>

" Open tag in new tab
" http://stackoverflow.com/questions/563616/vim-and-ctags-tips-and-tricks
noremap <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>

" Open tag in vertical split
noremap <silent><leader>\ :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

nmap <Leader>k <Plug>VimwikiIndex

" ============================================
" Plugin specific config
" ============================================
" Vim instant markdown
" makes preview slower, improves performance
let g:instant_markdown_slow=1

" Show NERDTree bookmarks on startup
let NERDTreeShowBookmarks=1

" DelimitMate
" start function body nested 
let g:delimitMate_expand_cr=1

" Ctrlp
set runtimepath^=~/.vim/bundle/ctrlp.vim
let g:ctrlp_map = ',t'
let g:ctrlp_by_map=',t'
let g:ctrlp_cmd='CtrlP'
let g:ctrlp_working_path_mode='ra'

" Powerline vim bindings
set rtp+=~/.vim/bundle/powerline/powerline/bindings/vim
let g:Powerline_symbols = "fancy"
