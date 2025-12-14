set fish_greeting

# Aliases
alias cl clear
alias op open
alias md mkdir
alias rd rmdir
alias t touch
alias fv 'find . -type f | peco | xargs nvim'
alias ll 'eza --long --no-user --no-permissions --icons'
alias v nvim
alias gs 'git status'
alias ga 'git add'
alias gc 'git commit -m'
alias gps 'git push'
alias gp 'git pull'
alias gm 'git mv'
alias gr 'git rm'

starship init fish | source

# Created by `pipx` on 2025-12-14 14:21:49
set PATH $PATH /Users/fatjongashi/.local/bin
