# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository purpose

Personal dotfiles for an Arch Linux + i3 setup. The repo is checked out to `~/dotfiles` and individual configs are symlinked into `~/.config`, `~/`, and `/etc/xdg/reflector` by `install.sh`. There is no build, test, or lint pipeline — changes take effect by editing files in place (the live configs are symlinks back into this repo).

## Layout / what each top-level dir is

Plain config dirs symlinked to `~/.config/<name>`: `i3`, `polybar`, `picom`, `ranger`, `alacritty`, `fish`, `nvim`, `rofi`, `feh`, `kanata`. Loose files symlinked individually: `code-flags.conf`, `starship.toml`, `.tmux.conf`, `.xinitrc`, `.prettierrc`, `reflector.conf` (root-owned, into `/etc/xdg/reflector`).

Agent tooling configs are organized to be shared across CLIs:

- `.claude/` → symlinked piecewise into `~/.claude/` (subdirs: `agents/`, `skills/`, `rules/`, `output-styles/`, `hooks/`). MCP servers and main settings live in `~/.claude.json` and are NOT in this repo. `settings.local.json` is the only checked-in settings file. `plugins/` is app-managed and not tracked.
- `.codex/` → symlinked piecewise into `~/.codex/` (subdirs: `agents/`, `hooks/`, `rules/`, plus `AGENTS.md` and `hooks.json`). Main config (`config.toml` and MCP) lives outside this repo.
- `.agents/skills/` → symlinked to `~/.agents/skills/`, the cross-tool Agent Skills location consumed by Codex.

The `.claude/` tree keeps Claude's native structure. The `.codex/` tree keeps Codex-specific equivalents: global instructions in `AGENTS.md`, hook wiring in `hooks.json`, shell scripts under `hooks/`, command rules under `rules/`, and optional custom agents under `agents/`.

## Install / apply changes

```
~/dotfiles/install.sh
```

The script is idempotent — safe to re-run on an already-installed system. It uses a `lns` helper that removes an existing symlink at the destination before re-linking (`[ -L "$dst" ] && rm "$dst"`). Real directories or files are never removed, so if a destination exists and is not a symlink, `ln -s` will fail visibly rather than silently nest or overwrite.

Editing any file in this repo updates the live config immediately via the symlink — no reload step beyond whatever the target tool needs (e.g. `i3-msg restart`, `:source` in nvim, `exec fish`).

## Neovim config structure

Entrypoint `nvim/init.lua` loads `lua/sets.lua`, `lua/keymaps.lua`, and `lua/plugins.lua`. Plugin manager is **packer.nvim** (compiled output `nvim/plugin/packer_compiled.lua` is gitignored). Per-plugin setup lives in `nvim/lua/pluginsConf/` with `init.lua` as the dispatcher; add a new plugin by declaring it in `plugins.lua` and creating a matching `pluginsConf/<name>.lua` required from `pluginsConf/init.lua`. After changing `plugins.lua`, run `:PackerSync` inside nvim.

## Fish shell config

`fish/config.fish` is the entrypoint. `fish/conf.d/` is autoloaded (note: `conf.d` is gitignored, so machine-local snippets like `nvm.fish`, `z.fish` are not tracked). `fish/functions/` holds individual function files (one function per file, fish convention). Plugin list is `fish/fish_plugins` (managed by fisher). Prompt is starship (`starship.toml` at repo root).

## Conventions worth knowing

- `.gitignore` excludes `nvim/plugin/packer_compiled.lua`, `fish/fish_variables`, `fish/conf.d`, and `*.bak`. Don't try to commit generated/local state in those paths.
- `arch_packages_list.txt` is a manual snapshot of installed packages, not auto-generated.
- `checkstyle.xml` and `.prettierrc` are personal style configs used by editors/projects, unrelated to this repo's own tooling.
