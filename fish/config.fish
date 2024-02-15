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
    # Commands to run in interactive sessions can go here

    # Aliases
    alias cls clear
    alias op open
    alias cd.. 'cd ..'
    alias md mkdir
    alias rd rmdir
    alias t touch
    alias ll 'exa --header --long --extended --group-directories-first --no-user --no-permissions --icons'
    alias v nvim
    alias rbackup 'rsync -avh --progress --exclude={"/data/*","/dev/*","/proc/*","/sys/*","/tmp/*","/run/*","/mnt/*","/media/*","/lost+found"} --delete / /data/backup/'

    # Themes
    #set -g theme_display_user yes
    #set -g color_user_bg 005b96
    #set -g color_user_str white
    #set -g color_dir_bg 0086ad
    #set -g color_dir_str black

end

starship init fish | source
