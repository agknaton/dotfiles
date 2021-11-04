# dotfiles
My dotfiles

# Install  
    git clone --bare https://github.com/agknaton/dotfiles.git $HOME/.dotfiles
    git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME checkout
    git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME config --local status.showUntrackedFiles no  

# Usage
After install an alias will be created to work with the dotfiles under Git:  
    dotfiles

Replace `git` by `dotfiles` for all operations.
