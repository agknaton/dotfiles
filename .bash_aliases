# define alias and config for todo.txt
alias toh='todo.sh -aNtd $HOME/.todo_home.cfg'
alias tom='todo.sh -aNtd $HOME/.todo_agknaton.cfg'

# Handle Git VCS for my global dotfiles in github
alias dotfiles='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# Clean up Python cache files
alias pyclean='find . \( -name "__pycache__" -o -name "*.pyc" -o -name "*.egg-info" -o -name "*.pyc" \) -exec rm -rf {} \;'

# Global aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

