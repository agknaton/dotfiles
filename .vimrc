set nocompatible

" Configure color scheme
autocmd ColorScheme * highlight BadWhitespace ctermbg=red guibg=red
colo evening
syntax on

" Default to not read-only in vimdiff
set noro

" Global edit settings
set encoding=utf-8
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

" Python settings
au BufNewFile,BufRead *.py,*.pyw 
    \ set textwidth=79              |
    \ set autoindent                |
    \ set fileformat=unix           |
    \ match BadWhitespace /\s\+$/

" Makefile settings
au BufNewfile,BufRead *Makefile*
    \ set noexpandtab

" Bash settings
au BufNewfile,BufRead *.sh
    \ set noexpandtab

" C settings
au BufRead,BufNewFile *.c,*.h 
    \ match BadWhitespace /\s\+$/

" Verilog settings
au BufNewfile,BufRead *.v,*.sv 
    \ set tabstop=4                 |
    \ set softtabstop=4             |
    \ set shiftwidth=4

" Plugins init
if empty(glob('$HOME/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('$HOME/.vim/plugged')
" Intellisense feature for Vim
"Plug 'neoclide/coc.nvim', {'branch': 'release'}

" NERDTree file system explorer with git plugin
Plug 'preservim/nerdtree' |
            \ Plug 'Xuyuanp/nerdtree-git-plugin'

" Autocomplete
" Plug 'Valloric/YouCompleteMe'

" Powerline (status bar)
" Plug 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}

call plug#end()

" Plugins config
let NERDTreeShowHidden=1
