# Architecture Rules

## Responsibility boundaries

- rules define global invariants and how the engine must behave
- engine-native skills define engine workflows and how to perform them
- products define domain-specific modes, skills, assets, and workspace structure
- assets support skills and must not redefine global behavior

---

## Asset vs Rule separation

If a concept answers:

- "how the system should be structured"
- "what is globally allowed or forbidden"
- "what invariant must always hold"

→ it belongs in `rules/`

If a concept answers:

- "what is always true in this one specific workspace"
- "what local canon or play boundaries apply only to this world or adventure"

→ it belongs in the product rule layer as a local scoped rule file such as `rules/workspace/<entity>/<slug>.md`

If a concept answers:

- "what is always true for every workspace of this product workspace type"
- "what defaults should all entities of this type inherit"

→ it belongs in the product's workspace-type global rules layer

If a concept answers:

- "how this skill performs its task"
- "what structure this output should have"
- "what checklist to follow locally"

→ it belongs in `assets/`

---

## Anti-pattern

An asset that:
- defines architecture
- redefines layers
- introduces global constraints

is incorrectly placed and must be moved to `rules/`.

---

## Principle

Rules are the source of truth.  
Assets are local helpers.
