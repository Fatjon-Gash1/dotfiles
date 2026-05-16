# Investigation before destruction

When something looks wrong or unexpected — an unfamiliar file, a lock file, a
merge conflict, a dirty tree, surprising state — investigate before deleting or
overwriting. It may be the user's in-progress work.

- Identify the root cause; fix the underlying issue rather than papering over it.
- Never use `rm`, `git reset --hard`, `git checkout --`, `git clean`, or
  bypass flags (`--no-verify`, `--force`) as a shortcut to make an obstacle
  disappear.
- Resolve merge conflicts; don't discard a side. If a lock exists, find the
  process holding it rather than removing it.
- Root cause > workaround. Measure twice, cut once.
