#!/usr/bin/env bash
# PreToolUse(Bash): block destructive commands regardless of stated intent.
# Exit 2 => block and feed stderr back to Claude.

cmd="$(jq -r '.tool_input.command // ""')"
[ -z "$cmd" ] && exit 0

deny() { echo "Blocked by bash-guard: $1" >&2; exit 2; }

case "$cmd" in
  *"rm -rf /"*|*"rm -fr /"*|*"rm -rf ~"*|*"rm -rf /*"*) deny "destructive rm" ;;
esac

if echo "$cmd" | grep -Eq 'git\s+push\s+.*(--force|-f)\b'; then
  echo "$cmd" | grep -Eq '\b(origin\s+)?(main|master)\b' && deny "force-push to main/master"
fi

echo "$cmd" | grep -Eq 'git\s+reset\s+--hard'        && deny "git reset --hard"
echo "$cmd" | grep -Eq 'git\s+clean\s+-[a-z]*f'      && deny "git clean -f"
echo "$cmd" | grep -Eq 'git\s+checkout\s+--\s+\.'    && deny "git checkout -- ."
echo "$cmd" | grep -Eq '--no-verify|--no-gpg-sign'   && deny "hook/signing bypass"
echo "$cmd" | grep -Eq '>\s*(~/\.ssh/|/etc/)'        && deny "write under ~/.ssh or /etc"

exit 0
