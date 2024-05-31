set fish_greeting

# Set GNOME schema
set gnome_schema org.gnome.desktop.interface

# Set GTK theme, icon theme, cursor theme, and font name
gsettings set $gnome_schema gtk-theme Arc-Dark
gsettings set $gnome_schema icon-theme Papirus-Dark
gsettings set $gnome_schema cursor-theme Adwaita
gsettings set $gnome_schema font-name 'Monospace 11'

# Set pywal colors for the terminal
cat ~/.cache/wal/sequences


if status is-interactive

    # Aliases
    alias cl clear
    alias op open
    alias cd.. 'cd ..'
    alias md mkdir
    alias rd rmdir
    alias t touch
    alias ll 'exa --header --long --extended --group-directories-first --no-user --no-permissions --icons'
    alias v nvim
    alias rbackup 'sudo rsync -avh --progress --exclude={"/data/*","/dev/*","/proc/*","/sys/*","/tmp/*","/run/*","/mnt/*","/media/*","/lost+found"} --delete / /data/backup/'
    alias gs 'git status'
    alias ga 'git add'
    alias gc 'git commit -m'
    alias gps 'git push'
    alias gp 'git pull'
    alias gm 'git mv'
    alias gr 'git rm'

end

starship init fish | source
