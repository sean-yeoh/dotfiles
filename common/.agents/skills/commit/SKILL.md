---
name: commit
description: "Create Git commits for the current task while preserving unrelated work. Use when the user asks to commit changes, stage task changes, prepare a commit message, or split current-task work into commits. Follow repository commit conventions."
---

# Commit

## Scope and permissions

Commit only changes attributable to the current task in the conversation. Do not treat all modified files as task changes.

A request for a commit message permits inspection and message preparation only. A request to stage changes does not authorize a commit.

Do not amend commits, rewrite history, push, or bypass hooks unless the user explicitly requests that action. Never add the agent as a co-author.

Do not refactor code or fix unrelated failures to make a commit succeed.

## Workflow

For message-only requests, inspect the changes and prepare the message without modifying the index or creating a commit. For staging-only requests, stage and review the selected changes, then stop before committing.

### 1. Inspect the repository

1. Read the applicable repository instructions.
2. Review recent commit messages with `git log -10 --format=full`.
3. Follow explicit repository instructions first, then the established message style, format, and conventions.
4. Inspect the working tree with `git status --short`.
5. Inspect unstaged changes with `git diff` and staged changes with `git diff --cached`.
6. Inspect relevant untracked files before selecting them.

Use `git diff --stat` when a summary helps navigate a large diff. Inspect the actual changes before deciding what belongs.

Do not require Conventional Commits unless the repository requires or consistently uses them. Read available instructions before asking about message rules.

### 2. Identify task changes

1. Map the current task to its files and hunks using the conversation and the inspected changes.
2. Include related tests, documentation, and configuration when they belong to the task.
3. Exclude unrelated edits, secrets, local configuration, and incidental generated files.
4. Ask a focused question if ownership is uncertain or task changes overlap unrelated changes that cannot be separated safely.

A change in a task-related file is not automatically in scope. Do not infer ownership from the file name alone.

Keep related implementation and tests together. Use multiple commits only when each commit forms a coherent change within the current task. Unrelated work is excluded, not assigned to additional commits.

### 3. Prepare the exact commit contents

1. Record which changes were already staged before modifying the index.
2. Stage explicit paths only when every change in each path belongs to the task.
3. Use patch staging, such as `git add -p -- <path>`, for mixed files.
4. Inspect the exact candidate diff before committing.

Do not use blanket staging commands such as `git add .`, `git add -A`, or `git commit -a`.

Preserve unrelated working-tree content and its original staged or unstaged state. Do not discard changes or use a stash as a shortcut.

A normal `git commit` includes all staged changes, including changes staged before this task. Selective staging alone does not exclude them.

If unrelated changes are already staged, use a safely isolated index or another verified method that preserves their staged state. For an isolated index, base the candidate on `HEAD` and apply only the selected task changes. After a successful commit, reconcile task entries in the original index with the new `HEAD` while preserving unrelated staged hunks. Handle an unborn branch with an empty candidate index instead.

An isolated index does not isolate the working tree. Before using it, account for hooks that read or modify working-tree files. Preserve an exact backup of the original index before changing it. Record unrelated staged and unstaged changes, including changes within mixed files, so you can verify their preservation. Verify that reconciliation preserves these changes. If you cannot preserve and reconcile these changes safely, stop and ask how to proceed. Do not blindly restore the original index after a successful commit, because `HEAD` has changed.

Do not use a path-only commit for a mixed file. It can include unstaged, unrelated changes from that file.

If the available tools cannot preserve the staging state safely, stop and explain the conflict. Ask the user how to proceed.

### 4. Review and verify

1. Review `git diff --cached` against the index that will supply the commit.
2. Check for unrelated changes, secrets, accidental debug output, and incidental formatting changes.
3. Check that new files, deletions, and renames belong to the task.
4. Run the smallest meaningful checks for the selected changes, following repository requirements.
5. State any verification limitation or failure accurately.

Checks on a mixed working tree can pass because of changes excluded from the commit. Verify the candidate contents in isolation when that dependency is plausible. Otherwise, report that limitation.

If required checks fail, do not bypass them. Investigate task-related failures within the authorized scope. Report unrelated failures rather than fixing them silently.

If no task changes remain, report that fact. Do not create an empty commit.

### 5. Write the message and commit

1. Summarize the selected changes and their purpose before writing the message.
2. Write a message that follows the repository's established conventions.
3. Describe only changes included in this commit.
4. Add a body when it explains non-obvious motivation, constraints, or breaking changes.
5. Create the commit only when the user's request authorizes it.

Do not guess the motivation for a change. Use the task context and inspected evidence.

If a hook fails, inspect the failure before retrying. Do not disable hooks or include unrelated fixes. After hooks run, check for file and index changes even if the commit succeeds. Review their scope before staging or committing anything further.

### 6. Check and report the result

1. Inspect the resulting commit to confirm its message and contents, including whether hooks introduced unintended changes.
2. Check the remaining working tree and staging area.
3. Confirm that unrelated changes retain their content and original staging state.
4. Report the commit hash, message, and verification results.
5. Identify any task changes left uncommitted and explain why.

For multiple commits, report each commit separately. Stop when the authorized task changes are committed, even if unrelated changes remain in the working tree or index.
