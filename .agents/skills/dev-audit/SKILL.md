---
name: dev-audit
description: Use this skill when the user wants to validate the system, find inconsistencies, stale references, duplicated logic, or architectural issues. Triggers on requests like "check", "audit", "are there issues", "where are the gaps", "is everything consistent".
---

# Purpose

Audit the engine for consistency and integrity.

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
- `.agents/skills/**`
- `products/**`
- `./assets/audit_checklist.md`
- `./assets/common_failures.md`

# Behavior

Check for:

- stale file references
- missing assets
- duplicated logic between AGENTS and skills
- broken routing
- incorrect runtime usage
- layer violations
- engine/product boundary violations
- naming inconsistencies
- violations of engine rules

Examples of rule violations include:

- SKILL.md files containing non-engine-language examples
- mixed language usage inside engine assets
- runtime storing forbidden per-run state
- product-local modes or skills defined in engine root
- duplicated global rules copied into skills or local assets

# Output

Group findings into:

1. Critical issues
2. Structural issues
3. Minor cleanup issues

Then suggest short, concrete fixes.

# Constraints

- do not modify files
- do not over-engineer
- focus on real problems only
