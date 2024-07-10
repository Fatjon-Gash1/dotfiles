set fish_greeting

if status is-interactive

    # Aliases
    alias cl clear
    alias op open
    alias md mkdir
    alias rd rmdir
    alias t touch
    alias fv 'find . -type f | peco | xargs nvim'
    alias ll 'exa --header --long --extended --group-directories-first --no-user --no-permissions --icons'
    alias v nvim
    alias s startx
    alias gs 'git status'
    alias ga 'git add'
    alias gc 'git commit -m'
    alias gps 'git push'
    alias gp 'git pull'
    alias gm 'git mv'
    alias gr 'git rm'

end

starship init fish | source
