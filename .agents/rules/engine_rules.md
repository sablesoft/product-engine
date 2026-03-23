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
- engine-wide rules are defined only in `.agents/rules/`
- product-wide rules are defined only in `products/<product_slug>/rules/`
- product-scoped rule files may exist only in `products/<product_slug>/rules/workspace/`
- local scoped rules may exist only as product-local files such as `products/<product_slug>/rules/workspace/<entity>/<slug>.md` and must not redefine engine-wide or product-wide invariants
- product-specific logic belongs in `products/<product_slug>/`

---

## Evolution Rule

- do not duplicate rules across files
- always reference rules instead of copying them
- dev-audit must validate rule adherence
- when performing an otherwise valid task, if you notice a small, directly relevant, and confidently fixable bug that blocks or degrades the requested workflow, fix it in the same pass instead of leaving it behind
- do not use this as a reason to bypass mode boundaries or to expand the task into an unrelated refactor

---

## Edit Freshness Rule

- before any file edit, reread the file's current version from disk
- do not rely on memory, earlier command output, or stale patch context when preparing an edit
- if a file has already been edited multiple times in the same pass or its structure has become unstable, prefer a clean full-file rewrite over additional partial patches

---

## Dev File Reference Rule

- in `dev`, when the assistant refers the user to a local file for inspection, prefer clickable terminal links over plain path mentions
- this applies to engine files, product files, and workspace files alike
- plain text paths may still appear as supporting detail, but the primary reference should be clickable
- clickable file-link labels in `dev` should be short and natural, usually just the file or entity name, without prefixes like `Open`
- terminal link preferences live in `state/terminal.yaml`, not in runtime
- commit defaults in `state/terminal.template.yaml`; keep concrete local preferences in the ignored local file
- if `state/terminal.yaml` indicates that OSC 8 works, OSC 8 output is the default and preferred file reference format across the engine
- if the local terminal preferences file is absent, use `state/terminal.template.yaml` as the fallback source of defaults
- when OSC 8 is the preferred format, do not rewrite file references as markdown links or bare paths unless the user explicitly asks for another format
- if `state/terminal.yaml` disables local fallback commands, do not append `open ...` fallback lines just because the platform allows them

---

## Mode Communication Rule

- `dev` is the only mode where frequent in-progress commentary is expected by default
- in non-dev modes, do not stream step-by-step implementation commentary to the user
- in `master`, `play`, and `ref`, send at most one short acknowledgement that the request is understood and being processed when the work is not instant
- after that acknowledgement, remain quiet until the result is ready unless a real blocker or decision is unavoidable
- final results may still be detailed when needed, but progress chatter belongs only to `dev`

---

## Temporary Artifact Rule

- temporary files created while working in this repository should go to the project-local `tmp/` directory by default
- prefer `tmp/` over system paths such as `/tmp` when the artifact is useful for the user to inspect from the repository root
- use system temporary paths only when a tool strictly requires them or when the artifact should not live in the repository tree
- if a temporary artifact becomes worth keeping, move it out of `tmp/` into its proper engine, product, or workspace location
