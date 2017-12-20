execute pathogen#infect()
call pathogen#helptags()

colorscheme torte 
let g:solarized_termcolors=256
" set t_Co=256 
" set background=dark
" colorscheme solarized

syntax on
filetype plugin indent on

"enable 256 colors for terminal vim
if $COLORTERM == 'gnome-terminal'
  set t_Co=256
endif

set tabstop=4 softtabstop=4 shiftwidth=4 noexpandtab

" Change map leader to a easier key
let mapleader = "," 

" ============================================
" AUTO COMMANDS
" ============================================

" http://stackoverflow.com/a/6174010
" http://stackoverflow.com/a/1413352
"
" indentation for php files
if !exists("*PhpIndentTab")
  function PhpIndentTab()
    " echom "setting php options(tab indent)"
    setlocal tabstop=4 softtabstop=4 shiftwidth=4 noexpandtab
  endfunction
endif

if !exists("*PhpIndentSpace")
  function PhpIndentSpace()
    " echom "setting php options(tab indent)"
    setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
  endfunction
endif

" indentation for ruby files
if !exists("*RubyIndent")
  function RubyIndent()
    " echom "setting ruby options(space indent)"
    setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
  endfunction
endif

" indentation for python files
if !exists("*PythonIndent")
  function PythonIndent()
    " echom "python indent set(space indent)"
    setlocal tabstop=4 softtabstop=4 shiftwidth=4 expandtab
  endfunction
endif

augroup indentCodeGroup
  autocmd!
  autocmd FileType php call PhpIndentSpace()
  autocmd BufRead,BufEnter /var/www/html/po-system/* call PhpIndentTab()
  autocmd BufRead,BufEnter /var/www/html/dronten/* call PhpIndentTab()
  autocmd BufRead,BufEnter /var/www/html/measter/* call PhpIndentTab()
  autocmd BufRead,BufEnter /var/www/html/affiliateBO/* call PhpIndentTab()
  autocmd BufRead,BufEnter /var/www/html/leanstock/* call PhpIndentTab()
  autocmd BufRead,BufEnter /var/www/html/keg/* call PhpIndentTab()
  autocmd FileType ruby,eruby call RubyIndent()
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

" set cwd of the window buffer to the current file
" so that NERDTree behaves correctly
autocmd BufEnter * lcd %:p:h

autocmd FileType js nnoremap <C-p> :JsDoc<CR>

function! RunPHPTestFunction()

  let filePath = expand('%:p')
  let functionName = cfi#format("%s",'')

  echom filePath

  if empty(functionName)
    echo 'Not a function!'
    return
  endif

  if( !empty( matchstr( filePath, 'dronten' ) ) )
    let torun = '/var/www/html/dronten/tests/run_tests.sh --filter ' . functionName . '$ ' . filePath

  elseif( !empty( matchstr( filePath, 'keg' ) ) )
    let torun = '/var/www/html/keg/tests/run_tests.sh --filter ' . functionName . '$ ' . filePath

  elseif( !empty( matchstr( filePath, 'measter' ) ) )
    let torun = 'cd /var/www/html/measter/dev && php artisan dusk --filter ' . functionName . '$ ' . filePath

  else
    let torun = '/var/www/html/leanstock/tests/run_tests.sh --filter ' . functionName . '$ ' . filePath
  endif

  call VimuxRunCommand(torun)

endfunction

function! RunPHPTestFile()

  let filePath = expand('%:p')

  if( !empty( matchstr( filePath, 'dronten' ) ) )
    let torun = '/var/www/html/dronten/tests/run_tests.sh ' . filePath

  elseif( !empty( matchstr( filePath, 'keg' ) ) )
    let torun = '/var/www/html/keg/tests/run_tests.sh ' . filePath

  elseif( !empty( matchstr( filePath, 'measter' ) ) )
    let torun = 'cd /var/www/html/measter/dev && php artisan dusk ' . filePath

  else
    let torun = '/var/www/html/leanstock/tests/run_tests.sh ' . filePath
  endif

  call VimuxRunCommand(torun)

endfunction

" ============================================
" GENERAL SETTINGS
" ============================================

" Search for tags
" http://stackoverflow.com/questions/563616/vim-and-ctags-tips-and-tricks
set tags=./tags;

set encoding=utf-8

" Highlight column 80 
" set colorcolumn=80

" fixes weird behavior of backspace
set backspace=2

" automatically read files modified outside vim
set autoread 

set nofoldenable          " Disable folds by default
set showcmd               " show command being typed
set number                " Line numbering on

set undofile
set undodir=~/vimundo     " Set location for .un~ files
set undolevels=1000

set backupskip=/tmp/*,/private/tmp/* 
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp 
set writebackup
set backupdir=~/tmp

set tabstop=2 softtabstop=2 shiftwidth=2 expandtab
set autoread
set title
set history=1000
" set list
set pastetoggle=<F2>      " fixes indentation while copy pasting
set incsearch             " start search as you type
set hlsearch              " highlight search
set ignorecase            " ignore case while searching

" always show the statusline, required for powerline to show up in single window
" http://stackoverflow.com/a/14114786
set laststatus=2 

set splitbelow           " Split below when using help tags
set splitright           " Split right when splitting from nerdtree

set nocompatible
set cursorline

" colors for search highlight
hi Search cterm=NONE ctermfg=black ctermbg=green

" Makes 81st column stand out
" http://www.youtube.com/watch?v=aHm36-na4-4
hi ColorColumn ctermbg=DarkGray
call matchadd('ColorColumn', '\%81v', 100 )

" ============================================
" KEY MAPPINGS
" ============================================

" Use custom keys to exit insert mode
inoremap ;; <esc> 
nnoremap <leader>t :CtrlP<CR>

noremap <Leader>n :NERDTreeToggle<CR>
" Open vim config file in a new tag
nnoremap <Leader>vc :tab drop ~/.vimrc<CR>
nnoremap <Leader>sv :source ~/.vimrc<CR>

" Open bash aliases
nnoremap <Leader>ba :tab drop ~/.bash_aliases<CR>

nnoremap <Leader>c :close<CR> " close buffer
nnoremap <Leader>q :qa<CR> " Close all files

nnoremap <silent> <leader>w :w<CR>
nnoremap <silent> <leader>u viw~<esc>

nnoremap <Leader>g :TComment<CR>

" Map test runners for rails
au FileType ruby nnoremap <silent> <leader>r :RunSpec<CR>
au FileType ruby nnoremap <silent> <leader>re :RunSpecLine<CR>

" Map test runners for php
au FileType php nnoremap <silent> <leader>r :call RunPHPTestFile()<CR>
au FileType php nnoremap <silent> <leader>re :call RunPHPTestFunction()<CR>

nnoremap <silent> <leader>m :TagbarToggle<CR>

" Generate php docs
inoremap <C-P> <ESC>:call PhpDocSingle()<CR>i 
nnoremap <C-P> :call PhpDoc()<CR> 
vnoremap <C-P> :call PhpDocRange()<CR> 

" Align visually selected text on comma
vnoremap <Leader>fc :Tab /,<CR>

" Align array values
vnoremap <Leader>fa :Tab /=><CR>gv :Tab /,<CR>

" Move up/down in omnicomplete
" inoremap <expr> j ((pumvisible())?("\<C-n>"):("j"))
" inoremap <expr> k ((pumvisible())?("\<C-p>"):("k"))

" Search project for word under cursor
" files with same extension only
nnoremap <F5> "zyw:exe "vimgrep/".@z."/ ./**/*".expand("%:e")<CR>

" Open tag in new tab
" http://stackoverflow.com/questions/563616/vim-and-ctags-tips-and-tricks
"
" (use tjump since it shows a list if multiple definitions if found)
" http://stackoverflow.com/a/660756
noremap <C-\> :tab split<CR>:exec("tjump ".expand("<cword>"))<CR>

" Open tag in vertical split
noremap <silent><leader>\ :vsp <CR>:exec("tjump ".expand("<cword>"))<CR>

map <C-l> :tabn<CR>
map <C-h> :tabp<CR>
map <C-n> :tabnew<CR>

map <Leader>H :tabm -1<CR>
map <Leader>L :tabm +1<CR>

" Format function params, add leading and ending space
nmap <Leader>ff vi(S  <CR>

" Toggle search highlight
" :noh
nmap <Leader>h :set hlsearch!<CR>

" Reselect last visual select after using indent keys
" gv reselects last visual selection
" http://superuser.com/a/310424
vmap > >gv
vmap < <gv

" Write file in sudo mode
cmap w!! w !sudo tee > /dev/null %

" Close tmux runner created by vimux
map <Leader>vq :VimuxCloseRunner<CR>

" ============================================
" Plugin specific config
" ============================================
" Vim instant markdown
" makes preview slower, improves performance
let g:instant_markdown_slow=1

" Show NERDTree bookmarks on startup
let NERDTreeShowBookmarks=1

" Change cwd with the tree root
let NERDTreeChDirMode=2

" DelimitMate
" start function body nested 
let g:delimitMate_expand_cr=1

" Ctrlp
set runtimepath^=~/.vim/bundle/ctrlp.vim
let g:ctrlp_map = ',t'
let g:ctrlp_by_map=',t'
let g:ctrlp_cmd='CtrlP'
let g:ctrlp_working_path_mode='ra'
let g:ctrlp_custom_ignore = {
  \ 'dir' :  '\.git$\|\.hg$\|\.svn$\|framework\/external\|framework\/api\|vendor$\|files\|tests\/api\|docs$',
  \ 'file': '\v\.(exe|so|dll|xls|gif|png|jpeg|jpg|lock|zip)$',
\ }

" Powerline vim bindings
" set rtp+=~/.vim/bundle/powerline/powerline/bindings/vim
" let g:Powerline_symbols = "fancy"

" Airline
let g:airline_powerline_fonts=1

" Ultisnips custom mappings
" set rtp+=~/Dropbox/UltiSnips
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsListSnippets="<c-k>"
" let g:UltiSnipsSnippetDirectories=$HOME.'/Dropbox/UltiSnips'

" YouCompleteMe
let g:ycm_key_list_previous_completion=['<Up>']
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_autoclose_preview_window_after_completion = 1

" Dbext
let g:dbext_default_profile_mysql_dronten = 'type=MYSQL:user=root:passwd=:dbname=dronten:host=localhost'
let g:dbext_default_profile = 'mysql_dronten'
let g:dbext_default_prompt_for_parameters = 1
let g:dbext_default_parse_statements = 'select,update,show'

" bling
let g:bling_color='LightBlue'

" jsdoc
let g:jsdoc_default_mapping = 0

" emmet
let g:user_emmet_leader_key='<C-E>'

let g:ack_default_options=" -H --nocolor --nogroup --column"
