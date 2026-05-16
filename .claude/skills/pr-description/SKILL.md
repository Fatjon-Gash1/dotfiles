---
name: pr-description
description: Write a pull request description from the actual diff. Triggers when the user asks to open a PR, draft a PR body, or fill in a PR description. Prefers the repo's own .github/PULL_REQUEST_TEMPLATE.md over the bundled fallback template; never auto-populates the body from commit messages alone.
---

# pr-description

Produce a PR description grounded in the diff, not in the conversation or the commit messages.

## Procedure

1. **Gather the real change set.** Run, in parallel:
   - `git rev-parse --abbrev-ref HEAD` — current branch
   - `git merge-base HEAD <base>` then `git diff <base>...HEAD --stat` and `git diff <base>...HEAD` — full branch diff vs. base (default base: `origin/main` or `origin/master`; ask if neither exists)
   - `git log <base>..HEAD --oneline` — commit list, for context only

   Read **all** commits in the range, not just the latest. A PR body that only reflects the tip commit is the failure mode this skill exists to prevent.

2. **Pick the template.** In order of preference:
   1. `.github/PULL_REQUEST_TEMPLATE.md` (or `.github/pull_request_template.md`, or any file under `.github/PULL_REQUEST_TEMPLATE/`)
   2. `docs/PULL_REQUEST_TEMPLATE.md`
   3. The bundled `template.md` next to this SKILL.md

   If the repo has its own template, use it verbatim — section names, ordering, checkboxes, HTML comments. Do not invent new sections or drop existing ones. If a section doesn't apply, write `N/A` rather than deleting it.

3. **Fill the template from the diff.**
   - **Summary**: 1–3 bullets describing *what changed and why*. Each bullet should map to something a reviewer can see in the diff. No restating file names.
   - **Test plan**: concrete steps a reviewer (or you) ran or should run. Prefer commands actually executed in this session. If nothing was tested, say so explicitly — don't fabricate.
   - **Risk / rollout / migration**: only if the diff touches migrations, public APIs, infra, auth, billing, or anything stateful. Otherwise omit or `N/A`.
   - **Linked issues**: if a commit message or branch name references `#123` / `PROJ-456`, include it. Don't guess.

4. **Title.** ≤72 chars, imperative mood, no trailing period. Match the repo's prevailing style (check `git log --oneline -20` on the base branch — Conventional Commits vs. plain prose).

5. **Do not** populate the PR body purely from `git log` output. Commit bodies feed history; PR bodies feed review. They are not the same artifact.

## End-to-end automation

When the user's intent is to *open or update* a PR (not just draft text), run the full flow in this order. Do not split it across multiple turns unless the user interrupts.

1. **Preflight** (parallel):
   - `gh --version` — fail clearly with an install hint (`sudo pacman -S github-cli && gh auth login`) if missing.
   - `git status --porcelain` — warn if there are uncommitted changes; ask before continuing.
   - `git rev-parse --abbrev-ref HEAD` and `git rev-parse --abbrev-ref --symbolic-full-name @{u} 2>/dev/null` — current branch + whether it has an upstream.
   - `gh pr view --json number,url,state 2>/dev/null` — does a PR already exist for this branch?

2. **Build the draft** per the Procedure section above (read full diff, pick template, fill from diff).

3. **Single approval gate.** Show the user:
   - The proposed title and body.
   - Whether this will `git push -u origin <branch>` (new branch) or just push updates.
   - Whether this will `gh pr create` (no PR yet) or `gh pr edit <n>` (PR exists).
   - The target base branch.

   Wait for explicit confirmation ("looks good", "go", "ship it"). Do not call `git push` or `gh` before this.

4. **Execute, back-to-back, after approval:**
   - `git push` (with `-u origin <branch>` if no upstream).
   - `gh pr create --title ... --body "$(cat <<'EOF' ... EOF)" --base <base>` **or** `gh pr edit <n> --body ...` if a PR already exists. Use a heredoc for the body to preserve formatting.
   - Print the PR URL from `gh`'s output.

5. **If anything fails** (push rejected, `gh` auth error, base branch missing) — stop, surface the error, do not retry blindly.

## Anti-patterns to refuse

- Writing the body before reading the full diff.
- Copy-pasting the latest commit message as the PR body.
- Inventing a "Test plan" with commands that were never run.
- Dropping sections from a repo-provided template because they feel redundant.
