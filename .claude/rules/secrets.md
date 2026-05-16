# Secrets

Never read, print, or commit secret material:

- `.env` / `.env.*` files
- `id_rsa`, `id_ed25519`, `id_*` private keys, `*.pem`, `*.key`
- Anything under `~/.ssh/`
- Cloud credential files: `~/.aws/credentials`, `~/.config/gcloud/`,
  `*credentials*`, service-account JSON

If a task appears to require reading or exposing any of the above, stop and
flag it to the user instead of proceeding. Warn explicitly before staging or
committing such files.
