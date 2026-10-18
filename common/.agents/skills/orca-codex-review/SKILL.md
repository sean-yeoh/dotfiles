---
name: orca-codex-review
description: "Get a read-only code review from a Codex worker through Orca orchestration, then verify each finding. Use only when the user explicitly invokes this skill or asks for an Orca Codex review. Reviews uncommitted changes by default, or a branch, commit range, or PR when one is given."
disable-model-invocation: true
argument-hint: "[branch | commit range | PR number]"
---

# Orca Codex Review

## Scope and permissions

Act as the coordinator. Start one Codex worker in Orca, give it a review task, wait for its findings, and verify them. Do not review the changes yourself before the worker reports. An independent second opinion is the purpose of this skill.

The review is read-only. Neither the worker nor the coordinator may edit, stage, commit, push, or delete anything during the review. Apply fixes only when the user asks after the review.

Orca can start Codex workers without approvals or a sandbox. The task text is the only control on what the worker does, so always include the read-only rules from step 3.

Use the `orchestration` skill for exact `orca orchestration` commands and flags. Get its version-matched guide with `orca skills get orchestration --full`. Do not guess command syntax.

## Workflow

### 1. Check prerequisites

1. Run `orca status --json`. Confirm that the runtime is reachable.
2. Confirm that orchestration is enabled. If it is not, tell the user to enable it under Settings → Experimental, then stop.
3. Confirm that the current directory is inside an Orca worktree.

If a check fails, report the failure and stop.

### 2. Resolve the review target

1. With no argument, the target is the uncommitted changes in the current worktree: unstaged, staged, and untracked files.
2. With a branch, commit range, or PR number, the target is the committed diff of that ref against its base. Use the merge base with the default branch unless the user names another base.
3. Resolve a PR number to its head and base refs with `gh pr view`.
4. Inspect the target diff with `git diff --stat`. If the diff is empty, report that and stop.
5. For uncommitted targets, record `git status --porcelain` and a hash of `git diff HEAD` so you can verify in step 6 that nothing changed.

### 3. Start the worker

1. Create a Run whose objective names the review target.
2. Create one Task with the review spec below.
3. Start one worker with `--agent codex`:
   - For uncommitted changes, use `--worktree current`. A new worktree contains only committed files and cannot see the changes.
   - For a committed target, use a new child worktree, so the worker cannot affect the user's checkout.
4. If worker start fails, report the failure stage and error. Retry at most once. Do not retry a task that is near its failure limit. Create a new task instead.

Review spec template. Replace the angle-bracket fields:

```text
Review <target description> for correctness bugs, security issues, and data loss risks.
Get the diff with: <exact git diff command>
Read surrounding code as needed to confirm each issue.

Rules:
- Read-only. Do not edit, create, or delete files. Do not stage, commit, push, stash, or check out.
- Do not run commands that change state, such as installs, migrations, formatters, or code generators.
- Report only issues you can tie to a specific line. Do not report style preferences.

When done, send worker_done with --outcome succeeded. Put the findings in the body, one per line:
<file>:<line> | <high|medium|low> | <one-sentence reason>
If there are no findings, write "No findings".
If you cannot complete the review, send worker_done with --outcome failed and the reason.
```

### 4. Wait for the result

1. Wait for `worker_done`, `escalation`, and `question` messages with `orca orchestration check --wait`.
2. Answer a worker question only when the answer is in the review scope. Otherwise, ask the user.
3. Acknowledge each delivery after you handle it.
4. If the wait times out, read the worker terminal to find out why. Report the state to the user before you take further action.

### 5. Verify the findings

1. Parse each finding from the `worker_done` body.
2. For each finding, read the cited code and decide: confirmed, rejected, or uncertain.
3. Give a short reason for each decision. For a rejected finding, state the evidence that refutes it.
4. Do not add new findings of your own to the Codex list. If you notice a separate issue, report it in its own section.

### 6. Clean up and check

1. Release the worker.
2. Remove a child worktree only if this review created it.
3. For uncommitted targets, compare `git status --porcelain` and the diff hash with the values from step 2. If they differ, tell the user which files changed. Do not revert the changes yourself.

### 7. Report

1. State the review target and the worker outcome.
2. List the findings by severity with your decision and reason for each.
3. List separate coordinator observations, if any.
4. Report any cleanup or verification step that failed.

Stop after the report. Do not fix findings unless the user asks.
