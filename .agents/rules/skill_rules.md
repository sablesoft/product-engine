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
- embedded product-local skills live in `products/<product_slug>/skills/`
- toolkit product installable skills live in top-level skill folders directly under `products/<product_slug>/`
- do not place product-local skills in `.agents/skills/`
- do not place engine-native skills inside products
- do not make a toolkit skill depend on shared sibling folders outside its own skill directory when it is meant to ship through `skill-installer`
- when a toolkit skill is meant to ship through `skill-installer`, keep its installed version in a `VERSION` file inside the skill folder

## Skill and dictionary alignment

- when a skill creates or edits product workspace cards, it should use the product's dictionary source of truth for workspace-facing labels when such a dictionary exists
- do not introduce new hard-coded localized section headers into scripts or templates when the product already defines a dictionary workflow
- when a skill changes workspace card templates, it should update the corresponding dictionary entries at the same time

## Skill granularity for promotion

- if a product already has a promotion workflow, extend that workflow before creating a new skill for a closely related scope-transfer case
- create a separate skill only when the new workflow has meaningfully different inputs, review requirements, or execution phases

## Principle

One skill = one workflow.
