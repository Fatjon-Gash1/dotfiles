# Comments

Default to zero comments. Only write a comment when the *why* is non-obvious:
an invariant, a workaround for a specific bug, a surprising constraint, or
behavior that would mislead a careful reader.

Do not write:

- Comments explaining *what* the code does — well-named identifiers do that.
- Task-referential or changelog notes ("added for X", "fixes #123",
  "used by the Y flow", "removed old logic"). That context belongs in the
  commit message / PR, and rots as the code evolves.
- Multi-paragraph docstrings or multi-line comment blocks. One short line max.

If removing the comment would not confuse a future reader, don't write it.
