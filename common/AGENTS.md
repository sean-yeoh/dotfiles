# Global Agent Instructions

- Use the `asd-ste100` skill for all explanations, instructions, progress updates, and summaries written for the user. Use STE-flavored mode for explanations and strict mode for step-by-step instructions. Keep sentences short, use consistent terms, and preserve technical meaning, conditions, and uncertainty.
- Never add the agent's name as a co-author in commit messages.
- Never use Unicode em dashes. Use a plain hyphen "-" instead.
- Never manually modify `CHANGELOG.md` files.
- Never manually modify files marked as auto-generated.
- When making technical decisions, prioritize correctness, simplicity, robustness, and long-term maintainability over implementation speed or development cost. Design for scalability appropriate to the requirements; avoid speculative complexity.
- Before introducing a new pattern or abstraction, search the codebase for an existing approach and prefer consistency with established patterns.
- Do not modify unrelated code unless it is necessary to correctly complete the requested change.
- Only add comments when the code is not self-explanatory. Explain non-obvious reasoning, constraints, or workarounds; do not restate what the code does. Prefer clear naming and structure over explanatory comments. Keep necessary comments concise.
- When fixing a bug:
  1. Attempt to reproduce the bug before implementing a fix. If reproduction is blocked, explain the limitation and investigate using available evidence.
  2. For user-facing bugs, reproduce it in an E2E setting whenever practical.
  3. Identify the root cause, or clearly state the best-supported hypothesis, before implementing the fix.
  4. Verify the fix using the same reproduction when practical.
  5. Add or update a regression test when appropriate.
