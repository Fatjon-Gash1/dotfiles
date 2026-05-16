#!/usr/bin/env bash
# PreToolUse(Read|Bash): block access to secret material.
# Exit 2 => block and feed stderr back to Claude.

input="$(cat)"
path="$(echo "$input" | jq -r '.tool_input.file_path // ""')"
cmd="$(echo "$input"  | jq -r '.tool_input.command // ""')"

deny() { echo "Blocked by secrets-guard: matched secret pattern ($1)" >&2; exit 2; }

# Patterns that identify secret material as a path token (not arbitrary
# substrings, to avoid false positives like "npm run dev --environment").
SECRET_RE='(^|/|[[:space:]])\.env($|\.|[[:space:]])|(^|/)id_(rsa|ed25519|ecdsa|dsa)\b|\.(pem|key)($|[[:space:]])|(^|/)\.ssh/|(^|/)\.aws/credentials|(^|/)\.config/gcloud/|credentials\.json'

if [ -n "$path" ] && echo "$path" | grep -Eq "$SECRET_RE"; then
  deny "Read path: $path"
fi

# For Bash, only block when the command actually reads/exfiltrates such a file.
if [ -n "$cmd" ] \
  && echo "$cmd" | grep -Eq '\b(cat|less|more|head|tail|bat|grep|rg|cp|scp|xxd|od|strings|nl|awk|sed|sort|cut|tee|base64|openssl)\b' \
  && echo "$cmd" | grep -Eq "$SECRET_RE"; then
  deny "Bash command touches secret file"
fi

exit 0
