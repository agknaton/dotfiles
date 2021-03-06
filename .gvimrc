" Fix unicode characteres display issue
set guifont=Courier_new:h11 

" ----------------------------------------
" Gives message to fix plugin install
" ----------------------------------------
if empty(glob('$HOME/vimfiles/autoload/plug.vim'))
  !echo Run 'ln -s $HOME/.vim/autoload $HOME/vimfiles/autoload' from bash
endif

