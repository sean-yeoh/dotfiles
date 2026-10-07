#!/bin/sh
# PreToolUse hook for Bash.
# Denies any command that references a secret file: .env, .env.*, *.pem, *.key, or a .ssh directory.
# Input: hook JSON on stdin. Output: a deny decision as JSON, or nothing.

cmd=$(/usr/bin/jq -r '.tool_input.command // empty')
[ -z "$cmd" ] && exit 0

# A dot-name must not be preceded by a word character, so "process.env" does not match.
pattern='(^|[^[:alnum:]_])\.(env|ssh)($|[^[:alnum:]_])|\.(pem|key)($|[^[:alnum:]_])'

if printf '%s' "$cmd" | grep -Eq "$pattern"; then
  /usr/bin/jq -n '{
    hookSpecificOutput: {
      hookEventName: "PreToolUse",
      permissionDecision: "deny",
      permissionDecisionReason: "Blocked by ~/.claude/hooks/deny-secret-paths.sh: the command references a secret file (.env, .env.*, *.pem, *.key, or .ssh)."
    }
  }'
fi
exit 0
