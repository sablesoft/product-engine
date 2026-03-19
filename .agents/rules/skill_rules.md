# Skill Rules

## Skill responsibility

Each skill must:

- solve one clear workflow
- belong to one mode
- define boundaries
- belong to one owning scope

## SKILL.md must contain

- Purpose
- Read before acting
- Behavior
- Constraints
- Output

## Prohibitions

- no duplication of AGENTS logic
- no duplication of rules
- no vague multi-purpose skills

## Skill scope

- engine-native skills live in `.agents/skills/`
- product-local skills live in `products/<product_slug>/skills/`
- do not place product-local skills in `.agents/skills/`
- do not place engine-native skills inside products

## Principle

One skill = one workflow.
