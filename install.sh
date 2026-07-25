#!/bin/bash

lns() {
  local src=$1 dst=$2
  [ -L "$dst" ] && rm "$dst"
  ln -s "$src" "$dst"
}

lns ~/dotfiles/i3        ~/.config/i3
lns ~/dotfiles/polybar   ~/.config/polybar
lns ~/dotfiles/picom     ~/.config/picom
lns ~/dotfiles/ranger    ~/.config/ranger
lns ~/dotfiles/alacritty ~/.config/alacritty
lns ~/dotfiles/fish      ~/.config/fish
lns ~/dotfiles/nvim      ~/.config/nvim
lns ~/dotfiles/rofi      ~/.config/rofi
lns ~/dotfiles/feh       ~/.config/feh
lns ~/dotfiles/kanata    ~/.config/kanata

lns ~/dotfiles/code-flags.conf ~/.config/code-flags.conf
lns ~/dotfiles/starship.toml   ~/.config/starship.toml
lns ~/dotfiles/.tmux.conf      ~/.tmux.conf
lns ~/dotfiles/.xinitrc        ~/.xinitrc
lns ~/dotfiles/.prettierrc     ~/.prettierrc

[ -L /etc/xdg/reflector/reflector.conf ] && sudo rm /etc/xdg/reflector/reflector.conf
sudo ln -s ~/dotfiles/reflector.conf /etc/xdg/reflector/reflector.conf

[ -L /etc/X11/xorg.conf.d/00-keyboard.conf ] && sudo rm /etc/X11/xorg.conf.d/00-keyboard.conf
sudo ln -s ~/dotfiles/00-keyboard.conf /etc/X11/xorg.conf.d/00-keyboard.conf

# Claude Code: ~/.claude/ (docs: code.claude.com)
#   agents/         subagents
#   skills/         skills invoked with /name (each is a dir with SKILL.md)
#   rules/          topic-scoped instructions, optionally path-gated
#   output-styles/  custom output styles
#   hooks/          hook scripts (referenced from settings.json)
# plugins/ is app-managed — not symlinked. MCP servers live in ~/.claude.json.
mkdir -p ~/.claude
for dir in agents skills rules output-styles hooks; do
  lns ~/dotfiles/.claude/$dir ~/.claude/$dir
done
lns ~/dotfiles/.claude/settings.json ~/.claude/settings.json

# Codex CLI: ~/.codex/ (docs: developers.openai.com/codex)
#   agents/  custom agent TOML files
#   hooks/   hook scripts (referenced from hooks.json or config.toml [hooks])
#   rules/   command permission rules (*.rules)
# MCP servers and main settings live in ~/.codex/config.toml.
mkdir -p ~/.codex
for dir in agents hooks rules; do
  lns ~/dotfiles/.codex/$dir ~/.codex/$dir
done
lns ~/dotfiles/.codex/AGENTS.md ~/.codex/AGENTS.md
lns ~/dotfiles/.codex/hooks.json ~/.codex/hooks.json

# Cross-tool skills (Agent Skills standard) consumed by Codex from ~/.agents/skills/
mkdir -p ~/.agents
lns ~/dotfiles/.agents/skills ~/.agents/skills
