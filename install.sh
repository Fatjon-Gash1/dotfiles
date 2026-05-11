#!/bin/bash
ln -s ~/dotfiles/i3/ ~/.config
ln -s ~/dotfiles/polybar/ ~/.config
ln -s ~/dotfiles/picom/ ~/.config
ln -s ~/dotfiles/ranger/ ~/.config
ln -s ~/dotfiles/alacritty/ ~/.config
ln -s ~/dotfiles/fish/ ~/.config
ln -s ~/dotfiles/nvim/ ~/.config
ln -s ~/dotfiles/rofi/ ~/.config
ln -s ~/dotfiles/feh/ ~/.config

ln -s ~/dotfiles/code-flags.conf ~/.config
ln -s ~/dotfiles/starship.toml ~/.config
ln -s ~/dotfiles/.tmux.conf ~/
ln -s ~/dotfiles/.xinitrc ~/
ln -s ~/dotfiles/.prettierrc ~/
sudo ln -s ~/dotfiles/reflector.conf /etc/xdg/reflector

# Claude Code: ~/.claude/ (docs: code.claude.com)
#   agents/         subagents
#   commands/       custom slash commands (legacy; skills supersede)
#   skills/         skills (each is a dir with SKILL.md)
#   output-styles/  custom output styles
#   hooks/          hook scripts (referenced from settings.json)
#   plugins/        plugin marketplace refs
# MCP servers live in ~/.claude.json (global) — no dir to symlink.
mkdir -p ~/.claude
for dir in agents commands skills output-styles hooks plugins; do
  ln -s ~/dotfiles/.claude/$dir ~/.claude/$dir
done

# Codex CLI: ~/.codex/ (docs: developers.openai.com/codex)
#   agents/   subagent/role TOML files
#   prompts/  custom slash commands (.md)
#   hooks/    hook scripts (referenced from hooks.json or config.toml [hooks])
# MCP servers, hooks config, and main settings live in ~/.codex/config.toml.
# AGENTS.md (memory) is a file at ~/.codex/AGENTS.md or repo root.
mkdir -p ~/.codex
for dir in agents prompts hooks; do
  ln -s ~/dotfiles/.codex/$dir ~/.codex/$dir
done

# Cross-tool skills (Agent Skills standard) consumed by Codex from ~/.agents/skills/
mkdir -p ~/.agents
ln -s ~/dotfiles/.agents/skills ~/.agents/skills
