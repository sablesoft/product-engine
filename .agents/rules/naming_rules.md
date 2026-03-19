# Naming Rules

## General

- use English for all engine-level naming
- use kebab-case for skill names
- use kebab-case for product slugs and mode names
- use snake_case for YAML fields

## Files

- SKILL.md → uppercase fixed
- assets → *.md or *.yaml

## Consistency

- never rename without updating references
- avoid plural inconsistencies

## Path Convention

Two path styles are allowed:

### 1. Project-root-relative (preferred for cross-file references)

Use for:
- AGENTS.md
- rules
- runtime
- cross-skill references

Example:
- `.agents/rules/engine_rules.md`
- `state/runtime.template.yaml`

---

### 2. Local-relative (`./`) (allowed for same-skill assets)

Use only for:
- assets inside the same skill folder

Example:
- `./assets/refactor_checklist.md`

---

## Restrictions

- do not use `./` outside the current skill
- do not mix interpretations inside one list
- do not use `../` at all

---

## Principle

Local paths are for readability.  
Root paths are for correctness.
