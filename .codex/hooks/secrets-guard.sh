#!/usr/bin/env bash
# PreToolUse: block shell or MCP access to secret material.
# Exit 2 blocks the tool call in Codex.

input="$(cat)"
cmd="$(echo "$input" | jq -r '.tool_input.command // ""')"

deny() { echo "Blocked by secrets-guard: matched secret pattern ($1)" >&2; exit 2; }

# Patterns that identify secret material as a path token, avoiding broad
# substring matches like "environment".
SECRET_RE='(^|/|[[:space:]])\.env($|\.|[[:space:]])|(^|/)id_(rsa|ed25519|ecdsa|dsa)\b|\.(pem|key)($|[[:space:]])|(^|/)\.ssh/|(^|/)\.aws/credentials|(^|/)\.config/gcloud/|credentials\.json'

if echo "$input" | grep -Eq "$SECRET_RE"; then
  if [ -z "$cmd" ]; then
    deny "tool input references secret material"
  fi
fi

# For Bash, only block when the command actually reads or exfiltrates such a file.
if [ -n "$cmd" ] \
  && echo "$cmd" | grep -Eq '\b(cat|less|more|head|tail|bat|grep|rg|cp|scp|xxd|od|strings|nl|awk|sed|sort|cut|tee|base64|openssl)\b' \
  && echo "$cmd" | grep -Eq "$SECRET_RE"; then
  deny "Bash command touches secret file"
fi

exit 0
