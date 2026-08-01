function bks --description 'Backup root filesystem to /data/backup'
    sudo rsync -aAXHS \
        --numeric-ids \
        --delete \
        --delete-excluded \
        --info=progress2 \
        --exclude={"/data/***","/dev/***","/proc/***","/sys/***","/tmp/***","/run/***","/mnt/***","/media/***","/lost+found","/swapfile","/var/tmp/***","/var/cache/pacman/pkg/***","/var/lib/systemd/coredump/***","/home/*/.cache/***"} \
        / /data/backup/
end
