set fish_greeting

# Aliases
alias cl clear
alias op open
alias md mkdir
alias rd rmdir
alias t touch
alias fv 'find . -type f | peco | xargs nvim'
alias ll 'exa --header --long --extended --group-directories-first --no-user --no-permissions --icons'
alias rbackup 'sudo rsync -avh --progress --exclude={"/data/*","/dev/*","/proc/*","/sys/*","/tmp/*","/run/*","/mnt/*","/media/*","/lost+found"} --delete / /data/backup/'
alias v nvim
alias s startx
alias gs 'git status'
alias ga 'git add'
alias gc 'git commit -m'
alias gps 'git push'
alias gp 'git pull'
alias gm 'git mv'
alias gr 'git rm'

starship init fish | source
