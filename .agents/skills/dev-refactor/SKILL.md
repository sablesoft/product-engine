---
name: dev-refactor
description: Use this skill when the user wants to modify the engine, update AGENTS, change skills, restructure folders, update the runtime model, or introduce new concepts. Triggers on requests like "update", "rewrite", "add", "split", "introduce".
---

# Purpose

Apply concrete changes to the engine.

This includes:
- AGENTS.md updates
- SKILL.md updates
- assets changes
- runtime template changes
- structure refactors

# Read before acting

- `AGENTS.md`
- `state/runtime.template.yaml`
- `.agents/rules/engine_rules.md`
- `.agents/rules/architecture_rules.md`
- `.agents/rules/runtime_rules.md`
- `.agents/rules/product_rules.md`
- `.agents/rules/layer_rules.md`
- `.agents/rules/naming_rules.md`
- `.agents/rules/skill_rules.md`
- relevant `.agents/skills/**`
- `./assets/refactor_checklist.md`

# Behavior

1. Understand the requested change.
2. Identify impacted parts:
    - AGENTS
    - skills
    - runtime
    - assets
    - rules
3. Apply the smallest consistent change.
4. Ensure:
    - no stale references remain
    - naming is consistent
    - routing still works
    - updated files still follow engine rules

# Constraints

- do not leave broken links
- do not partially update contracts
- avoid unnecessary rewrites
- preserve working behavior when possible

# Output

- provide updated files
- keep explanation minimal
