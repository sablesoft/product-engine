# Engine Rules

## Language Invariant

- engine_language defines the language of:
    - all SKILL.md files
    - all AGENTS instructions
    - all examples and trigger phrases
    - all asset templates

- user_language must never appear inside:
    - SKILL instructions
    - routing hints
    - engine-level examples

- content_language is used only for generated product content

---

## Structural Invariant

- AGENTS.md must remain thin
- workflow logic belongs only in SKILL.md
- assets contain templates, not behavior
- rules are defined only in `.agents/rules/`
- product-specific logic belongs in `products/<product_slug>/`

---

## Evolution Rule

- do not duplicate rules across files
- always reference rules instead of copying them
- dev-audit must validate rule adherence
