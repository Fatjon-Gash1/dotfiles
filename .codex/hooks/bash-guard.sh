#!/usr/bin/env bash
# PreToolUse(Bash): block destructive commands regardless of stated intent.
# Exit 2 blocks the tool call in Codex.

cmd="$(jq -r '.tool_input.command // ""')"
[ -z "$cmd" ] && exit 0

deny() { echo "Blocked by bash-guard: $1" >&2; exit 2; }

case "$cmd" in
  *"rm -rf /"*|*"rm -fr /"*|*"rm -rf ~"*|*"rm -rf /*"*) deny "destructive rm" ;;
esac

# --- git push force-push guard ---------------------------------------------
# Default branch (main/master): every force variant is blocked, including
# --force-with-lease. Any other (short-lived) branch: a bare --force/-f is
# blocked, but --force-with-lease/--force-if-includes is allowed. The target
# branch is resolved from the refspec, or from HEAD when none is given, so a
# branch merely *named* like "fix/main-x" is not mistaken for the default and
# "git push --force" while checked out on main is still caught.
while IFS= read -r seg; do
  [ -z "$seg" ] && continue
  echo "$seg" | grep -Eq -- '--force|(^|[[:space:]])-[A-Za-z]*f[A-Za-z]*([[:space:]]|$)' || continue

  lease=0; plain=0
  echo "$seg" | grep -Eq -- '--force-with-lease|--force-if-includes' && lease=1
  echo "$seg" | grep -Eq -- '(^|[[:space:]])--force([[:space:]=]|$)'            && plain=1
  echo "$seg" | grep -Eq -- '(^|[[:space:]])-[A-Za-z]*f[A-Za-z]*([[:space:]]|$)' && plain=1
  [ "$lease" = 0 ] && [ "$plain" = 0 ] && continue

  args="$(echo "$seg" | sed -E 's/.*\bpush\b//' | tr ' ' '\n' | grep -Ev '^-|^$')"
  refspec="$(printf '%s\n' "$args" | sed -n '2p')"
  case "$refspec" in
    *:*) dst="${refspec##*:}" ;;
    "")  dst="" ;;
    *)   dst="$refspec" ;;
  esac
  if [ -z "$dst" ] || [ "$dst" = HEAD ]; then
    dst="$(git symbolic-ref --quiet --short HEAD 2>/dev/null \
           || git rev-parse --abbrev-ref HEAD 2>/dev/null)"
  fi
  dst="${dst#refs/heads/}"

  if echo "$dst" | grep -Eq '^(main|master)$'; then
    deny "force-push to default branch '${dst}' is never allowed"
  elif [ "$plain" = 1 ]; then
    deny "bare force-push to '${dst:-?}'; use --force-with-lease on short-lived branches"
  fi
done <<EOF
$(echo "$cmd" | grep -oE '\bgit\b[^&|;]*\bpush\b[^&|;]*')
EOF

echo "$cmd" | grep -Eq 'git\s+reset\s+--hard'      && deny "git reset --hard"
echo "$cmd" | grep -Eq 'git\s+clean\s+-[a-z]*f'    && deny "git clean -f"
echo "$cmd" | grep -Eq 'git\s+checkout\s+--\s+\.'  && deny "git checkout -- ."
echo "$cmd" | grep -Eq '--no-verify|--no-gpg-sign' && deny "hook/signing bypass"
echo "$cmd" | grep -Eq '>\s*(~/\.ssh/|/etc/)'      && deny "write under ~/.ssh or /etc"

exit 0
