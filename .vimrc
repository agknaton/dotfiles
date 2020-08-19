set nocompatible

" Configure color scheme
autocmd ColorScheme * highlight BadWhitespace ctermbg=red guibg=red
colo evening
syntax on

" Default to not read-only in vimdiff
set noro

" Fix backspace behaviour
set backspace=indent,eol,start

" Global edit settings
set encoding=utf-8
set autoindent
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set textwidth=0

" Python settings
"    \ set textwidth=79              |
au BufNewFile,BufRead *.py,*.pyw 
	\ set number					|
    \ set fileformat=unix           |
    \ match BadWhitespace /\s\+$/

" Makefile settings
au BufNewfile,BufRead *Makefile*
    \ set fileformat=unix           |
    \ set noexpandtab

" Bash settings
au BufNewfile,BufRead *.sh
    \ set fileformat=unix           |
    \ set noexpandtab

" C settings
au BufRead,BufNewFile *.c,*.h 
	\ set number					|
    \ match BadWhitespace /\s\+$/

" Verilog settings
au BufNewfile,BufRead *.v,*.sv 
	\ set number					|
    \ set tabstop=2                 |
    \ set softtabstop=2             |
    \ set shiftwidth=2

" Plugins init
if empty(glob('$HOME/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('$HOME/.vim/plugged')
"Commented plugins are saved here for later

" Intellisense feature for Vim
"Plug 'neoclide/coc.nvim', {'branch': 'release'}

" " NERDTree file system explorer with git plugin
" Plug 'preservim/nerdtree' |
"             \ Plug 'Xuyuanp/nerdtree-git-plugin'

" NERDTree file system explorer with git plugin
Plug 'preservim/nerdtree' 

" NERDCommenter shortcuts for commenting code
Plug 'preservim/nerdcommenter'

"" Syntastic syntac checking plugin
"Plug 'vim-syntastic/syntastic'

" Autocomplete
" Plug 'Valloric/YouCompleteMe'

" Powerline (status bar)
" Plug 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}

call plug#end()

" Plugins config
let NERDTreeShowHidden=1
