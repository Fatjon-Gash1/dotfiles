#!/usr/bin/env bash
# PostToolUse(Edit|Write): format the touched file with the project's
# formatter if it is installed. Silent on success, never blocks.

file="$(jq -r '.tool_input.file_path // ""')"
[ -z "$file" ] || [ ! -f "$file" ] && exit 0

have() { command -v "$1" >/dev/null 2>&1; }

case "$file" in
  *.lua)              have stylua   && stylua "$file" ;;
  *.py)               have ruff     && ruff format "$file" >/dev/null 2>&1 ;;
  *.js|*.jsx|*.ts|*.tsx|*.json|*.css|*.md|*.yml|*.yaml)
                      have prettier && prettier --write "$file" >/dev/null 2>&1 ;;
  *.fish)             have fish_indent && fish_indent -w "$file" ;;
esac

exit 0
