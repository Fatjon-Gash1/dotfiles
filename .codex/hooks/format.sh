#!/usr/bin/env bash
# PostToolUse(Edit|Write|apply_patch): format touched files with project tools.
# Silent on success, never blocks.

input="$(cat)"

have() { command -v "$1" >/dev/null 2>&1; }

format_file() {
  local file=$1
  [ -z "$file" ] || [ ! -f "$file" ] && return 0

  case "$file" in
    *.lua) have stylua && stylua "$file" ;;
    *.py) have ruff && ruff format "$file" >/dev/null 2>&1 ;;
    *.js|*.jsx|*.ts|*.tsx|*.json|*.css|*.md|*.yml|*.yaml)
      have prettier && prettier --write "$file" >/dev/null 2>&1
      ;;
    *.fish) have fish_indent && fish_indent -w "$file" ;;
  esac
}

file="$(echo "$input" | jq -r '.tool_input.file_path // ""')"
if [ -n "$file" ]; then
  format_file "$file"
  exit 0
fi

# Codex apply_patch hooks usually provide the patch command, not a single file
# path. Extract touched paths conservatively from patch headers.
echo "$input" \
  | jq -r '.tool_input.command // .tool_input.patch // ""' \
  | sed -n 's/^\*\*\* \(Add\|Update\) File: //p' \
  | while IFS= read -r patch_file; do
      format_file "$patch_file"
    done

exit 0
