---
name: dev-file-link
description: Use this skill when the user wants clickable terminal links for workspace or engine files during development, review, or debugging. Triggers on requests like "show the file link", "give me a clickable path", "open this file from the terminal", "link this artifact".
---

# Purpose

Emit terminal-friendly clickable links for files so development artifacts can be opened directly from terminal output.

Engine-level entry points:

- `ruby scripts/file-link --path ...`
- `ruby scripts/image-link --path ...`

# Read before acting

- `AGENTS.md`
- `state/runtime.yaml`
- `.agents/rules/skill_rules.md`
- `.agents/rules/product_rules.md`
- relevant product `AGENTS.md` when a product file is involved

# Behavior

1. Resolve the target file path.
2. Confirm the file exists before emitting the link.
3. Prefer an OSC 8 clickable `file://` link to the absolute path.
4. On macOS, also provide a ready `open /absolute/path` fallback command when useful.
5. Keep output lightweight so it can appear inline with dev workflow results.
6. Use `scripts/file-link` for generic files and `scripts/image-link` for image-specific terminal behavior.
7. If a product has additional image workflows such as saving previews back into cards, keep that product-specific behavior outside this engine skill.

# Constraints

- do not invent file paths
- do not emit a link to a file that does not exist
- do not duplicate product-specific preview-placement logic inside the engine skill
- do not mutate runtime or product data just to show a file link

# Output

1. resolved file path
2. clickable terminal link
3. optional local fallback command when useful
