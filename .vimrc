set nocompatible

" Configure color scheme
set background=dark
autocmd ColorScheme * highlight BadWhitespace ctermbg=red guibg=red
set t_Co=256
colo elflord
syntax on
highlight ColorColumn ctermbg=233 guibg=#232323

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
set ve+=block                       " Enables block add of trailing spaces on lines with different lengths
set colorcolumn=0
set timeoutlen=500

" Keyboard remaps
" esc in insert & visual mode
inoremap kj <ESC>
vnoremap kj <ESC>

" esc in command mode
cnoremap kj <C-C>
" Note: In command mode mappings to esc run the command for some odd
" historical vi compatibility reason. We use the alternate method of
" existing which is Ctrl-C

" Functions
" Clears trailing whitespaces
fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

" Commands
" Clears trailing whitespaces
command! TrimWhitespace call TrimWhitespace()

" Python settings
"au BufNewFile,BufRead *.py,*.pyw 
au FileType python
    \ set list                      |
    \ set listchars+=tab:»→         |
    \ set number                    |
    \ set colorcolumn=80            |
    \ set textwidth=79              |
    \ set nowrap                    |
    \ set formatoptions-=t          |
    \ set fileformat=unix           |
    \ match BadWhitespace /\s\+$/

" Makefile settings
au BufNewfile,BufRead *Makefile*
    \ set fileformat=unix           |
    \ set noexpandtab               |
    \ match BadWhitespace /\s\+$/

" Bash settings
au BufNewfile,BufRead *.sh
    \ set fileformat=unix           |
    \ set noexpandtab               |
    \ match BadWhitespace /\s\+$/

" C settings
au BufRead,BufNewFile *.c,*.h 
    \ set number                    |
    \ match BadWhitespace /\s\+$/

" Verilog settings
au BufNewfile,BufRead *.v,*.sv 
    \ set number                    |
    \ set tabstop=2                 |
    \ set softtabstop=2             |
    \ set shiftwidth=2              |
    \ match BadWhitespace /\s\+$/

" ----------------------------------------
" Automatic installation of vim-plug, if it's not available
" ----------------------------------------
if empty(glob('$HOME/.vim/autoload/plug.vim'))
  silent !curl -kfLo $HOME/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
"-----------------------------------------

"-----------------------------------------
" Automatically install missing plugins on startup
"-----------------------------------------
autocmd VimEnter *
      \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
      \|   PlugInstall --sync | q
      \| endif
"-----------------------------------------

"-----------------------------------------
" Plugins
" Commented plugins are saved here for later
"-----------------------------------------
"call plug#begin('$HOME/.vim/plugged')
silent! if plug#begin('$HOME/.vim/plugged')

" Intellisense feature for Vim
"Plug 'neoclide/coc.nvim', {'branch': 'release'}

" " NERDTree file system explorer with git plugin
" Plug 'preservim/nerdtree' |
"             \ Plug 'Xuyuanp/nerdtree-git-plugin'

" NERDTree file system explorer
Plug 'preservim/nerdtree'

" NERDCommenter shortcuts for commenting code
Plug 'preservim/nerdcommenter'

" Tagbar: a class outline viewer for Vim
Plug 'preservim/tagbar'

" Vim-Polyglot: A collection of language packs for Vim.
Plug 'sheerun/vim-polyglot'

" Vim-Templates
Plug 'tibabit/vim-templates'

" Jedi-Vim - awesome Python autocompletion with VIM
Plug 'davidhalter/jedi-vim'

"" Syntastic syntax checking plugin
"Plug 'vim-syntastic/syntastic'

" Autocomplete
"Plug 'Valloric/YouCompleteMe'

" Powerline (status bar)
" Plug 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}

" Unicode search plugin
Plug 'chrisbra/unicode.vim'

call plug#end()
endif

" Plugins config
" NERDTree
let NERDTreeShowHidden=1

" Vim-Templates
let g:tmpl_search_paths = ['$HOME/.vim/templates']
let g:tmpl_author_name = 'Agknaton Bottenberg'

" If there are any machine-specific tweaks for Vim, load them from the following file.
try 
  source $HOME/.vimrc_local
catch
  " No such file? No problem; just ignore it.
endtry 
