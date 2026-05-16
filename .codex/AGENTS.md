# Global Codex Instructions

## Comments

Default to zero code comments. Add a comment only when the reason is
non-obvious: an invariant, a workaround for a specific bug, a surprising
constraint, or behavior that would mislead a careful reader.

Do not write comments that restate what the code does, task-referential notes,
changelog notes, or multi-paragraph comment blocks. If removing the comment
would not confuse a future reader, do not write it.

## Secrets

Never read, print, or commit secret material:

- `.env` or `.env.*` files
- `id_rsa`, `id_ed25519`, `id_*` private keys, `*.pem`, or `*.key`
- Anything under `~/.ssh/`
- Cloud credential files, including `~/.aws/credentials`,
  `~/.config/gcloud/`, `*credentials*`, and service-account JSON

If a task appears to require reading or exposing any of the above, stop and
flag it to the user instead of proceeding. Warn explicitly before staging or
committing such files.

## Investigation Before Destruction

When something looks wrong or unexpected, investigate before deleting or
overwriting. It may be the user's in-progress work.

- Identify the root cause; fix the underlying issue rather than papering over it.
- Never use `rm`, `git reset --hard`, `git checkout --`, `git clean`, or bypass
  flags as a shortcut to make an obstacle disappear.
- Resolve merge conflicts; do not discard a side. If a lock exists, find the
  process holding it rather than removing it.
- Preserve user work and fix the root cause.
