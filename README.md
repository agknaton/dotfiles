# dotfiles
My dotfiles  
README.md is separated in the master branch and the actual dotfiles in home branch so the README doesn't get checked out.

# (optional) Preferred WSL install (for Windows systems only)
1. Install your preferred distro with ``wsl --install -d <distro_name>``
1. Install [mintty](https://github.com/mintty/wsltty) as the preferred terminal
1. Configure git credential manager in WSL:  

       mkdir -p ~/.config/git
       git config --file ~/.config/git/config credential.helper "/mnt/c/Program\ Files/Git/mingw64/libexec/git-core/git-credential-manager-core.exe"

# Install the dotfiles
    git clone --bare -b home --single-branch https://github.com/agknaton/dotfiles.git $HOME/.dotfiles
    git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME checkout --force
    git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME config --local status.showUntrackedFiles no
    cd .dotfiles
    git fetch origin install:install

Now, after restarting your terminal, use ``dotfiles`` instead of ``git`` to manipulate the files.

# Automated system setup
1. Checkout the **install** branch to expose the scripts with ``dotfiles checkout install``
1. Just run the install script from the list below (downloaded with the dotfiles):
    1. **General bash based setup**: ./install.sh -h
1. Revert to the **home** branch to hide the install files with ``dotfiles_imec checkout home``
1. Profit 😎
