set fish_greeting

# Aliases
alias cl clear
alias op open
alias md mkdir
alias rd rmdir
alias t touch
alias fv 'nvim $(fzf)'
alias ll 'exa --header --long --extended --group-directories-first --no-user --no-permissions --icons=auto'
alias rbackup 'sudo rsync -aAXHS --numeric-ids --delete --delete-excluded --info=progress2 \
  --exclude={"/data/***","/dev/***","/proc/***","/sys/***","/tmp/***","/run/***","/mnt/***","/media/***","/lost+found","/swapfile","/var/tmp/***","/var/cache/pacman/pkg/***","/var/lib/systemd/coredump/***","/home/*/.cache/***"} \
  / /data/backup/'
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

# Created by `pipx` on 2025-02-11 21:59:50
set PATH $PATH /home/fatjon/.local/bin
