" Fix unicode characteres display issue
set guifont=Courier_new:h11 

" Configure Python3 environment
let ANACONDA_PATH='C:\Users\' . $USERNAME . '\Anaconda3'
let $PATH .= ';' . ANACONDA_PATH
let $PATH .= ';' . ANACONDA_PATH . '\bin'
let $PATH .= ';' . ANACONDA_PATH . '\Library\bin'
let $PATH .= ';' . ANACONDA_PATH . '\Library\mingw-w64\bin'
let $PATH .= ';' . ANACONDA_PATH . '\Scripts'

" ----------------------------------------
" Gives message to fix plugin install
" ----------------------------------------
if empty(glob('$HOME/vimfiles/autoload/plug.vim'))
  !echo Run 'ln -s $HOME/.vim/autoload $HOME/vimfiles/autoload' from bash
endif

