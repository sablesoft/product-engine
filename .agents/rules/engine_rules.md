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

---

## Dev File Reference Rule

- in `dev`, when the assistant refers the user to a local file for inspection, prefer clickable terminal links over plain path mentions
- this applies to engine files, product files, and workspace files alike
- plain text paths may still appear as supporting detail, but the primary reference should be clickable
- clickable file-link labels in `dev` should be short and natural, usually just the file or entity name, without prefixes like `Open`

---

## Temporary Artifact Rule

- temporary files created while working in this repository should go to the project-local `tmp/` directory by default
- prefer `tmp/` over system paths such as `/tmp` when the artifact is useful for the user to inspect from the repository root
- use system temporary paths only when a tool strictly requires them or when the artifact should not live in the repository tree
- if a temporary artifact becomes worth keeping, move it out of `tmp/` into its proper engine, product, or workspace location
