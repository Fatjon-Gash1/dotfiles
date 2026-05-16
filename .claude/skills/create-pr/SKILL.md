---
name: create-pr
description: Create a GitHub PR for the already-pushed branch using the gh CLI, with a title and body grounded in the actual diff. Triggers when the user or an agent asks to "create the PR", "open a PR", or "raise a PR" after pushing a branch (e.g. once internal code review passes). Drafts the body from the diff — never from commit messages alone — then creates the PR directly via gh; no manual copy-paste, no approval gate.
---

# create-pr

The branch is already pushed (by the user or by an agent after internal code review passes). This skill's job is to draft a PR title and body from the real diff and create the PR via the `gh` CLI in one shot. The human edits the PR afterward for reviewers, labels, milestones, etc. — that part is intentionally out of scope.

No approval gate: draft, then create. Do not ask for confirmation before `gh pr create`.

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

## Creating the PR

Run the full flow in one turn. No confirmation step.

1. **Preflight** (parallel):
   - `gh --version` — fail clearly with an install hint (`sudo pacman -S github-cli && gh auth login`) if missing.
   - `git rev-parse --abbrev-ref HEAD` and `git rev-parse --abbrev-ref --symbolic-full-name @{u} 2>/dev/null` — current branch + whether it has an upstream.
   - `gh pr view --json number,url,state 2>/dev/null` — does a PR already exist for this branch?
   - `git status --porcelain` — if there are uncommitted changes, note them in your final message (they won't be in the PR), but do not block.

2. **Ensure the branch is on the remote.** The branch is expected to be pushed already. Only as a fallback: if there is no upstream, run `git push -u origin <branch>`. If an upstream exists, do not push — assume the caller already did. Never force-push.

3. **Build the draft** per the Procedure section above (read full diff, pick template, fill from diff).

4. **Create or update the PR, immediately:**
   - No existing PR → `gh pr create --title ... --body "$(cat <<'EOF' ... EOF)" --base <base>`. Use a heredoc for the body to preserve formatting.
   - PR already exists for the branch → `gh pr edit <n> --title ... --body ...` (refresh title/body from the current diff).
   - Print the resulting PR URL from `gh`'s output as the final line.

5. **If anything fails** (push rejected, `gh` auth error, base branch missing, no upstream and push fails) — stop, surface the exact error, do not retry blindly. Do not fall back to printing the body for manual paste unless `gh` itself is unavailable.

## Out of scope

Assigning reviewers, labels, milestones, projects, or marking ready/draft. The human does this on GitHub after the PR exists. Don't add `--reviewer`/`--label`/`--draft` flags unless explicitly asked in the invocation.

## Anti-patterns to refuse

- Writing the body before reading the full diff.
- Copy-pasting the latest commit message as the PR body.
- Inventing a "Test plan" with commands that were never run.
- Dropping sections from a repo-provided template because they feel redundant.
- Asking for human approval before creating the PR — this skill is explicitly non-gated so agents can call it autonomously after internal review.
