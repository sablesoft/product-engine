# Architecture Rules

## Responsibility boundaries

- rules define global invariants and how the engine must behave
- engine-native skills define engine workflows and how to perform them
- products define domain-specific modes, skills, assets, and workspaces
- assets support skills and must not redefine global behavior

---

## Asset vs Rule separation

If a concept answers:

- "how the system should be structured"
- "what is globally allowed or forbidden"
- "what invariant must always hold"

→ it belongs in `rules/`

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
