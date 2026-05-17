## Configs are for:

-   i3 - Tiling window manager.
-   picom - Xorg display compositor.
-   Polybar - Highly customizable status bar.
-   alacritty - Fast GPU-accelerated terminal.
-   fish (shell) + fisher + starship (customizable prompt).
-   Neovim - Vim fork (fully configured with LSPs, linters,
    parsers, auto-complete, and a bunch of plugins).
-   rofi - Application launcher and dmenu replacement.
-   ranger - Terminal file manager.
-   feh - Wallpaper setter.
-   xremap - Key remapper.
-   tmux - Terminal multiplexer.
-   Claude Code (`.claude/`) and Codex CLI (`.codex/`) agent tooling.

These are some of the tools that I use and have customized for my development workflow.

> [!CAUTION]
> Some of the configured files require external dependencies.  
> Make sure to carefully review the files you want to use.

## Usage:

```
$ git clone https://github.com/Fatjon-Gash1/dotfiles.git ~/dotfiles
$ ~/dotfiles/install.sh
```

> [!NOTE]
> The install script is idempotent — safe to re-run. It replaces existing symlinks but will not overwrite real directories or files.
