# Arch Cleanup Guide

*To keep disk lean*

## 1. Package cache

Check cache size:
```bash
du -sh /var/cache/pacman/pkg/
```

### Automatic cleanup

Provided by `pacman-contrib`. Keeps the 3 latest versions of each
package by default, cleaning weekly.

```bash
sudo pacman -S pacman-contrib
sudo systemctl enable --now paccache.timer
```

Verify timer:
```bash
systemctl list-timers paccache.timer
systemctl cat paccache.timer
```

If the old custom monthly timer exists at
`/etc/systemd/system/paccache.timer`, remove it and reload systemd
to use the packaged weekly timer.

### Manual cleanup (only when needed)

```bash
sudo paccache -rk1  # Keep only the latest cached version
sudo pacman -Sc     # When disk space is tight
sudo pacman -Scc    # Delete entire cache (last resort)
```

Avoid `-Scc` routinely: it removes cached packages needed for
offline reinstallation or easy downgrades.

`-Sc` Removes all cached versions of uninstalled packages while
preserving cached versions of currently installed packages.

Alternative, using paccache:
```bash
sudo paccache -ruk0
```

Avoid `pacman -Scc` unless you need to clear the entire cache.

## 2. Remove orphan packages

List and inspect:
```bash
pacman -Qdt
```

Remove, only if the list contains nothing you still need:
```bash
sudo pacman -Rns $(pacman -Qdtq)
```

If a package is still wanted, mark it explicitly installed:
```bash
sudo pacman -D --asexplicit package_name
```

## 3. Clean home caches and old configs

Inspect cache sizes:
```bash
du -h -d1 ~/.cache | sort -h
```

Remove only caches belonging to applications you recognize,
preferably while those applications are closed.

Check for leftovers from uninstalled applications:
- `~/.config/` — settings
- `~/.local/share/` — application data
- `~/.cache/` — disposable application caches

Do not blindly delete these directories.
Remove individual application directories only when no longer needed.

## 4. Clean system logs (optional)

Check journal size:
```bash
journalctl --disk-usage
```

If excessively large, rotate and trim to approximately 200 MB:
```bash
sudo journalctl --rotate --vacuum-size=200M
```

## When to run 'em?

- Weekly: `paccache.timer` handles package cache automatically.
- Occasionally:
    - check `pacman -Qdt` for orphans, delete if reasonable.
    - and run `sudo pacman -Sc` if you're low on disk space.
