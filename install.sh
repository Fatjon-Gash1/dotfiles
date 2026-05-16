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

lns ~/dotfiles/code-flags.conf ~/.config/code-flags.conf
lns ~/dotfiles/starship.toml   ~/.config/starship.toml
lns ~/dotfiles/.tmux.conf      ~/.tmux.conf
lns ~/dotfiles/.xinitrc        ~/.xinitrc
lns ~/dotfiles/.prettierrc     ~/.prettierrc

[ -L /etc/xdg/reflector/reflector.conf ] && sudo rm /etc/xdg/reflector/reflector.conf
sudo ln -s ~/dotfiles/reflector.conf /etc/xdg/reflector/reflector.conf

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
#   agents/   subagent/role TOML files
#   prompts/  custom slash commands (.md)
#   hooks/    hook scripts (referenced from hooks.json or config.toml [hooks])
# MCP servers, hooks config, and main settings live in ~/.codex/config.toml.
# AGENTS.md (memory) is a file at ~/.codex/AGENTS.md or repo root.
mkdir -p ~/.codex
for dir in agents prompts hooks; do
  lns ~/dotfiles/.codex/$dir ~/.codex/$dir
done

# Cross-tool skills (Agent Skills standard) consumed by Codex from ~/.agents/skills/
mkdir -p ~/.agents
lns ~/dotfiles/.agents/skills ~/.agents/skills
