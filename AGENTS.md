# Repository Guidelines

## Project Structure & Module Organization

This repository stores personal Linux dotfiles and agent configuration. Top-level
directories map directly to target config locations, usually under `~/.config`.
Examples: `i3/`, `polybar/`, `picom/`, `alacritty/`, `fish/`, `nvim/`,
`ranger/`, `rofi/`, `feh/`, and `kanata/`. Shared single-file configs live at the root,
such as `starship.toml`, `.tmux.conf`, `.xinitrc`, `.prettierrc`, and
`reflector.conf`. Agent-related files are grouped under `.claude/`, `.codex/`,
and `.agents/`. Images and other visual assets belong in `images/`.

## Build, Test, and Development Commands

There is no build step. Validate changes with the tool that owns the config:

```bash
./install.sh                    # Symlink configs into the home directory
fish_indent -w fish/**/*.fish   # Format Fish shell functions when available
stylua nvim/**/*.lua            # Format Neovim Lua config when available
prettier --write '**/*.{md,json,yml,yaml}' # Format supported text configs
```

Run `./install.sh` only after reviewing its symlink targets. It overwrites
existing symlinks and updates `/etc/xdg/reflector/reflector.conf` with `sudo`.

## Coding Style & Naming Conventions

Keep configuration files readable and minimal. Use 4-space indentation where the
format allows it, matching `.prettierrc`. Lua modules under `nvim/lua/` use
lowercase file names and focused plugin config files, for example
`nvim/lua/pluginsConf/telescope.lua`. Shell scripts should use `bash`, quote
variables, and prefer small helper functions like `lns()` in `install.sh`.

## Testing Guidelines

No automated test suite is defined. Test by loading the affected application:
start a new Fish shell after editing `fish/`, run Neovim after editing `nvim/`,
and reload i3/polybar after window-manager changes. For scripts, run:

```bash
bash -n install.sh
bash -n .claude/hooks/*.sh
```

When changing agent hooks, verify they fail safely and do not expose secret
paths such as `.env`, private keys, or cloud credentials.

## Commit & Pull Request Guidelines

Use concise Conventional Commit style observed in history:
`chore(claude): update settings`, `feat: update install script`, or
`chore(nvim): add md treesitter parsers`. Keep the scope tied to the affected
tool or directory when useful.

Pull requests should explain the changed tool, list manual validation performed,
and note any new dependency or package requirement. Include screenshots only for
visual changes such as `i3`, `polybar`, `rofi`, or terminal theme updates.

## Security & Configuration Tips

Do not commit machine-specific secrets, tokens, SSH keys, `.env` files, or cloud
credentials. Prefer placeholders and document required local setup in `README.md`
or the relevant config file comments.
